dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

 
SetScale(MILLYRADIANS)


DEGREE_TO_MRAD = 17.4532925199433
DEGREE_TO_RAD  = 0.0174532925199433
RAD_TO_DEGREE  = 57.29577951308233
MRAD_TO_DEGREE = 0.05729577951308233
MIL_TO_MRAD = 0.9817477042468

---------Das hier ist wichtig, weil es die Render-Level des Cockpit-Krams setzt------
HUD_DEFAULT_LEVEL = 2                               
HUD_DEFAULT_NOCLIP_LEVEL  = HUD_DEFAULT_LEVEL - 1  
-------------------------------------------------------------------------------------

----------diese Local-Funktion ist der default-generator für einen Kasten durch Indices(triangles)---
local box_indices =
{
	0,1,2;0,2,3
}


function AddHudElement(object)
	object.h_clip_relation  = h_clip_relations.COMPARE	--INCREASE_IF_LEVEL zuvor war es .COMPARE 
	object.level  		 	= HUD_DEFAULT_LEVEL --zuvor war es einfach HUD_DEFAULT_LEVEL 
    object.use_mipfilter    = true
	object.additive_alpha   = true
    object.collimated       = true
	object.blend_mode 		=  blend_mode.IBM_REGULAR_ADDITIVE_ALPHA --einfach mal auskommentiert, war vorher drin
    Add(object)
end


