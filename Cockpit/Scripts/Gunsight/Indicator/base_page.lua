dofile(LockOn_Options.script_path.."Gunsight/Indicator/definitions.lua")
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path .."elements_defs.lua")
dofile(LockOn_Options.script_path.."Gunsight/Indicator/indication_page.lua")

local sc = 1 / GetScale()
--print_message_to_user(sc)
--print_message_to_user(1/sc)
--sc=1.0
local function vtx(x_blender,y_blender)	return {x_blender * sc,y_blender*sc} end

local ClippingMaskGlobal 	= MakeMaterial(nil,{232,51,0,150}) 
local ClippingMaskSpecial 	= MakeMaterial(nil,{0,159,229,150}) 
local SHOW_MASKS 			= true

local hud_offset_x = 0.0
local hud_offset_y = 0.0



gunsight_glass_clipping_mask				= CreateElement "ceMeshPoly"
gunsight_glass_clipping_mask.name			= create_guid_string()
gunsight_glass_clipping_mask.primitivetype	=	"triangles"

gunsight_glass_clipping_mask.vertices		= {
    vtx(-0.0125, -0.00544),
    vtx(0.0125, -0.00544),
    vtx(0.0125, 0.00544),
    vtx(-0.0125, 0.00544),
    vtx(-0.01226, -0.00788),
    vtx(0.01226, -0.00788),
    vtx(-0.01155, -0.01022),
    vtx(0.01155, -0.01022),
    vtx(-0.01039, -0.01238),
    vtx(0.01039, -0.01238),
    vtx(-0.00884, -0.01428),
    vtx(0.00884, -0.01428),
    vtx(-0.00694, -0.01583),
    vtx(0.00694, -0.01583),
    vtx(-0.00478, -0.01699),
    vtx(0.00478, -0.01699),
    vtx(-0.00244, -0.0177),
    vtx(0.00244, -0.0177),
    vtx(-0.0, -0.01794),
    vtx(0.01226, 0.00788),
    vtx(-0.01226, 0.00788),
    vtx(0.01155, 0.01022),
    vtx(-0.01155, 0.01022),
    vtx(0.01039, 0.01238),
    vtx(-0.01039, 0.01238),
    vtx(0.00884, 0.01428),
    vtx(-0.00884, 0.01428),
    vtx(0.00694, 0.01583),
    vtx(-0.00694, 0.01583),
    vtx(0.00478, 0.01699),
    vtx(-0.00478, 0.01699),
    vtx(0.00244, 0.0177),
    vtx(-0.00244, 0.0177),
    vtx(-0.0, 0.01794),
}
--triangles to be drawn from vertices (points) to fill the HUD-Glass
gunsight_glass_clipping_mask.indices			= 
{0, 1, 2,
0, 2, 3,
1, 0, 4,
1, 4, 5,
6, 7, 5,
6, 5, 4,
8, 9, 7,
8, 7, 6,
10, 11, 9,
10, 9, 8,
12, 13, 11,
12, 11, 10,
14, 15, 13,
14, 13, 12,
16, 17, 15,
16, 15, 14,
18, 17, 16,
3, 2, 19,
3, 19, 20,
20, 19, 21,
20, 21, 22,
22, 21, 23,
22, 23, 24,
24, 23, 25,
24, 25, 26,
26, 25, 27,
26, 27, 28,
28, 27, 29,
28, 29, 30,
30, 29, 31,
30, 31, 32,
33, 32, 31,}

gunsight_glass_clipping_mask.init_pos		= {0.0, 0.0, 0.0} 
gunsight_glass_clipping_mask.material		= ClippingMaskSpecial
gunsight_glass_clipping_mask.h_clip_relation	= h_clip_relations.REWRITE_LEVEL --REWRITE_LEVEL das ist h_clip_level Nr. 2
gunsight_glass_clipping_mask.level			= HUD_DEFAULT_LEVEL - 1 
gunsight_glass_clipping_mask.change_opacity	= false
gunsight_glass_clipping_mask.collimated		= false
gunsight_glass_clipping_mask.isvisible		= false 
Add(gunsight_glass_clipping_mask)

cockpit_base_clipping_mask					= CreateElement"ceMeshPoly"
cockpit_base_clipping_mask.name				= create_guid_string()
cockpit_base_clipping_mask.primitivetype	= "triangles"
cockpit_base_clipping_mask.vertices			= {{-500.0, 500.0}, {-500.0, -500.0}, {500.0, -500.0}, {500.0, 500.0},}
cockpit_base_clipping_mask.indices			= {0,1,3,  1,2,3}
cockpit_base_clipping_mask.init_pos			= {0.0, 0.0, 0.0}
cockpit_base_clipping_mask.material			= ClippingMaskGlobal
cockpit_base_clipping_mask.h_clip_relation	= h_clip_relations.INCREASE_IF_LEVEL --INCREASE_IF_LEVEL ist Level 4
cockpit_base_clipping_mask.level			= HUD_DEFAULT_LEVEL - 1
cockpit_base_clipping_mask.change_opacity	= false
cockpit_base_clipping_mask.collimated		= false
cockpit_base_clipping_mask.isvisible		= false --erstmal zum testen, dann auf false
Add(cockpit_base_clipping_mask)



local gunsight_corrected		= CreateElement "ceSimple"
gunsight_corrected.name  					= create_guid_string()
gunsight_corrected.init_pos				= {0.0, 0.0, 0.0}
gunsight_corrected.element_params 		= { 
    "GUNSIGHT_POWER" , 
    "DEPRESSION_CORRECTION",
    
}  -- Only enable gunsight if power in bus
gunsight_corrected.controllers    		= {
    {"parameter_in_range" ,0, 0.9, 1.1},
    {"move_up_down_using_parameter", 1.0,1.0/sc},
    }
AddHudElement(gunsight_corrected)

local gunsight_base		= CreateElement "ceSimple"
gunsight_base.name  					= create_guid_string()
gunsight_base.init_pos				= {0.0, 0.0, 0.0}

gunsight_base.element_params 		= { 
    "GUNSIGHT_POWER" , 
    "GUN_DEPRESSION",
}  -- Only enable gunsight if power in bus
gunsight_base.controllers    		= {
    {"parameter_in_range" ,0, 0.9, 1.1},
    {"move_up_down_using_parameter", 1,1.0/sc},
    }
gunsight_base.parent_element      = gunsight_corrected.name
AddHudElement(gunsight_base)


AddGunSight(gunsight_base.name)
AddFixedSight(gunsight_corrected.name)
