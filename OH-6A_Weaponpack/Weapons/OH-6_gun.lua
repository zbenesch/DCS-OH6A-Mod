local wsType_oh6minigun = 13500 
local M80 = {
        category = CAT_SHELLS, name = "OH-6 7.62x51mm M80", user_name = _("OH-6 7.62x51mm M80"),
        model_name      = "tracer_bullet_white",
        mass            = 0.00952, --kg of each bullet
        round_mass      = 0.0254, --kg of entire round
        cartridge_mass  = 0.01588, --kg of shell
        explosive       = 0.000,
        v0              = 856.2,   -- 2809 fps = 856.2 m/s
        Dv0             = 0.0060,
        Da0             = 0.0022, -- dispersion amount
        Da1             = 0.0,
        life_time       = 30,
        caliber         = 7.62, --mm
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.5,1.27,0.70,0.200,2.30},
        k1              = 2.0e-08,
        tracer_off      = -1,
        tracer_on       = 0.000001,
        smoke_tail_life_time = 0,
        scale_tracer    = 0,
        cartridge       = 0,
        scale_smoke     = 1.0,
        smoke_opacity   = 0.1
}
declare_weapon(M80)


    -- 7.62x51mm NATO M61 Armor Piercing
local M61 = {
        category = CAT_SHELLS, name = "OH-6 7.62x51mm M61", user_name = _("OH-6 7.62x51mm M61"),
        model_name      = "tracer_bullet_white",
        mass            = 0.00975, --kg of each bullet
        round_mass      = 0.0256, --kg of entire round
        cartridge_mass  = 0.01588, --kg of shell
        explosive       = 0.000,
        v0              = 854.6,   -- 2804 fps = 854.6 m/s
        Dv0             = 0.0060,
        Da0             = 0.0022, -- dispersion amount
        Da1             = 0.0,
        life_time       = 30,
        caliber         = 7.62, --mm
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.5,1.27,0.70,0.200,2.30},
        k1              = 2.0e-08,
        tracer_off      = -1,
        tracer_on       = 0.00001,
        smoke_tail_life_time = 0,
        scale_tracer    = 0,
        cartridge       = 0,
        scale_smoke     = 1.0,
        smoke_opacity   = 0.1
}
declare_weapon(M61)

    -- 7.62x51mm NATO M62 Tracer
local M62 = {
        category = CAT_SHELLS, name = "OH-6 7.62x51mm M62", user_name = _("OH-6 7.62x51mm M62"),
        model_name      = "tracer_bullet_red",
        mass            = 0.0092, --kg of each bullet
        round_mass      = 0.02508, --kg of entire round
        cartridge_mass  = 0.01588, --kg of shell
        explosive       = 0.000,
        v0              = 856.2,   -- 2809 fps = 856.2 m/s
        Dv0             = 0.0060,
        Da0             = 0.0022, -- dispersion amount
        Da1             = 0.0,
        life_time       = 30,
        caliber         = 7.62, --mm
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.5,1.27,0.70,0.200,2.30},
        k1              = 2.0e-08,
        tracer_off      = 1.7,
        tracer_on       = 0.00001,
        smoke_tail_life_time = 1.7,
        scale_tracer    = 1,
        cartridge       = 0,
        scale_smoke     = 1.0,
        smoke_opacity   = 0.1
}
declare_weapon(M62)







function M134_DOOR(tbl)
    tbl.category = CAT_GUN_MOUNT
    tbl.name      = "OH-6_M134_Door"
    tbl.supply      =
    {
        shells = {"OH-6 7.62x51mm M80", "OH-6 7.62x51mm M61", "OH-6 7.62x51mm M62"},
        mixes  = {{1,2,3,2,2,3}},   -- for every 6 shots there will be one M62 (tracer)
        count  = 2000,		-- 2000 rounds
    }
    if tbl.mixes then
       tbl.supply.mixes = tbl.mixes
       tbl.mixes        = nil
    end
    tbl.gun =
    {
        max_burst_length    = 1, -- minimum number of rounds fired per burst
        rates               = {4000},
        recoil_coeff        = 0.07*1.3,
        barrels_count       = 6,
    }
    if tbl.rates then
       tbl.gun.rates        =  tbl.rates
       tbl.rates            = nil
    end
    tbl.ejector_pos             = {-0.818,-0.144,0.022} -- position from muzzle connector pos
    tbl.ejector_dir             = {-1, -6, 0} -- left/right; back/front;?/?
    --tbl.supply_position         = tbl.supply_position   or {1.0, 0.0, 0.0}
	tbl.supply_position         = {0.0, 0.0, 0.0}
    tbl.aft_gun_mount           = false
    tbl.effective_fire_distance = 1000
    tbl.drop_cartridge          = 205	--drop shell shape/size from  aircraft_gun_mounts.lua
    tbl.muzzle_pos              = tbl.muzzle_pos            or  {0.886,-0.259,0}     -- all position from connector
    tbl.muzzle_pos_connector    = tbl.muzzle_pos_connector  or  "Gun_point" -- all position from connector
    tbl.azimuth_initial         = tbl.azimuth_initial       or  0
    tbl.elevation_initial       = tbl.elevation_initial     or  0
    if  tbl.effects == nil then
        tbl.effects = {{ name = "FireEffect"     , arg = tbl.effect_arg_number or 436 },
                       { name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 16.0},
                       { name = "SmokeEffect"},
					   { name = "GatlingEffect", arg = 44, barrels_n = 6, spin_up_t = 1, spin_down_t = 0.01}
					   }
    end
    return declare_weapon(tbl)
end



function M60_DOOR(tbl)
    tbl.category = CAT_GUN_MOUNT
    tbl.name      = "OH-6_M60_Door"
    tbl.supply      =
    {
        shells = {"OH-6 7.62x51mm M80", "OH-6 7.62x51mm M61", "OH-6 7.62x51mm M62"},
        mixes  = {{1,2,3,2,2,3}},   -- for every 6 shots there will be one M62 (tracer)
        count  = 750,		-- 2000 rounds
    }
    if tbl.mixes then
       tbl.supply.mixes = tbl.mixes
       tbl.mixes        = nil
    end
    tbl.gun =
    {
        max_burst_length    = 1, -- minimum number of rounds fired per burst
        rates               = {550},
        recoil_coeff        = 0.91,
    }
    if tbl.rates then
       tbl.gun.rates        =  tbl.rates
       tbl.rates            = nil
    end
    tbl.ejector_pos             = {-0.818,-0.144,0.022} -- position from muzzle connector pos
    tbl.ejector_dir             = {-1, -6, 0} -- left/right; back/front;?/?
    --tbl.supply_position         = tbl.supply_position   or {1.0, 0.0, 0.0}
	tbl.supply_position         = {0.0, 0.0, 0.0}
    tbl.aft_gun_mount           = false
    tbl.effective_fire_distance = 1500
    tbl.drop_cartridge          = 205	--drop shell shape/size from  aircraft_gun_mounts.lua
    tbl.muzzle_pos              = tbl.muzzle_pos            or  {0.886,-0.259,0}     -- all position from connector
    tbl.muzzle_pos_connector    = tbl.muzzle_pos_connector  or  "Gun_point" -- all position from connector
    tbl.azimuth_initial         = tbl.azimuth_initial       or  0
    tbl.elevation_initial       = tbl.elevation_initial     or  0
    if  tbl.effects == nil then
        tbl.effects = {{ name = "FireEffect"     , arg = tbl.effect_arg_number or 436 },
                       --{ name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 16.0},
                       { name = "SmokeEffect"},
					   }
    end
    return declare_weapon(tbl)
end


local function OH6_M134(tbl)
    tbl.category = CAT_GUN_MOUNT
    tbl.name      = "OH-6_M134"
    tbl.supply      =
    {
        shells = {"OH-6 7.62x51mm M80", "OH-6 7.62x51mm M61", "OH-6 7.62x51mm M62"},
        mixes  = {{1,2,3,2,2,3}},   -- for every 6 shots there will be one M62 (tracer)
        count  = 2000,		-- 2000 rounds
    }
    if tbl.mixes then
       tbl.supply.mixes = tbl.mixes
       tbl.mixes        = nil
    end
    tbl.gun =
    {
        max_burst_length    = 1, -- minimum number of rounds fired per burst
        rates               = {4000},
        recoil_coeff        = 0.07*1.3,
        barrels_count       = 6,
    }
    if tbl.rates then
       tbl.gun.rates        =  tbl.rates
       tbl.rates            = nil
    end
    tbl.ejector_pos             = {-0.818,-0.144,0.022} -- position from muzzle connector pos
    tbl.ejector_dir             = {-1, -6, 0} -- left/right; back/front;?/?
    --tbl.supply_position         = tbl.supply_position   or {1.0, 0.0, 0.0}
	tbl.supply_position         = {0.0, 0.0, 0.0}
    tbl.aft_gun_mount           = false
    tbl.effective_fire_distance = 1000
    tbl.drop_cartridge          = 205	--drop shell shape/size from  aircraft_gun_mounts.lua
    tbl.muzzle_pos              = tbl.muzzle_pos            or  {0.712411,0.052865, -0.656854}     -- all position from connector {front, up/down, left/right}
    tbl.muzzle_pos_connector    = tbl.muzzle_pos_connector  or  "Gun_point" -- all position from connector
    tbl.azimuth_initial         = tbl.azimuth_initial       or  0
    tbl.elevation_initial       = tbl.elevation_initial     or  0
    if  tbl.effects == nil then
        tbl.effects = {{ name = "FireEffect"     , arg = tbl.effect_arg_number or 436 },
                       { name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 16.0},
                       { name = "SmokeEffect"},
					   { name = "GatlingEffect", arg = 44, barrels_n = 6, spin_up_t = 1, spin_down_t = 0.01}
					   }
    end
    return declare_weapon(tbl)
end

minigun = {
    category        = CAT_PODS,
    CLSID           = "{OH-6_M134_Minigun}",
    attribute       = {wsType_Weapon,wsType_GContainer,wsType_Cannon_Cont,WSTYPE_PLACEHOLDER},
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Shell,wsType_Shell_A,wsType_oh6minigun},
    Picture         = "M134.png",
    displayName     = _("M134 Minigun"),
    Weight          = 39,      --loaded	39kg empty gun + 50.72kg ammo
    Cx_pil          = 0.00015,

	
    kind_of_shipping = 2,   -- SOLID_MUNITION
    
    --shape_table_data = {}
    shape_table_data = 
    {
        {
            name = 'OH-6_M134_Minigun',
            file = 'OH-6_M134',
            life = 1,
            fire ={0,1},
            username = 'OH-6_M134_Minigun',
            index = WSTYPE_PLACEHOLDER
        }
    },
    Elements        = {
        [1]	= {
            Position	=	{0, 0, 0},
            ShapeName	=	"OH-6_M134",
        }, 
    },
    gun_mounts      = {
        OH6_M134({})
    },
}
declare_loadout(minigun)

door_minigun = {
    category        = CAT_PODS,
    CLSID           = "{OH-6_M134_Door}",
    attribute       = {wsType_Weapon,wsType_GContainer,wsType_Cannon_Cont,WSTYPE_PLACEHOLDER},
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Shell,wsType_Shell_A,WSTYPE_PLACEHOLDER},
    Picture         = "M134.png",
    displayName     = _("M134 Door Minigun"),
    Weight          = 110,      --loaded	39kg empty gun + 50.72kg ammo
    Cx_pil          = 0.00015,
    --Elements        = {{ShapeName = "OH-6_M134_doorgun"}},
	Elements        = {},
    kind_of_shipping = 2,   -- SOLID_MUNITION
    gun_mounts      = {
        M134_DOOR({})
    },
    shape_table_data = {
        {
            file = 'OH-6_M134_doorgun',
            username = 'OH-6_M134_Minigun_Door',
            index = WSTYPE_PLACEHOLDER,
        }}
}
declare_loadout(door_minigun) 

door_m60 = {
    category        = CAT_PODS,
    CLSID           = "{OH-6_M60_Door}",
    attribute       = {wsType_Weapon,wsType_GContainer,wsType_Cannon_Cont,WSTYPE_PLACEHOLDER},
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Shell,wsType_Shell,WSTYPE_PLACEHOLDER},
    Picture         = "M60.png",
    displayName     = _("M60 Doorgun"),
    Weight          = 110,      --loaded	39kg empty gun + 50.72kg ammo
    Cx_pil          = 0.00015,
    --Elements        = {{ShapeName = "OH-6_M60_doorgun"}},
	Elements        = {},
    kind_of_shipping = 2,   -- SOLID_MUNITION
    gun_mounts      = {
        M60_DOOR({})
    },
    shape_table_data = {{file = 'OH-6_M60_doorgun'; username = 'OH-6_M60_Doorgun'; index = WSTYPE_PLACEHOLDER;}}
}
declare_loadout(door_m60)
