cog_x = 0.0
cog_y = 1.46238
cog_z = 0.0

dofile(current_mod_path .. "/default_radio_presets.lua")
local radio_presets = get_default_radio_presets()

local _MainRotorPos	=	{ 0.01013275, 2.1654975, 0 }	-- [m] Main rotor hub position (3D model center of hub)
local _TailRotorPos	=	{ -4.608, 1.48624, -0.3947 }	-- [m] Tail rotor hub position (3D model center of hub)
local _ExhstNozzPos	=	{ -1.87641, 0.790134, 0.0 }		-- [m] Origin of exhaust heat blur, smoke trail, and other effects
local _CG 			= 	{ cog_x, cog_y, cog_z }			-- [m] CG w.r.t. EDM 3D mesh origin in TsAGI order
local _MOI			=	{ 600, 1238, 1418, -75 }	-- [kg*m^2] {Roll, Yaw, Pitch, POI}

local CAMRIG_Restrictions = 
	{
		{station = 1, loadout={"{OH6_SMOKE_RED}"},},
		{station = 1, loadout={"{OH6_SMOKE_BLUE}"},}, 
		{station = 1, loadout={"{OH6_SMOKE_GREEN}"},},
		{station = 1, loadout={"{OH6_SMOKE_YELLOW}"},},
		{station = 2, loadout={"{OH6_SMOKE_RED}"},},
		{station = 2, loadout={"{OH6_SMOKE_BLUE}"},},
		{station = 2, loadout={"{OH6_SMOKE_GREEN}"},},
		{station = 2, loadout={"{OH6_SMOKE_YELLOW}"},},
		{station = 3, loadout={"{OH6_SMOKE_RED}"},},
		{station = 3, loadout={"{OH6_SMOKE_BLUE}"},},
		{station = 3, loadout={"{OH6_SMOKE_GREEN}"},},
		{station = 3, loadout={"{OH6_SMOKE_YELLOW}"},},
		{station = 4, loadout={"{OH6_SMOKE_RED}"},},
		{station = 4, loadout={"{OH6_SMOKE_BLUE}"},},
		{station = 4, loadout={"{OH6_SMOKE_GREEN}"},},
		{station = 4, loadout={"{OH6_SMOKE_YELLOW}"},},
		{station = 5, loadout={"{OH6_FRAG}"},},
		{station = 8, loadout={"{OH-6 M134 Minigun}"}},
		{station = 9, loadout = {"{OH6_XM158}"},},
		{station = 10, loadout = {"{OH6_XM158}"},},
		{station = 9, loadout = {"{OH6_XM158_4}"},},
		{station = 10, loadout = {"{OH6_XM158_4}"},},
		{station = 11, loadout = {"{OH-6_M60_Door}"},},
		{station = 11, loadout = {"{OH-6_M134_Door}"},},
	}

local removed_doors = {
		{station = 6,loadout = {"<CLEAN>"}},
		{station = 7,loadout = {"<CLEAN>"}},  
	}
	
local removed_back_doors = {
		{station = 7,loadout = {"<CLEAN>"}},   
	}	
	


OH6 = {
	Name                     = 'OH-6A',
	Picture                  = 'OH-6.png', -- Mission editor loadout picture
	DisplayName              = _('OH-6A'),
	DisplayNameShort			= _("OH-6A"),
	date_of_introduction		= 1966.01,
	country_of_origin			= "USA",
	Rate						= 30, 				-- RewardPoint in Multiplayer
	
	
	-- Countries					= { "Denmark", "Japan", "Spain", "USA", },

	shape_table_data         = {
		{
			file     = 'OH-6A',
			username = 'OH-6A',
			desrt    = 'OH-6A',
			index    = WSTYPE_PLACEHOLDER,
			life     = 6, --   The strength of the object (ie. lifebar *)
			vis      = 3,  -- Visibility factor (For a small objects is better to put lower nr).
			fire     = { 300, 2 }, -- Fire on the ground after destoyed: 300sec 4m
			classname   = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name = "OH-6A",
			file = "OH-6A",
			fire = { 240, 2 },
		},
	},

	mapclasskey              = "P0091000021", 
	attribute                = { wsType_Air, wsType_Helicopter, wsType_Battleplane, WSTYPE_PLACEHOLDER,
		"Attack helicopters", "Transport helicopters",},
	Categories               = {"Helicopter",},
	-------------- Aircraft Physical properties -----------
	length						= 9.2393, 			-- [m] Fuselage length
	height						= 2.477, 			-- [m] Overall height
	
	rotor_RPM					= 483, 				-- [rpm] Main rotor RPM (positive: CCW looking from above; negative is CW)
	tail_rotor_RPM				= 3030, 			-- [rpm] Tail rotor RPM (positive: CCW looking from port side; negative is CW) - approx. 6.27:1
	rotor_height				= _MainRotorPos[2],	-- [m] Front hub height in the 3D model itself, in its TsAGI coordinate frame (not from the ground!)
	rotor_diameter				= 8.03, 			-- [m] Main rotor diameter (26 ft 4 in)
	blade_chord					= 0.1715,			-- [m] Main rotor blade chord (6.75 inches)
	blades_number				= 4,				-- [#] Number of blades on the main rotor
	blade_area					= 0.7, 				-- [m^2] The area of each blade (approx. blade chord * blade radius)
	rotor_pos 					= _MainRotorPos,	-- [m] Main rotor hub position (3D model center of hub)
	centering					= -0.14,			-- [deg] Pitch offset (magic number to tune pitch behavior)
	tail_pos 					= _TailRotorPos,	-- [m] Tail rotor hub position (3D model center of hub)
	tail_fin_area				= 0.52,     		-- [m^2] Vertical stabilizer area
	tail_stab_area				= 0.71,     		-- [m^2] Horizontal stabilizer area
	scheme						= 0,				-- [enum] "Regular" main rotor/tail rotor helicopter modeling scheme
	
	lead_stock_main				= -0.10,			-- [m] Fore oleo-damped strut compression (negative means it's a skid)
	lead_stock_support			= -0.10,			-- [m] Aft oleo-damped strut compression (negative means it's a skid)
	
	-- Moments of Inertia {R, Y, P, POI} [kg*m^2]
	rotor_MOI					= 282,				-- [kg*m^2] Rotor total moment of inertia (not per blade)
	MOI							= _MOI, 			-- [kg*m^2] {Roll, Yaw, Pitch, POI}
	center_of_mass				= _CG, 				-- [m] CG w.r.t. EDM 3D mesh origin in TsAGI coordinate order

	M_empty						= 897, 				-- [kg] Empty mass (~1,977 lbs)
	M_nominal					= 1089,				-- [kg] Normal mission mass (~2,400 lbs - Alternate A1)
	M_max						= 1225,				-- [kg] Max Takeoff Weight (MTOW) (~2,700 lbs)
	M_fuel_max					= 181,				-- [kg] Internal fuel (398.5 lbs)
	defFuelRatio				= 0.8,				-- [proportion] Default fuel loading (full = 1.0)
	
	fuselage_area	= 1.54,    	-- [m^2] Frontal Reference Area (S_ref)
	fuselage_Cxa0	= 0.24,		-- [coeff] 0 degree AoA drag coefficient (Forward drag - C_x)
	fuselage_Cxa90	= 2.76,		-- [coeff] 90 degree AoA drag coefficient (Vertical drag - C_y)
	thrust_correction	= 1, 	-- Set to 1 as we are relying on real engine performance tables
	
	SFM_Data = {
		engine = {
			type 		= "TurboShaft",
			name 		= "T63-A-5A",				-- Engine model (I think DCS only cares if it finds a sound match)
			typeng 		= 5,						-- Enumeration for turboshaft engines


			Nmg     	= 64.0,						-- Ground idle Ng or N1 RPM (%)
			Nominal_RPM = 50970.0,					-- 100% speed for Ng or N1 (gas generator turbine)
			-- Nominal_Fan_RPM = 6000.0,				-- Engine output shaft feeds directly into the main transmission
		
			MinRUD  	= 0, 						-- Min state of the throttle
			MaxRUD  	= 1, 						-- Max state of the throttle
			MaksRUD 	= 1, 						-- Military power state of the throttle
			ForsRUD 	= 1, 						-- Afterburner state of the throttle
		}, -- end of engine
	},

	-----------------------------------------------------------------------
	-------------- Engine & Performance -----------------------------------
	-----------------------------------------------------------------------
	V_max						= 241,				-- [kph] (approx 130 kts - Vne)
	V_max_cruise				= 215,				-- [kph] (approx 116 kts)
	Vy_max						= 10.5,				-- [m/s] Max climb speed
	Vy_land_max					= 2.44,				-- [m/s] Max vertical landing speed: 4 ft/min
	Ny_max						= 3.5,  			-- [G] Max load factor
	Sensors                  = {-- defines what the AI can use in terms of sensors
		RWR = "Abstract RWR"
	},
	
	H_stat_max_L				= 5600,				-- [m] Hover OGE (Lightweight)
	H_stat_max					= 2225,				-- [m] Hover OGE (Max weight)
	H_din_two_eng				= 4875,				-- [m] Service Ceiling (16,000 ft)
	H_din_one_eng				= 4875,				-- [m] Same as above (Single Engine aircraft)
	H_max						= 4875, 			-- [m] Max operation height
	
	range						= 611, 				-- [km] Ferry range on internal tanks (330 nmi)
	flight_time_typical			= 135,				-- [min] Based on a standard cruise burn rate of ~24-26 gallons/hour
	flight_time_maximum			= 186,				-- [min] Based on 61.5 gallons of usable fuel burned at an economy loiter rate of approx. 20 gallons/hour
	-- average_fuel_consumption	= 0.3,				-- [kg/s] I don't think helicopters use this but including it for completeness
	
	CanopyGeometry           = {
		azimuth   = { -100.0, 120.0 },  -- pilot view horizontal (AI)
		elevation = { -50.0, 110.0 }    -- pilot view vertical (AI)
	},
	
	nose_gear_pos	= {  1.63, -0.588, 0.963 },		-- Skid foremost contact point
	main_gear_pos	= { -0.55, -0.474, 0.963 },		-- Skid aftmost contact point
	
	
	cargo_max_weight			= 550,				-- [kg] Operational external load limit (approx 1,200 lbs)
	cargo_radius_in_menu		= 2000,				-- [m] Distance limit for cargo to show up in menu
	sounderName = "Aircraft/Planes/OH6",
	sound_name               = "External/oh6_Silent",
	helicopter_hook_pos			= { 0, 0.0155, 0 },	-- [m] Hook/fuselage attachment point
	h_max_gear_hook				= 2.4,				-- [m] How far the hook has to be to automatically "capture" load
	
	openRamp					= 1,				-- [enum] Allow task for internal cargo transportation
		InternalCargo =
		{
			nominalCapacity = 200,
			maximalCapacity = 300,

			para_unit_point = 2,
			unit_point 	  = 2,
			area 	  	  = {1.2, 1.4, 1.5},-- cargo bay dimensions (lenght, width, height)
			far_wall_pos  = {0.43,0.33,0}, -- coordinates on  point on corner of floor and centerline of far wall , together with area  it will give  geometry of cargo compartment in BCS
			out_door =
			{
				cargo_generic =
				{
					large = true, x = 0, z = 0, heading = math.rad(90),
					mechanicals =
					{
						close = {"CargoBayGates", "Close"},
						board = {"CargoBayGates", "Open"},
						boardable = {{mechanism = "CargoBayGates", states = {"Open"}}, {mechanism = "CargoBayGate0", states = {"Open"}},},
					},
				},
			},
		},
	
	engines_count            = 2,
	engines_nozzles          =
	{
		{
			pos 					= _ExhstNozzPos, 	-- Heat blur origin
			elevation 				= -8.0,				-- [deg] Exhaust plume depressed 8 degrees w.r.t. horizon
			diameter        		= 0.40,				-- [m] Exhaust blur diameter
			engine_number   		= 1,
			exhaust_length_ab 		= 1.3,				-- [m] Exhaust blur length
			exhaust_length_ab_K 	= 0.35,
			smokiness_level 		= 0.07,
		},
	},
	
	crew_stations				= "HumanOrchestra",
	crew_size                = 2,
	crew_members             =
	{
		[1] =
		{ 	
			ejection_seat_name	=	0,
			drop_canopy_name	=	0,
			pos                = { 1.3, 1.0, 1.5 },   
			ejection_order     = 1,
			can_be_playable    = true,
			role               = "pilot",
			role_display_name  = _("Pilot"),
			canopy_arg           = 38,
		},
		[2] =
		{ 
			ejection_seat_name	=	0,
			drop_canopy_name	=	0,
			pos                = { 1.3, 1.0, - 1.5 },
			ejection_order     = 2,
			can_be_playable    = true,
			role               = "instructor",
			role_display_name  = _("Instructor pilot"),
			canopy_arg           = 38,
		},
	},

	fires_pos                =
	{
		[1] = { -1.87641, 0.790134, 0.0 }, -- turbine exit
	},

	Guns = {
		
	},
	
	radar_can_see_ground		= true,				-- [bool] Sensors/eyeballs can/cannot see enemy surface entities (tanks, ships)
	detection_range_max			= 15,				-- [km] How far this aircraft's sensors can possibly detect something (determines absolute maximum SA range)
	
	RCS							= 1.5, 				-- [m^2] Based on a survey of official ED DCS model RCS values and interpolating for the OH-6A
	IR_emission_coeff			= 0.27, 			-- [proportion] Broad-wavelength, all-aspect IR signature compared to the Su-27 (defined as 1.0)
	
	fire_rate					= 0,
	cannon_sight_type			= 0,
	
	
	
	Pylons = {
		pylon(1, 0, 0.241, 0.926, 1.55, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ use_full_connector_position = false, DisplayName = "G4",arg = 133, arg_value = 0 },
			{
				{CLSID = "{OH6_SMOKE_RED}",    arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_GREEN}",  arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_BLUE}",   arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_YELLOW}", arg_value = 1.0,required = removed_doors},
			}
		),
		pylon(2, 0, 0.241, 0.926, 1.55, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ use_full_connector_position = false, DisplayName = "G3",arg = 132, arg_value = 0 },
			{
				{CLSID = "{OH6_SMOKE_RED}",    arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_GREEN}",  arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_BLUE}",   arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_YELLOW}", arg_value = 1.0,required = removed_doors},		
			}
		),
		pylon(3, 0, 0.241, 0.926, 1.55, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ use_full_connector_position = false, DisplayName = "G2",arg = 131, arg_value = 0 },
			{
				{CLSID = "{OH6_SMOKE_RED}",    arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_GREEN}",  arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_BLUE}",   arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_YELLOW}", arg_value = 1.0,required = removed_doors},
			}
		),
		pylon(4, 0, 0.241, 0.926, 1.55, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ use_full_connector_position = false, DisplayName = "G1",arg = 130, arg_value = 0 },
			{
				{CLSID = "{OH6_SMOKE_RED}",    arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_GREEN}",  arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_BLUE}",   arg_value = 1.0,required = removed_doors},
				{CLSID = "{OH6_SMOKE_YELLOW}", arg_value = 1.0,required = removed_doors},
			}
		),
		pylon(5, 0, 0.241, 0.926, 1.55, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ use_full_connector_position = false, DisplayName = "HE",arg = 135, arg_value = 0 },
			{
				{ CLSID = "{OH6_FRAG}", arg_value = 1.0,required = removed_doors},
			}
		),
		pylon(6, 0, 0.0, 0.0, 0.0, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ use_full_connector_position = false, connector = "FDoors", DisplayName = "F.Doors", arg = 209, arg_value = 0 },
			{
				{ CLSID = "<CLEAN>", arg_value = 1.0, add_mass = -10 },
			}
		),
		pylon(7, 0, 0.0, 0.0, 0.0, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ use_full_connector_position = false, connector = "RDoors", DisplayName = "R.Doors", arg = 210, arg_value = 0 },
			{
				{ CLSID = "<CLEAN>", arg_value = 1.0, add_mass = -10 },
			}
		),
		pylon(8, 0, 0.0, 0.0, 0.0, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ use_full_connector_position = true, connector = "Gun_Attach", attach_point_oriented = true,
				DisplayName = "Gun", arg = 111, arg_value = 0 },
			{
				{ 
					CLSID = "{OH-6_M134_Minigun}", arg_value = 1.0, attach_point_oriented = true,
					forbidden = {
						{station = 9, loadout = {"{OH6_XM158}"}},
						{station = 9, loadout = {"{OH6_XM158_4}"}},
						{station = 12, loadout = {"{OH-6_CAMRIG}"}},
						{station = 13, loadout = {"{OH-6_CARGO_AMMO}"}},
						{station = 13, loadout = {"{OH-6_CARGO_PAX}"}},
						{station = 13, loadout = {"{OH-6_CARGO_CRATES}"}},
						{station = 13, loadout = {"{OH-6_CARGO_ANIMAL}"}},
						{station = 13, loadout = {"{OH-6_CARGO_PIGS}"}},
						{station = 13, loadout = {"{OH-6_CARGO_SOLDIERS}"}},
						{station = 13, loadout = {"{OH-6_CARGO_CANS}"}},
						{station = 13, loadout = {"{OH-6_CARGO_OPERATOR}"}},
					},
					required = removed_doors,
				}

			}
		),
		pylon(9, 0, 0.0, 0.0, 0.0, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)   
			{ use_full_connector_position = true, connector = "Pylon1", attach_point_oriented = true,
				DisplayName = "R L",arg = 117,arg_value = 0.0,},
			{
				{CLSID = "{OH6_XM158}", arg_value = 1.0, forbidden = {
					{station = 8, loadout = {"{OH-6_M134_Minigun}"},},
					{station = 12, loadout = {"{OH-6_CAMRIG}"}},
				},
				required = removed_doors,
				},
				{CLSID = "{OH6_XM158_4}", arg_value = 1.0, forbidden = {
					{station = 8, loadout = {"{OH-6_M134_Minigun}"},}, 
					{station = 12, loadout = {"{OH-6_CAMRIG}"}},
				},
				required = removed_back_doors,
				},

			}
		),
		pylon(10, 0, 0.0, 0.0, 0.0, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ use_full_connector_position = true, connector = "Pylon2", attach_point_oriented = true,
				DisplayName = "R R",arg = 118,arg_value = 0.0,},
			{
				{CLSID = "{OH6_XM158}", arg_value = 1.0,
				forbidden = {station = 12, loadout = {"{OH-6_CAMRIG}"}},
				required = removed_doors,},	-- LAU-68-M151 High Explosive *7
				{CLSID = "{OH6_XM158_4}", arg_value = 1.0,
				forbidden = {station = 12, loadout = {"{OH-6_CAMRIG}"}},
				required = removed_back_doors,},	-- LAU-68-M151 High Explosive *7
			}
		),

		pylon(11, 0, 0.0, 0.0, 0.0, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ use_full_connector_position = true, connector = "Door_Gun_Attach", attach_point_oriented = true,
				DisplayName = "DoorGun", arg = 113, arg_value = 0 },
			{
				{ CLSID = "{OH-6_M60_Door}", arg_value = 0.5, attach_point_oriented = true,
				forbidden = {{station = 10, loadout = {"{OH6_XM158}"}},
							{station = 13, loadout = {"{OH-6_CARGO_AMMO}"}},
							{station = 13, loadout = {"{OH-6_CARGO_PAX}"}},
							{station = 13, loadout = {"{OH-6_CARGO_CRATES}"}},
							{station = 13, loadout = {"{OH-6_CARGO_ANIMAL}"}},
							{station = 13, loadout = {"{OH-6_CARGO_PIGS}"}},
							{station = 13, loadout = {"{OH-6_CARGO_SOLDIERS}"}},
							{station = 13, loadout = {"{OH-6_CARGO_OPERATOR}"}},
						    {station = 13, loadout = {"{OH-6_CARGO_MEDEVAC}"}},
							{station = 13, loadout = {"{OH-6_CARGO_CANS}"}},},
				required = removed_doors,
				},
				{ CLSID = "{OH-6_M134_Door}", arg_value = 1.0, attach_point_oriented = true,
				forbidden = {{station = 12, loadout = {"{OH-6_CAMRIG}"}},
							{station = 13, loadout = {"{OH-6_CARGO_AMMO}"}},
							{station = 13, loadout = {"{OH-6_CARGO_PAX}"}},
							{station = 13, loadout = {"{OH-6_CARGO_CRATES}"}},
							{station = 13, loadout = {"{OH-6_CARGO_ANIMAL}"}},
							{station = 13, loadout = {"{OH-6_CARGO_PIGS}"}},
							{station = 13, loadout = {"{OH-6_CARGO_SOLDIERS}"}},
							{station = 13, loadout = {"{OH-6_CARGO_OPERATOR}"}},
							{station = 13, loadout = {"{OH-6_CARGO_CANS}"}},},
				required = removed_back_doors,
				},

			}
		),

		pylon(12, 0, 0.0, 0.0, 0.0, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ 
				DisplayName = "Xtra", arg = 140, arg_value = 0.0 },
			{
				{ CLSID = "{OH-6_CAMRIG}", arg_value = 0.55, attach_point_oriented = false,
				forbidden = CAMRIG_Restrictions
				},
				{ CLSID = "{OH-6_CAMMAN}", arg_value = 0.4, attach_point_oriented = false,
				forbidden = CAMRIG_Restrictions
				},
				{ CLSID = "{OH-6_Searchlight}", arg_value = 1.0, attach_point_oriented = false},
				{ CLSID = "{OH-6_FLOATERS}", arg_value = -1.0, attach_point_oriented = false}
			}
		),
		pylon(13, 0, 0.0, 0.7, 0.0, -- (Pylon #, ext wing=0(no ejection)/ext fuselage=1/internal bay=2, forward/back, up/down, left/right)
			{ 
				DisplayName = "Cargo", arg = 211, arg_value = 0.0 },
				{
					{ CLSID = "{OH-6_CARGO_AMMO}", arg_value = 0.0, attach_point_oriented = false,
					forbidden = cargo_restrictions},
					{ CLSID = "{OH-6_CARGO_CRATES}", arg_value = 0.0, attach_point_oriented = false,required = removed_back_doors,
					forbidden = cargo_restrictions},
					{ CLSID = "{OH-6_CARGO_PAX}", arg_value = 1.0, attach_point_oriented = false,
					forbidden = cargo_restrictions},
					{ CLSID = "{OH-6_CARGO_ANIMAL}", arg_value = 0.0, attach_point_oriented = false,
					forbidden = cargo_restrictions},
					{ CLSID = "{OH-6_CARGO_PIGS}", arg_value = 0.0, attach_point_oriented = false,required = removed_back_doors,
					forbidden = cargo_restrictions},
					{ CLSID = "{OH-6_CARGO_SOLDIERS}", arg_value = 0.0, attach_point_oriented = false,required = removed_doors,
					forbidden = cargo_restrictions},
					{ CLSID = "{OH-6_CARGO_CANS}", arg_value = 0.0, attach_point_oriented = false,
					forbidden = cargo_restrictions},
					{ CLSID = "{OH-6_CARGO_OPERATOR}", arg_value = 0.0, attach_point_oriented = false,required = removed_doors,
					forbidden = cargo_restrictions},
				}
		),


	},

	Tasks = {                     -- defined in db_units_planes.lua
		aircraft_task(Transport), --31
		aircraft_task(Reconnaissance),
	},
	DefaultTask = aircraft_task(Reconnaissance),

	
	passivCounterm =
	{
		CMDS_Edit = true,
		SingleChargeTotal = 30,
		flare = {default = 30, increment = 30, chargeSz = 1},
		chaff = {default = 0, increment = 30, chargeSz = 1},
	},

    chaff_flare_dispenser =
	{
		--{ dir =  {Z, Y, X}, pos =  {Z, Y, X}, }  -- Z=back/fwd,Y=down/up, X=left/right
        [1] = { dir =  {0.956935,-0.2903036,0}, pos =  {0.050, -0.216716, 0}, }, 
    },

	
	LandRWCategories = -- adds these takeoff and landing options avaliable in mission editor
	{
		[1] =
		{
			Name = "HelicopterCarrier",
		},
		[2] =
		{
			Name = "AircraftCarrier",
		},
	},
	TakeOffRWCategories =
	{
		[1] =
		{
			Name = "HelicopterCarrier",
		},
		[2] =
		{
			Name = "AircraftCarrier",
		},
	},

	Damage = verbose_to_dmg_properties(                                   --index meaning see in Scripts\Aircrafts\_Common\Damage.lua
		{
																		-- deps_cells defines what other parts get destroyed along with it
		["ROTOR"]          = { critical_damage = 2.5, args = { 419 },   --63
			deps_cells = { "BLADE_1_IN", "BLADE_2_IN", "BLADE_3_IN", "BLADE_4_IN" } }, -- 64
		["BLADE_1_IN"]     = { critical_damage = 0.5, args = { 420 } }, -- 64
		["BLADE_2_IN"]     = { critical_damage = 0.5, args = { 421 } }, -- 67
		["BLADE_3_IN"]     = { critical_damage = 0.5, args = { 422 } }, -- 70
		["BLADE_4_IN"]     = { critical_damage = 0.5, args = { 423 } }, -- 73

		["BLADE_5_IN"]     = { critical_damage = 0.5, args = { 424 } }, -- 76 Tailrotor

		["ELEVATOR_L_OUT"] = { critical_damage = 0.5, args = { 425 } }, -- 49 Tailrotor
		["STABILIZATOR_L"] = { critical_damage = 0.5, args = { 426 } }, -- 47 Tailrotor
		["STABILIZATOR_R"] = { critical_damage = 0.5, args = { 427 } }, -- 48 Tailrotor


		["WHEEL_L"] = { critical_damage = 1, args = { 430 }, deps_cells = { "AIR_BRAKE_L", "Line_STABIL_L" } }, -- 84
		["AIR_BRAKE_L"] = { critical_damage = 1, args = { 430 }},
		["Line_STABIL_L"] = { critical_damage = 1, args = { 430 } },

		["WHEEL_R"] = { critical_damage = 1, args = { 431 }, deps_cells = { "AIR_BRAKE_R", "Line_STABIL_R" } }, --85
		["AIR_BRAKE_R"] = { critical_damage = 1, args = { 431 }},
		["Line_STABIL_R"] = { critical_damage = 1, args = { 431 }},

		["FUEL_TANK_F"] = { critical_damage = 1, args = {477} }, --61

		["CABIN_BOTTOM"] = { critical_damage = 0.5, args = {472} }, --6
		["CABIN_LEFT_SIDE"] = { critical_damage = 0.5, args = {471}}, --4
		["CABIN_RIGHT_SIDE"] = { critical_damage = 0.5, args = {470}}, --5

		["ELERON_L"] = { critical_damage = 1, args = {475} }, --25
		["ELERON_R"] = { critical_damage = 1, args = {476} }, --26
		["ENGINE"] = { critical_damage = 1, args = {483} }, --11
		["FLAP_L_OUT"] = { critical_damage = 1, args = {-1} }, --31
		["FLAP_R_OUT"] = { critical_damage = 1, args = {-1} }, --32

		["FUSELAGE_LEFT_SIDE"] = { critical_damage = 1, args = {479} }, --9
		["FUSELAGE_RIGHT_SIDE"] = { critical_damage = 1, args = {480} }, --10
		["NOSE_LEFT_SIDE"] = { critical_damage = 1, args = {473} }, --1
		["NOSE_RIGHT_SIDE"] = { critical_damage = 1, args = {474} }, --2
		["LEFT_GEAR_BOX"] = { critical_damage = 1, args = {482} }, --15
		["RIGHT_GEAR_BOX"] = { critical_damage = 1, args = {481} }, --16
		["TAIL_LEFT_SIDE"] = { critical_damage = 1, args = {-1} }, --56
		["TAIL_RIGHT_SIDE"] = { critical_damage = 1, args = {-1} }, --57
		["WING_L_PART_IN"] = { critical_damage = 1, args = {-1} }, --33
		["WING_R_PART_IN"] = { critical_damage = 1, args = {-1} }, --34
		["COCKPIT_Line"] = { critical_damage = 1, args = {-1} },
		["TAIL_BOTTOM"] = { critical_damage = 1, args = {-1} }, --58


		["FUEL_TANK_B"] = {critical_damage = 2, args = {-1}}, -- 62
		["ENGINE_1"] = {critical_damage = 2, args = {-1}}, -- 103
		["FRONT_GEAR_BOX"] = {critical_damage = 2, args = {-1}}, -- 8


		["COCKPIT"] = {critical_damage = 1,args = {65}}, -- 3

		["CREW_1"] = {critical_damage = 1,deps_cells = { "COCKPIT"}},--90
		["CREW_2"] = {critical_damage = 1,deps_cells = { "COCKPIT"}},--91

	}),

	Failures = {
	},

	DamageParts = { -- parts that fall off when aircraft is hit or crashes

	},
	lights_data	= {
		typename = "Collection",
		lights = {
			[WOLALIGHT_BEACONS] = {
				-- DCS seems to only turn this collection on during startup of the engines then turns them off when it's time to taxi.
				typename = "Collection",
				lights = { 
					-- Dorsal (top) red beacon strobe
					{typename = "argumentlight", argument = 123, controller = "Strobe", period = 1.2, flash_time = 0.05, phase_shift = 0.0},
					-- Ventral (bottom) red beacon strobe
					{typename = "argumentlight", argument = 124, controller = "Strobe", period = 1.2, flash_time = 0.05, phase_shift = 0.5},
				},
			},
			[WOLALIGHT_STROBES] = {
				-- Red beacon lights. Old aircraft have rotating/oscillating ones. Modern aircraft flash.
				typename = "Collection",
				lights = {
					-- Dorsal (top) red beacon strobe
					{typename = "argumentlight", argument = 123, controller = "Strobe", period = 1.2, flash_time = 0.05, phase_shift = 0.0},
					-- Ventral (bottom) red beacon strobe
					{typename = "argumentlight", argument = 124, controller = "Strobe", period = 1.2, flash_time = 0.05, phase_shift = 0.5},
				},
			},
			[WOLALIGHT_TIPS_LIGHTS] = {
				-- This lighting set should be on whenever it's dark outside and the helicopter isn't in combat.
				typename = "Collection",
				lights = { },
			},
			[WOLALIGHT_PROJECTORS] = {
				-- Handles spotlights
				typename = "Collection",
				lights = {
					{typename = "argumentlight", argument = 116},		-- Steerable spotlight
				},
			},
			[WOLALIGHT_LANDING_LIGHTS] = {
				-- This collection turns on for approach and landing, obviously.
				typename = "Collection",
				lights = {
					{	typename = "Spot", argument = 115,					-- Nose landing flood
						position = { 1.714, 0.40, 0 },
						proto = lamp_prototypes.LFS_R_27_130,
						color = {1, 0.945, 0.8784},
						direction = {azimuth = math.rad(0.0), elevation = math.rad(20.0)},
						angle_max = math.rad(30),							-- 30 degree beam width
						cool_t = 0.6,
						range = 400,
					},
				},
			},
			[WOLALIGHT_TAXI_LIGHTS] = {
				-- This collection turns on when taxiing around on the ground.
				typename = "Collection",
				lights = {
					-- {typename = "argumentlight",	argument  = 115},		-- Nose landing flood
					-- {	typename = "Spot", argument = 115,					-- Nose landing flood
						-- position = { 1.714, 0.40, 0 },
						-- proto = lamp_prototypes.LFS_R_27_130,
						-- color = {1, 0.945, 0.8784},
						-- direction = {azimuth = math.rad(0.0), elevation = math.rad(25.0)},
						-- angle_max = math.rad(45.0),
						-- intensity_max = 300,
						-- range = 60,
					-- },
				},
			},
			[WOLALIGHT_NAVLIGHTS] = {
				typename = "Collection",
				lights = { 
					{typename = "argumentlight", argument = 120},		-- navigation lights: port side red
					{typename = "argumentlight", argument = 121},		-- navigation lights: stbd side green
					{typename = "argumentlight", argument = 122},		-- navigation lights: tail white
				},
			},
			[WOLALIGHT_CABIN_WORK] = {
				typename = "Collection",
				lights = { },
			},
			[WOLALIGHT_CABIN_NIGHT] = {
				-- This collection turns on when the aircraft is in motion at night (including in combat conditions, I think).
				typename = "Collection",
				lights = { },
			},
			[WOLALIGHT_CABIN_BOARDING] = {
				-- These lights are used from engine startup, through taxi, and turn off just after takeoff.
				typename = "Collection",
				lights = { },
			},
			[WOLALIGHT_FORMATION_LIGHTS] = {
				-- Slime lights, etc. used around airfields (ground and air), but especially around other aircraft (e.g., aerial refuelers).
				typename = "Collection",
				lights = { },
			},
		},
	},
	
	net_animation = { --transmits draw arguments over multiplyer for others to see
		35,
		36, -- tail rotor
		37, -- main rotor
		38, --canopy
		
		201, -- skids
		202,
		203,
		204,
		207,--doors
		208,
		209,
		210,
		211,

		111, --guns
		113, --gunner visibility
		115, -- lights
		116,
		117,--rocket mounts
		118,
		119, -- floaters
		120,
		121,
		122,
		123,
		124,

		127, --flares
		450, --gun el

		1000, --door gunner orientation
		1001,
		--1100, --flap
		--1101,
		--1102,
		--1103,

		140, --cam rig
		141,
		142

	},

	
	engine_data =
	{
		power_take_off 		= 238.1/2, 					-- [kW] Max takeoff power (5-min limit)
		power_max 			= 213.8/2,					-- [kW] Max continuous power
		power_WEP 			= 238.1/2,					-- [kW] Emergency power
		power_TH_k =
		{
			[1] = { 0.21/2,  -20.46/2,  238.1/2 },		-- [coeffs] Max Takeoff at 15° C (Fig. 58 - AD0855043.pdf)
			[2] = { 0.21/2,  -20.46/2,  238.1/2 },		-- [coeffs] Emergency / Max (No OEI rating): Same as Takeoff
			[3] = { 0.25/2,  -18.61/2,  213.8/2 },		-- [coeffs] Max Continuous at 15° C (Fig. 59 - AD0855043.pdf)
			[4] = { 0.25/2,  -18.61/2,  213.8/2 },		-- [coeffs] Cruise: limited by transmission torque below 3 km
		},
		SFC_k = {(4.708e-6)/2, (-2.75e-3)/2, 0.819/2},	-- [coeffs] SFC [kg/kWh] vs. power [kW] (Spec. 580-F - AD0855043.pdf - Fig. 64)
		power_RPM_k = { -0.08639, 0.24277, 0.84175 },	-- [coeffs] (Approach B) Power Turbine (N2/Np) Efficiency Curve
		power_RPM_min 	= 15,		-- (Approach B) OH-6A rotor starts turning as engine passes up through 12-15% RPM
		Nmg_Ready 		= 65.0,       				-- [%] Flight idle Ng RPM
		sound_name = "External/oh6_Silent",
	},


	HumanRadio = {
		frequency = 262.0,
		editable = true,
		minFrequency = 100,
		maxFrequency = 400,
		modulation = MODULATION_AM
	},
	panelRadio =
	{
        [1] =
		{
			name = _("AN/ARC-51BX"), -- 225.000 to 399.975 MHz AM
			range =
			{
				{min = 225.0, max = 399.975}
			},
			channels =
			{
				[1] = { name = _("Channel 1"),	default = radio_presets[1]},	-- mineralnye-vody (URMM) : 264.0
				[2] = { name = _("Channel 2"),	default = radio_presets[2]},	-- nalchik (URMN) : 265.0
				[3] = { name = _("Channel 3"),	default = radio_presets[3]},	-- sochi-adler (URSS) : 256.0
				[4] = { name = _("Channel 4"),	default = radio_presets[4]},	-- maykop-khanskaya (URKH), nellis (KLSV) : 254.0
				[5] = { name = _("Channel 5"),	default = radio_presets[5]},	-- anapa (URKA) : 250.0
				[6] = { name = _("Channel 6"),	default = radio_presets[6]},	-- beslan (URMO) : 270.0
				[7] = { name = _("Channel 7"),	default = radio_presets[7]},	-- krasnodar-pashkovsky (URKK) : 257.0
				[8] = { name = _("Channel 8"),	default = radio_presets[8]},	-- sukhumi-babushara (UGSS) : 255.0
				[9] = { name = _("Channel 9"),	default = radio_presets[9]},	-- kobuleti (UG5X) : 262.0
				[10] = { name = _("Channel 10"),	default = radio_presets[10]},	-- gudauta (UG23) : 259.0
				[11] = { name = _("Channel 11"),	default = radio_presets[11]},	-- tbilisi-soganlug (UG24) : 268.0
				[12] = { name = _("Channel 12"),	default = radio_presets[12]},	-- tbilisi-vaziani (UG27) : 269.0
				[13] = { name = _("Channel 13"),	default = radio_presets[13]},	-- batumi (UGSB) : 260.0
				[14] = { name = _("Channel 14"),	default = radio_presets[14]},	-- kutaisi-kopitnari (UGKO) : 263.0
				[15] = { name = _("Channel 15"),	default = radio_presets[15]},	-- senaki-kolkhi (UGKS) :  261.0
				[16] = { name = _("Channel 16"),	default = radio_presets[16]},	-- tbilisi-lochini (UGTB) : 267.0
				[17] = { name = _("Channel 17"),	default = radio_presets[17]},	-- krasnodar-center (URKI), creech (KINS) : 251.0
				[18] = { name = _("Channel 18"),	default = radio_presets[18]},	-- krymsk (URKW), mccarran (KLAS) : 253.0
				[19] = { name = _("Channel 19"),	default = radio_presets[19]},	-- mozdok (XRMF) : 266.0
				[20] = { name = _("Channel 20"),	default = radio_presets[20]},	-- N/A, groom lake/homey (KXTA) : 252.0
			},
		},
	},



	doors_transmission	= "Mechanical",		-- Drive type ("Hydraulic", "Electric", "Pneumatic", "Mechanical")
	doors_movement		= 2,				-- 0 = default anim; 2 = custom mechanimation
	-- undercarriage_transmission	= "Hydraulic",	-- Not used, provided for community example
	-- undercarriage_movement		= 0,			-- 0 = default anim; 2 = custom mechanimation
	mechanimations = {
		Door0 = {
			{Transition = {"Any", "Open"},		Sequence = {{C = {{"Arg", 35, "to",  1.0, "in",    2.0}}}}},	-- Open both pilot doors
			{Transition = {"Any", "Close"},		Sequence = {{C = {{"Arg", 35, "to",  0.0, "in",    1.0}}}}},	-- Close both pilot doors
			{Transition = {"Any", "Board"},		Sequence = {{C = {{"Arg", 35, "to",  1.0, "speed", 2.0}}}}},	-- Open both pilot doors
			
			{Transition = {"Any", "Bailout"},	Sequence = {{C = {{"Arg", 50, "set", 1.0},		-- Vanishes stbd pilot
																	{"JettisonCanopy", 0},		-- ???
																	}}}},
		},
		SearchLight0Elevation = {
			-- Formula for determining arg 1005 values:	arg_value = 2 * (extension_angle_deg / 90 - 1) + 1; fully stowed is angle 0
			{Transition = {"Any", "Retract"},	Sequence = {{C = {{"Arg", 142, "from",  0.3,  "to",  -1.0, "speed", 1/3},},},},},
			{Transition = {"Any", "Extend"},	Sequence = {{C = {{"Arg", 142, "from", -1.0,  "to",   0.3, "speed", 1/3},},},},},
		},
		SearchLight0Panning = {
			{Transition = {"Any", "Right"},		Sequence = {{C = {{"Arg", 141, "from",  1.0,  "to",  -1.0, "speed", 0.17},},},},},	-- pan right/starboard
			{Transition = {"Any", "Left"},		Sequence = {{C = {{"Arg", 141, "from", -1.0,  "to",   1.0, "speed", 0.17},},},},}, 	-- pan left/port
		},
	}, -- end of mechanimations
	


	AddPropAircraft =
	{
		{
			id = "CableCutterEnables",
			control = "checkbox",
			label = _("Cable Cutter"), 
			defValue = false,
			weightWhenOn = 0,
			arg = 150,
		},
		{
			id = "FlaresEquipped",
			control = "checkbox",
			label = _("Equip Flares"),
			defValue = false,
			weightWhenOn = 10,
			arg = 127,
		},
		{
			id = "RWREquipped",
			control = "checkbox",
			label = _("Equip RWR"),
			defValue = false,
			weightWhenOn = 10,
			arg = 31,
		},
	},
	InheriteCommonCallnames = true,
	SpecificCallnames=
	{
		["USA"] = 
		{
			{_('Assault'), 'Assault'},
			{_('Banshee'),'Banshee'},
			{_('Condor'),'Condor'},
			{'Gunner','Gunner'},
			{_('Eagle'),'Eagle'},
			{_('Griffin'),'Griffin'},
			{_('Little Griffin'),'Little Griffin'},
			{_('Deadbone'),'Deadbone'},
			{_('Brandy'),'Brandy'},
			{_('Thunder'),'Thunder'},
			{_('Roadrunner'),'Roadrunner'},
			{_('Woodstock'),'Woodstock'},
			{_('Scalphunter'),'Scalphunter'},
			{_('Darkhorse'),'Darkhorse'},
			{_('War Wagon'),'War Wagon'},
		}
	},

	encyclopediaAnimation =
	{
		args =
		{
			[40] = -1.000000,
			[41] = -1.000000,
		},
	},



}

add_aircraft(OH6)
