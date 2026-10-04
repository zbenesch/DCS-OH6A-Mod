dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")


local dc_ok = false
local ac_ok = false
local gen_enabled = false
local gyro_enabled = false
local inverter_enabled = false
local current = 0.0

local flash_time = 0.0
local flash_interval = 0.25


local dev = GetSelf()
local update_time_step = 0.05 
make_default_activity(update_time_step)

dev:listen_command(device_commands.electricsystem_batt)
dev:listen_command(device_commands.electricsystem_inverter)
dev:listen_command(device_commands.electricsystem_gen)
dev:listen_command(device_commands.electricsystem_fuel_pump)
dev:listen_command(device_commands.electricsystem_aux_tank)
dev:listen_command(device_commands.electricsystem_gyro)
dev:listen_command(Keys.BattSwitchBatt)
dev:listen_command(Keys.BattSwitchOff)
dev:listen_command(Keys.BattSwitchExt)
dev:listen_command(Keys.gen_on)
dev:listen_command(Keys.gen_off)
dev:listen_command(Keys.gen_toggle)
dev:listen_command(Keys.inverter_on)
dev:listen_command(Keys.inverter_off)
dev:listen_command(Keys.inverter_toggle)
dev:listen_command(Keys.gyro_mag)
dev:listen_command(Keys.gyro_dir)
dev:listen_command(Keys.gyro_toggle)


local dc_elec = get_param_handle("DC_POWER_AVAIL")
local ac_elec = get_param_handle("AC_POWER_AVAIL")

local BATTERY_VOLTAGE = get_param_handle("BATTERY_VOLTAGE")
local GENERATOR_VOLTAGE = get_param_handle("GENERATOR_VOLTAGE")
local INVERTER_VOLTAGE = get_param_handle("INVERTER_VOLTAGE")

local WARNING_GEN_OUT = get_param_handle("Warning_Generator_Out")
local gyro_on = get_param_handle("GYRO_ON")

local IND_DCAMPS = get_param_handle("IND_DCAMPS")
local STARTER_CURRENT = get_param_handle("STARTER_CURRENT")
local LIGHTS_CURRENT = get_param_handle("LIGHTS_CURRENT")
local WEAPONS_CURRENT = get_param_handle("WEAPONS_CURRENT")

local WARNING_ENGINE_OUT = get_param_handle("Warning_Engine_Out")
local WARNING_OIL_PRESS = get_param_handle("Warning_Oil_Press")
local N2 = get_param_handle("RPM_N2")
local N1 = get_param_handle("RPM_N1")
local THROTTLE  = get_param_handle("THROTTLE")

local MR_CHIPS = get_param_handle("MR_CHIPS")
local WARNING_OIL_CHIPS=get_param_handle("Warning_Oil_Chips")

function post_initialize()

	sndhost = create_sound_host("COCKPIT_ELEC","HEADPHONES",-1.0,1.0,0)
	warning_sound = sndhost:create_sound("Cockpit/engine_warning")
	--warning_sound = sndhost:create_sound("Cockpit/prep_red")
	

	local birth = LockOn_Options.init_conditions.birth_place
	if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
		dev:performClickableAction(device_commands.electricsystem_batt,-1.0,true)
		dev:performClickableAction(device_commands.electricsystem_inverter,1.0,true)
		dev:performClickableAction(device_commands.electricsystem_gen, 1.0,true)
		dev:performClickableAction(device_commands.electricsystem_fuel_pump,-1.0,true)
		dev:performClickableAction(device_commands.electricsystem_aux_tank,-1.0,true)
		dev:performClickableAction(device_commands.electricsystem_gyro,1.0,true)
		
		dispatch_action(nil, EFM_commands.electricsystem_batt,-1.0)
		dispatch_action(nil, EFM_commands.electricsystem_inverter,1.0)
		dispatch_action(nil, EFM_commands.electricsystem_gen, 1.0)
		dispatch_action(nil, EFM_commands.electricsystem_fuel_pump,-1.0)
		dispatch_action(nil, EFM_commands.electricsystem_aux_tank,-1.0)
		dispatch_action(nil, EFM_commands.electricsystem_gyro,1.0)
		
		inverter_enabled = true
		gyro_enabled = true
		gen_enabled = true
		
    elseif birth=="GROUND_COLD" then
		dev:performClickableAction(device_commands.electricsystem_batt,0.0,true)
		dev:performClickableAction(device_commands.electricsystem_inverter,0.0,true)
		dev:performClickableAction(device_commands.electricsystem_gen,0.0,true)
		dev:performClickableAction(device_commands.electricsystem_fuel_pump,0.0,true)
		dev:performClickableAction(device_commands.electricsystem_aux_tank,0.0,true)
		dev:performClickableAction(device_commands.electricsystem_gyro,0.0,true)
		dispatch_action(nil, EFM_commands.electricsystem_batt,0.0)
		dispatch_action(nil, EFM_commands.electricsystem_inverter,0.0)
		dispatch_action(nil, EFM_commands.electricsystem_gen,0.0)
		dispatch_action(nil, EFM_commands.electricsystem_fuel_pump,0.0)
		dispatch_action(nil, EFM_commands.electricsystem_aux_tank,0.0)
		dispatch_action(nil, EFM_commands.electricsystem_gyro,0.0)
		
		inverter_enabled = false
		gyro_enabled = false
		gen_enabled = false
    end
end

function SetCommand(command,value)
	
	if command == device_commands.electricsystem_batt then
		dispatch_action(nil, EFM_commands.electricsystem_batt,value)
	end

	if command == Keys.BattSwitchBatt then 
		dev:performClickableAction(device_commands.electricsystem_batt,-1.0,true)
	end
	if command == Keys.BattSwitchOff then 
		dev:performClickableAction(device_commands.electricsystem_batt,0.0,true)
	end
	if command == Keys.BattSwitchExt then 
		dev:performClickableAction(device_commands.electricsystem_batt,1.0,true)
	end

	if command == device_commands.electricsystem_inverter then
		dispatch_action(nil, EFM_commands.electricsystem_inverter,value)
		if value > 0.5 then 
			inverter_enabled =true 
		else
			inverter_enabled =false
		end 
	end
	if command == Keys.inverter_on then 
		dev:performClickableAction(device_commands.electricsystem_inverter,1.0,true)
	end
	if command == Keys.inverter_off then 
		dev:performClickableAction(device_commands.electricsystem_inverter,0.0,true)
	end
	if command == Keys.inverter_toggle then 
		if inverter_enabled then 
			dev:performClickableAction(device_commands.electricsystem_inverter,0.0,true)
		else
			dev:performClickableAction(device_commands.electricsystem_inverter,1.0,true)
		end
	end


	if command == device_commands.electricsystem_gen then
		if value >0.5 then
			gen_enabled = true
		else
			gen_enabled = false
		end
		dispatch_action(nil, EFM_commands.electricsystem_gen,value)
	end
	if command == Keys.gen_on then 
		dev:performClickableAction(device_commands.electricsystem_gen,1.0,true)
	end
	if command == Keys.gen_off then 
		dev:performClickableAction(device_commands.electricsystem_gen,0.0,true)
	end
	if command == Keys.gen_toggle then
		if gen_enabled then 
			dev:performClickableAction(device_commands.electricsystem_gen,0.0,true)
		else
			dev:performClickableAction(device_commands.electricsystem_gen,1.0,true)
		end
	end

	if command == device_commands.electricsystem_fuel_pump then
		dispatch_action(nil, EFM_commands.electricsystem_fuel_pump,value)
	end

	if command == device_commands.electricsystem_aux_tank then
		dispatch_action(nil, EFM_commands.electricsystem_aux_tank,value)
	end

	if command == device_commands.electricsystem_gyro then
		gyro_enabled = value > 0.5
		dispatch_action(nil, EFM_commands.electricsystem_gyro,value)
	end
	if command == Keys.gyro_mag then 
		dev:performClickableAction(device_commands.electricsystem_gyro,1.0,true)
	end
	if command == Keys.gyro_dir then 
		dev:performClickableAction(device_commands.electricsystem_gyro,0.0,true)
	end
	if command == Keys.gyro_toggle then
		if gyro_enabled then 
			dev:performClickableAction(device_commands.electricsystem_gyro,0.0,true)
		else
			dev:performClickableAction(device_commands.electricsystem_gyro,1.0,true)
		end
	end
end

local function gen_ok()
	if GENERATOR_VOLTAGE:get() > BATTERY_VOLTAGE:get() then
		return true
	else
		return false
	end
end

local function update_generator()
	if not gen_ok() then 
		if dc_ok then 
			WARNING_GEN_OUT:set(1.0)
		else
			WARNING_GEN_OUT:set(0.0)
		end
	else
		WARNING_GEN_OUT:set(0.0)
	end
end

local function update_engine_warning()
	flash_time = flash_time +update_time_step
	if flash_time > 2 * flash_interval then 
		flash_time = 0.0
	end

	--print_message_to_user(THROTTLE:get())
	if dc_ok then
		if N1:get()*1.2 < 0.55 then
			if flash_time > flash_interval then 
				WARNING_ENGINE_OUT:set(1.0)
				WARNING_OIL_PRESS:set(0.0)
			else
				WARNING_ENGINE_OUT:set(0.0)
				WARNING_OIL_PRESS:set(1.0)
			end
			if gen_enabled then 
				warning_sound:play_continue()
			else
				warning_sound:stop()
			end
		else
			if N2:get() < 0.95 and gen_enabled and THROTTLE:get()>0.95 then
				WARNING_ENGINE_OUT:set(1.0)
				warning_sound:play_continue()
			else
				WARNING_ENGINE_OUT:set(0.0)
				warning_sound:stop()
			end
			WARNING_OIL_PRESS:set(0.0)
		end
		if MR_CHIPS:get()>.5 then
			WARNING_OIL_CHIPS:set(1.0)
		else
			WARNING_OIL_CHIPS:set(0.0)
		end
	else
		warning_sound:stop()
		WARNING_ENGINE_OUT:set(0.0)
		WARNING_OIL_PRESS:set(0.0)
		WARNING_OIL_CHIPS:set(0.0)
	end
end

function update()
	dc_ok = dc_elec:get() > 0.5
	ac_ok = ac_elec:get() > 0.5
	local base_current = 0.0
	
	if dc_ok then 
		base_current = base_current + 15.0
	end

	if ac_ok and gyro_enabled then 
		gyro_on:set(1.0)
		base_current = base_current+10.0
	else
		gyro_on:set(0.0)
	end
	update_generator()
	update_engine_warning()
	
	current = base_current +STARTER_CURRENT:get()+ LIGHTS_CURRENT:get() + WEAPONS_CURRENT:get()
	IND_DCAMPS:set(current)
	dev:DC_Battery_on(dc_ok)
    dev:AC_Generator_1_on(ac_ok)
end

need_to_be_closed = false -- close lua state after initialization

