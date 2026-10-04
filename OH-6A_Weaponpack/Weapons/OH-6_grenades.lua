--dofile("Scripts/Database/Weapons/warheads.lua")

local wsType_RedSmoke = 11100
local wsType_GreenSmoke = 11101
local wsType_BlueSmoke = 11102
local wsType_YellowSmoke = 11103
local wsType_FragGrenate = 11104

local function declare_GRENADES(main, warhead, picture, clsid, count,wstype)
	local t = main
	t.category			= CAT_BOMBS
	t.wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, wstype}
	t.type				= 0
	t.hMin				= 0.0
	t.hMax				= 10000.0
	t.VyHold			= -100.0
	t.Ag      			= -1.23
	t.mass		= 0.00
	t.Cx			= 0*0.0035

	t.fm =
	{
		mass		= 0.015,
		caliber		= 0.05,
		cx_coeff	= {1.0, 0.29, 0.71, 0.14, 1.28},
		L			= 0.15,
		I			= 1.0,
		cx_factor	= 0.0,
		wind_time	= 1000.0,
		wind_sigma	= 8.0,
	}

	t.targeting_data =
	{
		char_time = 20.32,
	}

	t.shape_table_data =
	{
		{
			name     = t.name,
			file     = t.model,
			life     = 1,
			fire     = {0, 1},
			username = t.user_name,
			index    = wstype,
		},
	}

	t.warhead = warhead
	declare_weapon(t)
	
	declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= clsid,
	attribute		= t.wsTypeOfWeapon,
	Count 			= count,
	Cx_pil			= t.Cx,
	Picture			= picture,
	displayName		= t.displayName or t.user_name,
	Weight			= t.mass,
	--Elements  	= {{ShapeName = t.model}},
	Elements  		= {},
	})


	return t
end

function smokegrenade_warhead(color)
	warhead =
	{
		mass					= 0,
		expl_mass				= 0,
		piercing_mass			= 0,
		other_factors			= { 1, 1, 1},
		obj_factors				= { 1, 1 },
		concrete_factors		= { 1,1, 1},
		cumulative_factor		= 0.0,
		concrete_obj_factor		= 0.0,
		cumulative_thickness	= 0.0,
		caliber					= 0.1,
		transparency	= 0.5,
		color			= color,
		intensity		= 5,
		duration		= 300,
		flare   		= false,
	}	
	return warhead
end
	

local frag_warhead = {
        mass        = 2.0 ,
        expl_mass   = 1.0 ,
        other_factors = {1.0, 1.0, 1.0},
        obj_factors = {1, 1},
        concrete_factors = {1.0, 1.0, 1.0},
        cumulative_factor = 1,
        concrete_obj_factor = 1.0,
        cumulative_thickness = 1.0,
        piercing_mass = 1.0,
        caliber     = 0.05,
		}

local smokegrenade_warhead_red = smokegrenade_warhead({2,0,0})
local smokegrenade_warhead_green = smokegrenade_warhead({0,2,0})
local smokegrenade_warhead_blue = smokegrenade_warhead({0,0,2})
local smokegrenade_warhead_yellow = smokegrenade_warhead({2,2,0})

OH6_SMG_RED = declare_GRENADES(
{
	name		= "OH6_SMOKE_RED",
	model		= "OH-6_M18",
	user_name	= _("OH6_SMOKE_RED"),
	displayName	=  _("SMOKE Grenade RED"),
	scheme		= "bomb-smoke",
	class_name		= "wAmmunitionFuzeCtrl"
	}, smokegrenade_warhead_red, "icon_smoke_red.png", "{OH6_SMOKE_RED}",4,wsType_RedSmoke)

OH6_SMG_GREEN = declare_GRENADES(
{
	name		= "OH6_SMOKE_GREEN",
	model		= "OH-6_M18",
	user_name	= _("OH6_SMOKE_GREEN"),
	displayName	=  _("SMOKE Grenade Green"),
	scheme		= "bomb-smoke",
	class_name		= "wAmmunitionFuzeCtrl"
}, smokegrenade_warhead_green, "icon_smoke_green.png", "{OH6_SMOKE_GREEN}",4,wsType_GreenSmoke)

OH6_SMG_BLUE = declare_GRENADES(
{
	name		= "OH6_SMOKE_BLUE",
	model		= "OH-6_M18",
	user_name	= _("OH6_SMOKE_BLUE"),
	displayName	=  _("SMOKE Grenade Blue"),
	scheme		= "bomb-smoke",
	class_name		= "wAmmunitionFuzeCtrl"
}, smokegrenade_warhead_blue, "icon_smoke_blue.png", "{OH6_SMOKE_BLUE}",4,wsType_BlueSmoke)

OH6_SMG_YELLOW = declare_GRENADES(
{
	name		= "OH6_SMOKE_YELLOW",
	model		= "OH-6_M18",
	user_name	= _("OH6_SMOKE_YELLOW"),
	displayName	=  _("SMOKE Grenade yellow"),
	scheme		= "bomb-smoke",
	class_name	= "wAmmunitionFuzeCtrl"
}, smokegrenade_warhead_yellow, "icon_smoke_yellow.png", "{OH6_SMOKE_YELLOW}",4,wsType_YellowSmoke)


OH6_HE = declare_GRENADES(
{
	name		= "OH6_FRAG",
	type =0,
	model		= "OH-6_M18",
	user_name	= _("OH6_FRAG"),
	displayName	=  _("Frag Grenade"),
	scheme		= "bomb-common",
}, frag_warhead, "icon_frag.png", "{OH6_FRAG}",10, wsType_FragGrenate)