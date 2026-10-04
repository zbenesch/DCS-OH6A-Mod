dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua") 

--SetScale(MILLYRADIANS)

indicator_type      = indicator_types.COLLIMATOR  -- COMMON, COLLIMATOR, HELMET
init_pageID     	= 1 --
purposes 	   		= {render_purpose.GENERAL} -- GENERAL,HUD_ONLY_VIEW,SCREENSPACE_INSIDE_COCKPIT,SCREENSPACE_OUTSIDE_COCKPIT,GROUND_UNIT_OPERATOR,GROUND_UNIT_OPERATOR_SCREENSPACE
--subset ids
BASE    			= 1
--INDICATION 			= 2 --eingetragen, war vorher auskommentiert

page_subsets  		= {
[BASE]    			= LockOn_Options.script_path.."/Gunsight/Indicator/base_page.lua",
}

pages = 
{
	{
	 BASE,
	 },
}

collimator_default_distance_factor = {0.15,0,0} --before it was 0.15, 0, 0
dynamically_update_geometry = true
set_origin_to_cockpit_shape=true
update_screenspace_diplacement(SelfWidth/SelfHeight,true)
dedicated_viewport_arcade = dedicated_viewport