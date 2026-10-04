dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetCustomScale(1.0)

local function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end

local whiteColor = {220,220,160,255}
local yellowColor = {220,220,0,255}
local backgroundColor = {30,30,30,100}
local fontWhite = MakeFont({used_DXUnicodeFontData = "baseFont"}, whiteColor)
local fontYellow = MakeFont({used_DXUnicodeFontData = "baseFont"}, yellowColor)

--fontdescription["font_Arial"],13, materials["WHITE"]

local aspect        = LockOn_Options.screen.aspect
local box_height	= 0.135
local box_width	= 0.8


local col1 = 0.1
local col2 = 0.3
local col3 = 0.6

local row1 = box_height-0.04
local row2 = box_height-0.1

base       			= CreateElement "ceMeshPoly"
base.name		    = "base"
base.primitivetype  = "triangles"
base.material       = MakeMaterial(nil,backgroundColor)
base.vertices       = {{0, 0},
                       {0,  box_height  }, 
                       { box_width,  box_height  },
                       { box_width, 0 }}        
base.indices        = default_box_indices
base.init_pos       = {(aspect -box_width),(-1)}
--base.init_pos       = {(0.5),(0.5)}
base.element_params = {"SHOW_CREW_GUI"} 
base.controllers    = {{"parameter_in_range", 0, 1}}
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level		     = 8
AddElement(base)


local roe			= CreateElement "ceStringPoly"
roe.name			= "roeText"
roe.material		= fontWhite
roe.stringdefs		= {0.004,0.004,-0.001,0.0001}
roe.init_pos		= {col1,row1,0}
roe.alignment		= "CenterCenter"
roe.value			= "ROE"
roe.parent_element	= base.name
AddElement(roe)


local burst			= CreateElement "ceStringPoly"
burst.name			= "burstText"
burst.material		= fontWhite
burst.stringdefs		= {0.004,0.004,-0.001,0.0001}
burst.init_pos		= {col2,row1,0}
burst.alignment		= "CenterCenter"
burst.value			= "BURST"
burst.parent_element	= base.name
AddElement(burst)

local grenades			= CreateElement "ceStringPoly"
grenades.name			= "grenadesText"
grenades.material		= fontWhite
grenades.stringdefs		= {0.004,0.004,-0.001,0.0001}
grenades.init_pos		= {col3,row1,0}
grenades.alignment		= "CenterCenter"
grenades.value			= "GRENADES"
grenades.parent_element	= base.name
AddElement(grenades)


local roeval 			= CreateElement "ceStringPoly"
roeval.name			= "roeValue"
roeval.material		= fontYellow
roeval.formats		= {"%s"}
roeval.stringdefs		= {0.004,0.004,-0.001,0.0001}
roeval.init_pos		= {col1,row2,0}
roeval.alignment		= "CenterCenter"
roeval.value			= ""
roeval.element_params = {"ROE_TEXT"}
roeval.controllers    = {{"text_using_parameter",0,0}}
roeval.parent_element	= base.name
AddElement(roeval)


local burstval 			= CreateElement "ceStringPoly"
burstval.name			= "burstValue"
burstval.material		= fontYellow
burstval.formats		= {"%s"}
burstval.stringdefs		= {0.004,0.004,-0.001,0.0001}
burstval.init_pos		= {col2,row2,0}
burstval.alignment		= "CenterCenter"
burstval.value			= ""
burstval.element_params = {"BURST_TEXT"}
burstval.controllers    = {{"text_using_parameter",0,0}}
burstval.parent_element	= base.name
AddElement(burstval)

local grenadesval 			= CreateElement "ceStringPoly"
grenadesval.name			= "grenadesValue"
grenadesval.material		= fontYellow
grenadesval.formats		= {"%s"}
grenadesval.stringdefs		= {0.004,0.004,-0.001,0.0001}
grenadesval.init_pos		= {col3,row2,0}
grenadesval.alignment		= "CenterCenter"
grenadesval.value			= ""
grenadesval.element_params = {"GRENADES_TEXT"}
grenadesval.controllers    = {{"text_using_parameter",0,0}}
grenadesval.parent_element	= base.name
AddElement(grenadesval)