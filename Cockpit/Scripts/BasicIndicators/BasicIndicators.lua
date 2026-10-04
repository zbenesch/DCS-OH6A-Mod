dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()
local sensor_data = get_base_data()
local update_time_step = 0.05  
make_default_activity(update_time_step)

dev:listen_command(device_commands.avionic_baroAltPressure)

local meterspersecond_to_knots =1.94384

local meters_to_feet = 3.2808399

local ALT_PRESSURE_MAX = 30.99 -- in Hg
local ALT_PRESSURE_MIN = 29.10 -- in Hg
local ALT_PRESSURE_STD = 29.92 -- in Hg

local adi_bank = get_param_handle("ADI_BANK") 
local adi_pitch = get_param_handle("ADI_PITCH") 
local adi_slip = get_param_handle("ADI_SLIP") 


local ias_pilot = get_param_handle("IND_IAS") 
local climb = get_param_handle("IND_CLIMB") 


local alt_adj_Nxxx = get_param_handle("altadjNxxx") 
local alt_adj_xNxx = get_param_handle("altadjxNxx") 
local alt_adj_xxNx = get_param_handle("altadjxxNx") 
local alt_adj_xxxN = get_param_handle("altadjxxxN") 

local alt_ind = get_param_handle("altind") 

local alt_Nxx = get_param_handle("altNxx") 
local alt_xNx = get_param_handle("altxNx") 
local alt_xxN = get_param_handle("altxxN") 

local alt_off = get_param_handle("ALTITUDE_OFF")
local att_off = get_param_handle("ATTITUDE_OFF")

local ac_elec = get_param_handle("AC_POWER_AVAIL")
local dc_elec = get_param_handle("DC_POWER_AVAIL")
local gyro_on = get_param_handle("GYRO_ON")

local alt_setting

local ac_ok = false
local dc_ok = false
local gyro_ok = false

local roll = 0.0
local pitch = 0.0
local slip = 0.0
local alt=0

ias_pilot:set(0.0)


function post_initialize()
	--current_hdg:set(360-(sensor_data.getHeading()*radian_to_degree))
	update_ias()
	update_climb()
	alt_setting = ALT_PRESSURE_STD
	local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
        		
    elseif birth=="GROUND_COLD" then
        		
    end
end

--dev:listen_command(device_commands.AltimeterSet)
function SetCommand(command,value)   
    if command == device_commands.avionic_baroAltPressure then
		alt_setting = alt_setting + value*0.5
		if alt_setting > ALT_PRESSURE_MAX then
			alt_setting = ALT_PRESSURE_MAX
		elseif alt_setting < ALT_PRESSURE_MIN then
			alt_setting = ALT_PRESSURE_MIN
		end
	end
end

function update_ias()
	local ias = sensor_data.getIndicatedAirSpeed()* meterspersecond_to_knots
	local ias_arg = ias / 150.0 
	if not dc_ok then
		ias_arg = 0.0
	end
	ias_pilot:set(ias_arg)
end

function update_slip()
	local ay = sensor_data.getVerticalAcceleration()
	local ax = sensor_data.getHorizontalAcceleration() 
	local az = sensor_data.getLateralAcceleration() 
	--print_message_to_user(math.sqrt(ax*ax+ay*ay+az*az))
	local slip_acc = az/math.sqrt(ax*ax+ay*ay+az*az)
	local update_fac = 0.1
	slip = (1-update_fac)*slip + update_fac * slip_acc
	adi_slip:set(-2*math.pi*slip)
end

function update_climb()
	local v_speed = sensor_data.getVerticalVelocity()* meters_to_feet/1000*60
	--print_message_to_user(v_speed)
	v_arg=0.0
	--v=math.abs(v_speed)
	if dc_ok then 
		v=v_speed
		if v > 6.0 then 
			v=6.0
		end
		if v < -6.0 then 
			v=-6.0
		end
	end
	
	climb:set(v)
	
end

function update_adi()
	if gyro_ok then
		roll = sensor_data.getRoll()
		pitch = sensor_data.getPitch()
		att_off:set(1.0)
	else
		att_off:set(0.0)
	end
	
	adi_bank:set(roll)
	adi_pitch:set(0.5*pitch)
end

function update_altimeter()
	if dc_ok then
    	alt = sensor_data.getBarometricAltitude()*meters_to_feet
		alt_off:set(1.0)
	else
		alt_off:set(0.0)
	end
		 
	local altadjNxxx, rest = math.modf(alt_setting/10) 
	local altadjxNxx, rest = math.modf(rest*10) 
	local altadjxxNx, rest = math.modf(rest*10) 
	local altadjxxxN, rest = math.modf(rest*10) 
	
    alt_adj_Nxxx:set(0.1*altadjNxxx)
	alt_adj_xNxx:set(0.1*altadjxNxx)
    alt_adj_xxNx:set(0.1*altadjxxNx)
    alt_adj_xxxN:set(0.1*altadjxxxN)

	-- based on setting, adjust displayed altitude
    local alt_adj = alt + (alt_setting - ALT_PRESSURE_STD)*1000   -- 1000 feet per inHg / 10 feet per .01 
	local altNxx, rest = math.modf(alt_adj/10000) 
	local altxNx, rest = math.modf(rest*10) 
	local altind = rest
	local altxxN, rest = math.modf(rest*10) 
	
	--print_message_to_user("Alt: " .. tostring(alt_adj).. "ind: " .. tostring(altind))
	alt_ind:set(altind)
	alt_Nxx:set(0.1*altNxx)
	alt_xNx:set(0.1*altxNx)
	alt_xxN:set(0.1*altxxN)
end



function update()
	ac_ok = ac_elec:get() > 0.5
	dc_ok = dc_elec:get() > 0.5
	gyro_ok = gyro_on:get() > 0.5
	--update_ias()
	update_adi()
	update_slip()
	update_climb()
	update_altimeter()
--	update_radar_altitude()
end

need_to_be_closed = false 