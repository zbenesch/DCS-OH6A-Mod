dofile(LockOn_Options.script_path.."command_defs.lua")
local radian_to_degree = 57.2957795
local dev = GetSelf()
local sensor_data = get_base_data()
local update_time_step = 0.05  
make_default_activity(update_time_step)

local compass_pitch = get_param_handle("Compass_Pitch")
local compass_bank = get_param_handle("Compass_Bank")
local compass_hdg = get_param_handle("Compass_HDG")


local vx = 0.0
local vz = 0.0
local pitch =0.0
local bank = 0.0

local m = 1.0
local k = math.sqrt(1.5)
local d = 0.05

function post_initialize()
    update()

	local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
		
    elseif birth=="GROUND_COLD" then
		
    end
end


function SetCommand(command,value)   

end


function update()
    local ay = sensor_data.getVerticalAcceleration()
	local ax = sensor_data.getHorizontalAcceleration() 
	local az = sensor_data.getLateralAcceleration() 
    local l = math.sqrt(ax*ax+ay*ay+az*az)
    local dz = -math.asin(az/l)
    local dx = -math.asin(ax/l)


    local a_z = -k/m*(pitch-dz)-vz*d/m
    local a_x = -k/m*(bank-dx)-vx*d/m
    vx = vx + a_x*update_time_step
    vz = vz + a_z*update_time_step
    pitch = pitch + vz * update_time_step
    bank = bank + vx * update_time_step
	compass_pitch:set(pitch*radian_to_degree)
	compass_bank:set(bank*radian_to_degree)
	
    compass_hdg:set(sensor_data.getHeading()*radian_to_degree)

end

need_to_be_closed = false 