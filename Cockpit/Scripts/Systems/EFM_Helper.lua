dofile(LockOn_Options.script_path.."command_defs.lua")

local update_rate = 0.1
make_default_activity(update_rate)
local dev = GetSelf()

local SHOW_CONTROLS  = get_param_handle("SHOW_CONTROLS")
local EFM_VERSION  = get_param_handle("EFM_VERSION")

local COLLECTIVE_BUTTON_SENS  = get_param_handle("COLLECTIVE_BUTTON_SENS")
local PEDAL_BUTTON_SENS  = get_param_handle("PEDAL_BUTTON_SENS")
local CYCLIC_BUTTON_SENS  = get_param_handle("CYCLIC_BUTTON_SENS")


local warning_timer = 0.0

local govtrim
local sensor_data = get_base_data()

local TRIMMING_METHOD = get_param_handle("TRIMMING_METHOD")
local PEDAL_TRIM = get_param_handle("PEDAL_TRIM")
local TRIM_FADE_TIME = get_param_handle("TRIM_FADE_TIME")

function post_initialize()

	local cyclic_sens = get_plugin_option_value("OH-6A", "OH6CyclicButtonSensitivity", "local")
	CYCLIC_BUTTON_SENS:set(cyclic_sens)
	local pedal_sens = get_plugin_option_value("OH-6A", "OH6PedalButtonSensitivity", "local")
	PEDAL_BUTTON_SENS:set(pedal_sens)
	local collective_sens = get_plugin_option_value("OH-6A", "OH6CollectiveButtonSensitivity", "local")
	COLLECTIVE_BUTTON_SENS:set(collective_sens)
	local show_controls_on_init = get_plugin_option_value("OH-6A", "OH6ShowControls", "local")

	local pedal_trim = get_plugin_option_value("OH-6A", "OH6PedalTrim", "local")
	local trim_fade_time = get_plugin_option_value("OH-6A", "OH6TrimFade", "local")/500.0;
	TRIM_FADE_TIME:set(trim_fade_time)
	if pedal_trim == true then 
		PEDAL_TRIM:set(1)
	else
		PEDAL_TRIM:set(0)
	end
	
	if show_controls_on_init == true then 
		SHOW_CONTROLS:set(1.0)
	else
		SHOW_CONTROLS:set(0.0)
	end
end

local option_trimming_method = get_plugin_option_value("OH-6A", "OH6TrimmingMethod", "local")

dev:listen_command(Keys.showControlInd)

dev:listen_command(Keys.LogDataPoint)
dev:listen_command(Keys.StartLateralFT)
dev:listen_command(Keys.StartLongFT)

external_power = get_param_handle("EXTERNAL_POWER")
external_power:set(0)

dev:listen_event("GroundPowerOn")
dev:listen_event("GroundPowerOff")

local DM470 = get_param_handle("DM470")
local DM471 = get_param_handle("DM471")
local DM472 = get_param_handle("DM472")
local DM473 = get_param_handle("DM473")
local DM474 = get_param_handle("DM474")



function SetCommand(command,value)
	if command == Keys.showControlInd then
		SHOW_CONTROLS:set(1-SHOW_CONTROLS:get())
	end
	
	if command == Keys.StartLateralFT then
		dispatch_action(nil,EFM_commands.startLateralFT,1.0)
	end
	
	if command == Keys.StartLongFT then
		dispatch_action(nil,EFM_commands.startLongFT,1.0)
	end
	
	if command == Keys.LogDataPoint then
		dispatch_action(nil,EFM_commands.logDataPoint,1)
	end
	
end

function CockpitEvent(event,val)
    if event == "GroundPowerOn" then
        external_power:set(1)
    elseif event == "GroundPowerOff" then
        external_power:set(0)
    end
end

function update()
	if EFM_VERSION:get() ~= 1.7 then 
		if warning_timer>5 then 
			warning_timer = 0
			print_message_to_user("Incompatible EFM DLL. Please Check Installation")
		end
		warning_timer = warning_timer+update_rate
	end
	TRIMMING_METHOD:set(option_trimming_method)


	DM470:set(get_aircraft_draw_argument_value(470))
	DM471:set(get_aircraft_draw_argument_value(471))
	DM472:set(get_aircraft_draw_argument_value(472))
	DM473:set(get_aircraft_draw_argument_value(473))
	DM474:set(get_aircraft_draw_argument_value(474))
end


need_to_be_closed = false -- close lua state after initialization