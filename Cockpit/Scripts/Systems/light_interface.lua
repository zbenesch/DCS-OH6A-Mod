dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()
local update_time_step = 0.1 
make_default_activity(update_time_step)

dev:listen_command(device_commands.lightpanels_pos_light)
dev:listen_command(device_commands.lightpanels_anticol_light)
dev:listen_command(device_commands.lightpanels_light_engine)
dev:listen_command(device_commands.lightpanels_light_flight)
dev:listen_command(device_commands.lightpanels_light_panel)
dev:listen_command(device_commands.lightpanels_light_radio)
dev:listen_command(Keys.inc_light_panel)
dev:listen_command(Keys.dec_light_panel)
dev:listen_command(Keys.inc_light_radio)
dev:listen_command(Keys.dec_light_radio)
dev:listen_command(Keys.inc_light_engine)
dev:listen_command(Keys.dec_light_engine)
dev:listen_command(Keys.inc_light_flight)
dev:listen_command(Keys.dec_light_flight)
dev:listen_command(Keys.pos_light_off)
dev:listen_command(Keys.pos_light_dim)
dev:listen_command(Keys.pos_light_bright)
dev:listen_command(Keys.acol_light_off)
dev:listen_command(Keys.acol_light_on)


dev:listen_command(Keys.LandingLight)

local mid_panel_lights = get_param_handle("Mid_Panel_Lights")
local flight_lights = get_param_handle("Flight_Lights")
local engine_lights = get_param_handle("Engine_Lights")
local radio_lights = get_param_handle("Radio_Lights")

local dc_elec = get_param_handle("DC_POWER_AVAIL")
local LIGHTS_CURRENT = get_param_handle("LIGHTS_CURRENT")

local mid_panel_lights_value = 0.0
local engine_lights_value = 0.0
local flight_lights_value = 0.0
local radio_lights_value = 0.0
local taxi_light = 0.0
local pos_light = 0.0
local acol_light = 0.0
local current = 0.0
local dc_ok = 0

local dev = GetSelf()

local acol_timer = 0.0

function update_lights()
    dc_ok = dc_elec:get()
    current = 0.0
    
    mid_panel_lights:set(mid_panel_lights_value * dc_ok)
    engine_lights:set(engine_lights_value * dc_ok)
    flight_lights:set(flight_lights_value * dc_ok)
    radio_lights:set(radio_lights_value * dc_ok)
    
    current = current + taxi_light*dc_ok*2
    current = current + pos_light*dc_ok*2
    current = current + acol_light*dc_ok*2
    
    set_aircraft_draw_argument_value(115,taxi_light*dc_ok)
        
    set_aircraft_draw_argument_value(120,pos_light*dc_ok)
    set_aircraft_draw_argument_value(121,pos_light*dc_ok)
    set_aircraft_draw_argument_value(122,pos_light*dc_ok)
    
    acol_timer = acol_timer + update_time_step
    if acol_timer > 1.0 then
        acol_timer = 0.0
    end
    local acol_on = 0.0
    if acol_timer < 0.1 then
        acol_on = 1.0
    end
    set_aircraft_draw_argument_value(123,acol_on*acol_light*dc_ok)
    set_aircraft_draw_argument_value(124,acol_on*acol_light*dc_ok)

end

function post_initialize()
    local abstime = get_absolute_model_time()
    local hours = abstime / 3600.0
    
    local birth = LockOn_Options.init_conditions.birth_place
	if birth=="GROUND_HOT" or birth=="AIR_HOT" then
        local light_enable = 0.0
        if hours <= 6 or hours >= 17 then
            light_enable = 1.0
            taxi_light = 1.0
        end
        mid_panel_lights_value = 0.5 * light_enable
        engine_lights_value = 0.5 * light_enable
        flight_lights_value = 0.5 * light_enable
        radio_lights_value = 0.5 * light_enable
        
        dev:performClickableAction(device_commands.lightpanels_anticol_light,2*light_enable-1.0,true)
        dev:performClickableAction(device_commands.lightpanels_pos_light,light_enable,true)
    elseif birth == "GROUND_COLD" then
        mid_panel_lights_value = 0.0
        engine_lights_value = 0.0
        flight_lights_value = 0.0
        radio_lights_value = 0.0
        dev:performClickableAction(device_commands.lightpanels_anticol_light,-1.0,true)
        dev:performClickableAction(device_commands.lightpanels_pos_light,0.0,true)
    end
    dev:performClickableAction(device_commands.lightpanels_light_flight,2*flight_lights_value-1.0,true)
    dev:performClickableAction(device_commands.lightpanels_light_engine,2*engine_lights_value-1.0,true)
    dev:performClickableAction(device_commands.lightpanels_light_panel,2*mid_panel_lights_value-1.0,true)
    dev:performClickableAction(device_commands.lightpanels_light_radio,2*radio_lights_value-1.0,true)

    
    update_lights()
end

function SetCommand(command,value)
    if command == device_commands.lightpanels_light_engine then
        engine_lights_value = (value+1.0)*0.5
    end
    if command == Keys.inc_light_engine then 
        engine_lights_value =engine_lights_value+ 0.005
        if engine_lights_value > 1.0 then engine_lights_value = 1.0 end
        dev:performClickableAction(device_commands.lightpanels_light_engine,2*engine_lights_value-1.0,true)
    end
    if command == Keys.dec_light_engine then 
        engine_lights_value =engine_lights_value- 0.005
        if engine_lights_value < 0.0 then engine_lights_value = 0.0 end
        dev:performClickableAction(device_commands.lightpanels_light_engine,2*engine_lights_value-1.0,true)
    end

    if command == device_commands.lightpanels_light_flight then
        flight_lights_value = (value+1.0)*0.5
    end
    if command == Keys.inc_light_flight then 
        flight_lights_value =flight_lights_value+ 0.005
        if flight_lights_value > 1.0 then flight_lights_value = 1.0 end
        dev:performClickableAction(device_commands.lightpanels_light_flight,2*flight_lights_value-1.0,true)
    end
    if command == Keys.dec_light_flight then 
        flight_lights_value =flight_lights_value- 0.005
        if flight_lights_value < 0.0 then flight_lights_value = 0.0 end
        dev:performClickableAction(device_commands.lightpanels_light_flight,2*flight_lights_value-1.0,true)
    end

    if command == device_commands.lightpanels_light_panel then
        mid_panel_lights_value = (value+1.0)*0.5
    end
    if command == Keys.inc_light_panel then 
        mid_panel_lights_value =mid_panel_lights_value+ 0.005
        if mid_panel_lights_value > 1.0 then mid_panel_lights_value = 1.0 end
        dev:performClickableAction(device_commands.lightpanels_light_panel,2*mid_panel_lights_value-1.0,true)
    end
    if command == Keys.dec_light_panel then 
        mid_panel_lights_value =mid_panel_lights_value- 0.005
        if mid_panel_lights_value < 0.0 then mid_panel_lights_value = 0.0 end
        dev:performClickableAction(device_commands.lightpanels_light_panel,2*mid_panel_lights_value-1.0,true)
    end

    if command == device_commands.lightpanels_light_radio then
        radio_lights_value = (value+1.0)*0.5
    end
    if command == Keys.inc_light_radio then 
        radio_lights_value =radio_lights_value+ 0.005
        if radio_lights_value > 1.0 then radio_lights_value = 1.0 end
        dev:performClickableAction(device_commands.lightpanels_light_radio,2*radio_lights_value-1.0,true)
    end
    if command == Keys.dec_light_radio then 
        radio_lights_value =radio_lights_value- 0.005
        if radio_lights_value < 0.0 then radio_lights_value = 0.0 end
        dev:performClickableAction(device_commands.lightpanels_light_radio,2*radio_lights_value-1.0,true)
    end

    if command == device_commands.lightpanels_pos_light then
        if value < -0.5 then
            pos_light = 0.5
        elseif value >0.5 then
            pos_light = 1.0
        else
            pos_light = 0.0
        end
    end
    if command == Keys.pos_light_off then 
        dev:performClickableAction(device_commands.lightpanels_pos_light,0.0,true)
    end
    if command == Keys.pos_light_dim then 
        dev:performClickableAction(device_commands.lightpanels_pos_light,-1.0,true)
    end
    if command == Keys.pos_light_bright then 
        dev:performClickableAction(device_commands.lightpanels_pos_light,1.0,true)
    end


    if command == device_commands.lightpanels_anticol_light then
        if value < 0.5 then
            acol_light = 0.0
        else
            acol_light = 1.0
        end
    end
    if command == Keys.acol_light_off then 
        dev:performClickableAction(device_commands.lightpanels_anticol_light,-1.0,true)
    end
    if command == Keys.acol_light_on then 
        dev:performClickableAction(device_commands.lightpanels_anticol_light,1.0,true)
    end

    
    if command == Keys.LandingLight then
        if taxi_light < 0.5 then
            taxi_light = 1.0
        else
            taxi_light = 0.0
        end
    end
end

function update()
    update_lights()
    LIGHTS_CURRENT:set(current)
end

need_to_be_closed = false -- close lua state after initialization

