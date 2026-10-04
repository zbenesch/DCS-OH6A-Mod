local wsType_camrig = 11109
local wsType_searchlight = 11110
local wsType_camman = 11111
local wsType_floaters = 11112
local function Special_Gear(main)
	local data = main
	declare_loadout({
		category 		= CAT_BOMBS,
		CLSID	 		= data.clsid,
		wsTypeOfWeapon	= data.wstype,
		attribute		= {4,	4,	32,	data.wstype[4]},
		Count 			= data.count,
		Cx_pil			= 0.0,
		Picture			= data.icon,
		displayName		= data.user_name,
		Weight			= data.mass,--120kg for container
		Elements  		= {}
    })
end

Special_Gear(
	{user_name = _("Camrig"), 
	clsid = "{OH-6_CAMRIG}",  
	count = 1,
	mass = 70,
	wstype = {4, 4, 8, wsType_camrig},
	icon = "icon_cam.png"})
Special_Gear(
	{user_name = _("Searchlight"), 
	clsid = "{OH-6_Searchlight}",  
	count = 1,
	mass = 70,
	wstype = {4, 4, 8, wsType_searchlight},
	icon = "icon_searchlight.png"})

Special_Gear(
	{user_name = _("Cameraman"), 
	clsid = "{OH-6_CAMMAN}",  
	count = 1,
	mass = 70,
	wstype = {4, 4, 8, wsType_camman},
	icon = "icon_camman.png"})

Special_Gear(
	{user_name = _("Floaters"),
	clsid = "{OH-6_FLOATERS}",
	count = 1,
	mass = 50,
	wstype = {4, 4, 8, wsType_floaters},
	icon = "icon_floats.png"})
	
