dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

local dev 	    = GetSelf()
local update_time_step = 0.2  -- Reduced from 0.1 to 0.2 to reduce CPU load from terrain visibility checks
make_default_activity(update_time_step)


local radian_to_degree = 57.2957795

local default_frequency = 430E3
local min_frequency = 190E3
local max_frequency = 1799E3
local current_frequency = default_frequency

local default_value = 0.0
local min_volume = 0.0
local max_volume = 1.0
local current_volume = default_value
local power_position=1
local is_on = true

local heading = 0.0
local gyro_ok

local band = 1
local frequency_parameter = 0.0666


local band_param = get_param_handle("Anarc83Band")
local freq_param = get_param_handle("Anarc83Freq")
local power_param = get_param_handle("Anarc83TuneMeter")
local adf_param = get_param_handle("ID_1351_ADF")
local adf2_param = get_param_handle("ID_1351_ADF2")
local compass_hdg = get_param_handle("ID_1351_HDG")

local ID_1351_OFF = get_param_handle("ID_1351_OFF")
local ac_elec = get_param_handle("AC_POWER_AVAIL")
local gyro_on = get_param_handle("GYRO_ON")

local function calc_frequency()
    if band == 0 then 
        current_frequency = 190E3+(400E3-190E3)*frequency_parameter
    elseif band == 1 then 
        current_frequency = 400E3+(850E3-400E3)*frequency_parameter
    else
        current_frequency = 850E3+(1800E3-850E3)*frequency_parameter
    end
    --print_message_to_user("ADF - Frequency: " .. current_frequency / 1E+3)
end

local current_antenna = 0.0

local sensor_data = get_base_data()

dev:listen_command(Keys.anarc_83_mode_up)
dev:listen_command(Keys.anarc_83_mode_down)
dev:listen_command(Keys.anarc_83_band_up)
dev:listen_command(Keys.anarc_83_band_down)
dev:listen_command(Keys.anarc_83_tune_up)
dev:listen_command(Keys.anarc_83_tune_down)
dev:listen_command(Keys.anarc_83_gain_up)
dev:listen_command(Keys.anarc_83_gain_down)

dev:listen_command(device_commands.anarc83_loop)
dev:listen_command(device_commands.anarc83_switch)
dev:listen_command(device_commands.anarc83_power)
dev:listen_command(device_commands.anarc83_gain)
dev:listen_command(device_commands.anarc83_band)
dev:listen_command(device_commands.anarc83_tune)


function SetCommand(command, value)

	if command==Keys.anarc_83_mode_up then
        power_position = power_position +1.0/3.0
        if power_position >1.0 then power_position=1.0 end
        dev:performClickableAction(device_commands.anarc83_power,power_position,true)

    elseif command == Keys.anarc_83_mode_down then
        power_position = power_position -1.0/3.0
        if power_position <0.0 then power_position=0.0 end
        dev:performClickableAction(device_commands.anarc83_power,power_position,true)

    elseif command == Keys.anarc_83_band_up then
        band = band + 1
        if band > 2 then band = 2 end
        dev:performClickableAction(device_commands.anarc83_band,band*0.5,true)

    elseif command == Keys.anarc_83_band_down then
        band = band - 1
        if band < 0 then band = 0 end
        dev:performClickableAction(device_commands.anarc83_band,band*0.5,true)

    elseif command == Keys.anarc_83_tune_up then
        dev:performClickableAction(device_commands.anarc83_tune,0.025,true)
    elseif command == Keys.anarc_83_tune_down then
        dev:performClickableAction(device_commands.anarc83_tune,-0.025,true)
    elseif command == Keys.anarc_83_gain_up then
    elseif command == Keys.anarc_83_gain_down then
    elseif command == device_commands.anarc83_loop then
    elseif command == device_commands.anarc83_switch then
    elseif command == device_commands.anarc83_power then
        power_position = value
        if power_position >0.2 and power_position< 0.4 then 
            is_on = true
        else
            is_on = false
        end
    elseif command == device_commands.anarc83_gain then
    elseif command == device_commands.anarc83_band then
        band = value *2.0
    elseif command == device_commands.anarc83_tune then
        frequency_parameter = frequency_parameter+value
        if frequency_parameter < 0.0 then frequency_parameter = 0.0 end 
        if frequency_parameter > 1.0 then frequency_parameter = 1.0 end 
        calc_frequency()
    end


end

function post_initialize()
	-- this loads the beacon data, which makes the "beacons" table available
	dofile(LockOn_Options.script_path.."Nav/nav_data.lua")
    

    dev:performClickableAction(device_commands.anarc83_band,0.5,true)
	local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
        dev:performClickableAction(device_commands.anarc83_mode,0.33,true)
		
    elseif birth=="GROUND_COLD" then
        dev:performClickableAction(device_commands.anarc83_mode,0.0,true)
        is_on = false
		
    end
    calc_frequency()
end

function update()
    local power = 0.0
    gyro_ok = gyro_on:get() > 0.5

    if gyro_ok then 
        heading = sensor_data.getHeading()*radian_to_degree
        ID_1351_OFF:set(1.0)
    else
        ID_1351_OFF:set(0.0)
    end

	compass_hdg:set(360-heading)
	if is_on == true then		
        calc_frequency()
	 	local x, y, z = sensor_data.getSelfCoordinates()
		local selfPosition = { x, y, z }

		local bearing, power_s = GetBearingADF(selfPosition, current_frequency)
		power = power_s
		if bearing ~= nil then			
			current_antenna = bearing - (360-sensor_data.getHeading()*radian_to_degree)
		else
			current_antenna = 90
		end	
        if current_antenna<-180.0 then current_antenna = current_antenna+360.0 end
        if current_antenna> 180.0 then current_antenna = current_antenna-180.0 end
		adf_param:set(current_antenna)
        adf2_param:set(-current_antenna)
		--print_message_to_user("ADF - Bearing: " .. current_antenna)
        --print_message_to_user("ADF - Bearing: " .. current_antenna)
        --print_message_to_user("ADF - Frequency: " .. current_frequency)
        --print_message_to_user("ADF - Power: " .. power)
	end
    freq_param:set(frequency_parameter)
    band_param:set(band-1.0)
    power_param:set(power)
end

need_to_be_closed = false -- close lua state after initialization
