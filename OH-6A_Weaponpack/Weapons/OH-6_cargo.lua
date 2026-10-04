local wsType_ammo = 11120
local wsType_crates = 11121
local wsType_pax = 11122
local wsType_animals = 11123
local wsType_cans = 11124
local wsType_pigs = 11125
local wsType_soldiers = 11126
local wsType_operator = 11127
local function cargo(main)
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
		Elements  		= 
        {
			{
				ShapeName	= main.shape,
				Position	= {0,	0, 0},
				IsAdapter	= true,
			},
        }})
end

cargo(
	{user_name = _("Cargo Ammo"), 
	clsid = "{OH-6_CARGO_AMMO}",  
	count = 1,
	mass = 200,
	wstype = {4, 4, 8, wsType_ammo},
    shape = "oh6_cargo_ammo",
	icon = "icon_AmmoBox.png"})

cargo(
	{user_name = _("Cargo Crates"), 
	clsid = "{OH-6_CARGO_CRATES}",  
	count = 1,
	mass = 150,
	wstype = {4, 4, 8, wsType_crates},
    shape = "oh6_cargo_crates",
	icon = "icon_Box.png"})

cargo(
    {user_name = _("Cargo PAX"), 
    clsid = "{OH-6_CARGO_PAX}",  
    count = 1,
    mass = 240,
    wstype = {4, 4, 8, wsType_pax},
    shape = "oh6_cargo_pax",
    icon = "icon_passengers.png"})

cargo(
	{user_name = _("Cargo Animals"), 
	clsid = "{OH-6_CARGO_ANIMAL}",  
	count = 1,
	mass = 200,
	wstype = {4, 4, 8, wsType_animals},
	shape = "oh6_cargo_animals",
	icon = "icon_animals.png"})

cargo(
	{user_name = _("Cargo Jerrycans"), 
	clsid = "{OH-6_CARGO_CANS}",  
	count = 1,
	mass = 150,
	wstype = {4, 4, 8, wsType_cans},
	shape = "oh6_cargo_jerrycans",
	icon = "icon_jerrycan.png"})

cargo(
	{user_name = _("Cargo Pigs"), 
	clsid = "{OH-6_CARGO_PIGS}",  
	count = 1,
	mass = 150,
	wstype = {4, 4, 8, wsType_pigs},
	shape = "oh6_cargo_pigs",
	icon = "icon_pigs.png"})

cargo(
	{user_name = _("Cargo Soldiers"), 
	clsid = "{OH-6_CARGO_SOLDIERS}",  
	count = 1,
	mass = 350,
	wstype = {4, 4, 8, wsType_soldiers},
	shape = "oh6_cargo_soldiers",
	icon = "icon_soldiers.png"})
	
cargo(
	{user_name = _("Cargo Operator"), 
	clsid = "{OH-6_CARGO_OPERATOR}",  
	count = 1,
	mass = 180,
	wstype = {4, 4, 8, wsType_operator},
	shape = "oh6_cargo_operator",
	icon = "icon_operator.png"})	
	
