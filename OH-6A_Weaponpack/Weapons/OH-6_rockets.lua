local wsType_FFAR = 11108
local explosivePercent = 1.0

local OH6_FFAR = {
	category			= CAT_ROCKETS,
	name				= "OH6Rocket FFAR",
	user_name			= _("OH6Rocket FFAR"),
	wsTypeOfWeapon		= {wsType_Weapon,wsType_NURS,wsType_Rocket,wsType_FFAR},
	scheme 				= "nurs-standard",
	model 				= "ffar_mk4_m151he",

        fm = 
        {
            mass        = 7.7,   -- start weight, kg
            caliber     = 0.07, -- Caliber, meters 
            cx_coeff    = {1,1.889005,0.67,0.8173064,2.08},  -- Cx
            L           = 0.927, --Length, meters
            I           = 0.3913938, -- moment of inertia
            Ix          = 0.0017991, -- not used
            Ma          = 0.1316980, -- dependence moment coefficient of  by  AoA
            Mw          = 1.4351299, --  dependence moment coefficient by angular speed
            shapeName   = "",
            
            wind_time   = 0.575, -- dispersion coefficient
            wind_sigma  = 4.8, -- dispersion coefficient
            
            wing_unfold_time = 0.02, -- Unfold time, sec
        },

        engine =
        {
            fuel_mass   = 1.1, -- Fuel mass, kg
            impulse     = 690, -- Specific impulse, m/sec
            boost_time  = 0, -- Time of booster action
            work_time   = 1.10, -- Time of mid-flight engine action
            boost_factor= 1, -- Booster to cruise trust ratio
            nozzle_position =  {{-0.508, 0, 0}}, -- meters
			nozzle_orientationXYZ =  {{0, 0, 0}},
            tail_width  = 0.15, -- contrail thickness 
            boost_tail  = 1,
            work_tail   = 1,

            smoke_color = {0.9, 0.8, 0.7},
	    smoke_transparency = 0.20,
        },

	warhead	=
	{
	mass			= 7.7, --HEI heavy
    	expl_mass        = 2.2, 
    	other_factors    = { 1.0, 1.0, 1.0 },
    	concrete_factors = { 1.0, 1.0, 1.0 },
    	concrete_obj_factor = 0.0,
    	obj_factors      = { 1.0, 1.0 },
    	cumulative_factor= 3.0,
    	cumulative_thickness = 0.9,

	piercing_mass	= 1.54, --HEI [piercing_mass=warhead.mass, ma se (expl_mass/mass)>0.1 allora piercing_mass=mass/5, quindi 0,44/1.7=0,258  --> 1.7/5=0.34]
	},

	shape_table_data =
	{
		{
			file		 = "ffar_mk4_m151he",
			life		 = 1,
			fire		 = {0, 1},
			username = "M2 Rocket HEI",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	properties =
	{
    		dist_min = 350, -- min range, meters
    		dist_max = 4500,    -- max range, meters
	}
}
declare_weapon(OH6_FFAR)

declare_loadout(
{
	category 		= CAT_ROCKETS,
	CLSID 			= "{OH6_XM158}",
	attribute 		= {wsType_Weapon,wsType_NURS,wsType_Container,182}, --182 (lau-3)
	wsTypeOfWeapon	=	OH6_FFAR.wsTypeOfWeapon,	
	Picture 		= "M2RocketPod.png",
	displayName		= _("XM158 Weapon System (7)"),
	Weight 			= 46 + 7.7*7, 
	Count			=	7,
	Cx_pil			=	0.00159912109375,
	kind_of_shipping = 2,
	Elements = {
	
		{
			ShapeName	=	"OH-6_XM158", -- pod name
			IsAdapter = true,
		},

		{
			DrawArgs	= defaultArgs,
			connector_name = "tube_1",
			ShapeName	=	"ffar_mk4_m151he",
		},

		{
			DrawArgs	= defaultArgs,
			connector_name = "tube_2",
			ShapeName	=	"ffar_mk4_m151he",
		},

		{
			DrawArgs	= defaultArgs,
			connector_name = "tube_3",
			ShapeName	=	"ffar_mk4_m151he",
		},

		{
			DrawArgs	= defaultArgs,
			connector_name = "tube_4",
			ShapeName	=	"ffar_mk4_m151he",
		},

		{
			DrawArgs	= defaultArgs,
			connector_name = "tube_5",
			ShapeName	=	"ffar_mk4_m151he",
		},

		{
			DrawArgs	= defaultArgs,
			connector_name = "tube_6",
			ShapeName	=	"ffar_mk4_m151he",
		},

		{
			DrawArgs	= defaultArgs,
			connector_name = "tube_7",
			ShapeName	=	"ffar_mk4_m151he",
		},
	},
})

declare_loadout(
{
	category 		= CAT_ROCKETS,
	CLSID 			= "{OH6_XM158_4}",
	attribute 		= {wsType_Weapon,wsType_NURS,wsType_Container,182}, --182 (lau-3)
	wsTypeOfWeapon	=	OH6_FFAR.wsTypeOfWeapon,	
	Picture 		= "M2RocketPod.png",
	displayName		= _("XM158 Weapon System (4)"),
	Weight 			= 46 + 7.7*4, 
	Count			=	4,
	Cx_pil			=	0.00159912109375,
	kind_of_shipping = 2,
	Elements = {
	
		{
			ShapeName	=	"OH-6_XM158", -- pod name
			IsAdapter = true,
		},

		{
			DrawArgs	= defaultArgs,
			connector_name = "tube_1",
			ShapeName	=	"ffar_mk4_m151he",
		},

		{
			DrawArgs	= defaultArgs,
			connector_name = "tube_2",
			ShapeName	=	"ffar_mk4_m151he",
		},

		{
			DrawArgs	= defaultArgs,
			connector_name = "tube_3",
			ShapeName	=	"ffar_mk4_m151he",
		},

		{
			DrawArgs	= defaultArgs,
			connector_name = "tube_4",
			ShapeName	=	"ffar_mk4_m151he",
		},
	},
})
