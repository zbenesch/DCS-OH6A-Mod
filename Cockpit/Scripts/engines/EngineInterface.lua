dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()
local sensor_data = get_base_data()
local update_time_step = 0.05  
local govtrim = 0.0

local throttle_idle = 0.09
local throttle = 1.00

local above_idle = true
local THROTTLE  = get_param_handle("THROTTLE")

local THROTTLE_DRAW  = get_param_handle("THROTTLE_DRAW")
local THROTTLE_IDLE_DRAW  = get_param_handle("COLLECTIVE_IDLE")
local COLLECTIVE_THROTTLE  = get_param_handle("COLLECTIVE_THROTTLE")

local dc_elec = get_param_handle("DC_POWER_AVAIL")


local dc_ok = false

local full_throttle = false

make_default_activity(update_time_step)


dev:listen_command(Keys.throttleAxis)
dev:listen_command(Keys.ThrottleIncrease)
dev:listen_command(Keys.ThrottleDecrease)
dev:listen_command(Keys.ThrottleIdle)
dev:listen_command(Keys.ThrottleCutoff)
dev:listen_command(Keys.GovTrimUp)
dev:listen_command(Keys.GovTrimDown)
dev:listen_command(Keys.StarterButton)
dev:listen_command(Keys.StarterButtonRelease)

function update_throttle()
	full_throttle = throttle > 0.98
	dispatch_action(nil,EFM_commands.throttle,throttle)
	THROTTLE:set(throttle)
	if throttle < throttle_idle then 
		THROTTLE_DRAW:set(0.0)
		COLLECTIVE_THROTTLE:set((throttle)/throttle_idle*0.3)
		THROTTLE_IDLE_DRAW:set(1.0)
	else
		THROTTLE_DRAW:set((throttle-throttle_idle)/(1.0-throttle_idle)*0.9+0.1)
		COLLECTIVE_THROTTLE:set((throttle-throttle_idle)/(1-throttle_idle)*0.7+0.3)
		THROTTLE_IDLE_DRAW:set(0.0)
	end
end

function post_initialize()
	local dev = GetSelf()
	    
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
		throttle = 1.0
		above_idle = true
		THROTTLE_IDLE_DRAW:set(0.0)
    elseif birth=="GROUND_COLD" then
		throttle = 0.0
		above_idle = false
		THROTTLE_IDLE_DRAW:set(1.0)
    end
	update_throttle()
end

function SetCommand(command,value)   
	
	if command == Keys.throttleAxis then 
		if above_idle then 
			throttle = throttle_idle+(value+1.0)*0.5*(1.0-throttle_idle)
		end

		update_throttle()
	end

	if command == Keys.StarterButton then
		dispatch_action(nil, EFM_commands.starterButton,1.0)
	end
	if command == Keys.StarterButtonRelease then
		dispatch_action(nil, EFM_commands.starterButton,0.0)
	end
	
	if command==Keys.GovTrimUp then
		govtrim = govtrim + 0.0002
		if govtrim > 0.03 then
			govtrim = 0.03
		end
		dispatch_action(nil,EFM_commands.govtrim,govtrim)
	end
	
	if command==Keys.GovTrimDown then
		govtrim = govtrim - 0.0002
		if govtrim < -0.02 then
			govtrim = -0.02
		end
		dispatch_action(nil,EFM_commands.govtrim,govtrim)
	end
	
	if command==Keys.ThrottleIdle then
		if throttle < throttle_idle then 
			above_idle = true
		end
		update_throttle()
	end
	
	if command==Keys.ThrottleCutoff then
		if throttle <= throttle_idle + 0.004 then 
			above_idle = false
		end
		update_throttle()
	end
	
	if command==Keys.ThrottleIncrease then
		if throttle >= throttle_idle then 
			throttle = throttle + 0.004
			if throttle > 1.0 then
				throttle = 1.0
			end
			update_throttle()
		end
	elseif command==Keys.ThrottleDecrease then
		if throttle >= throttle_idle then 
			throttle = throttle - 0.004
			if throttle < throttle_idle then
				throttle = throttle_idle
			end
			update_throttle()
		end
	end
	
end

function update()

	dc_ok = dc_elec:get() > 0.5
	if above_idle then
		if throttle<throttle_idle then
			throttle = throttle + 0.01
			if throttle>throttle_idle then
				throttle = throttle_idle
			end
		end
	else
		if throttle > 0.0 then
			throttle = throttle - 0.01
			if throttle < 0.0 then
				throttle = 0.0
			end
		end
	end
	update_throttle()
	
end

need_to_be_closed = false 