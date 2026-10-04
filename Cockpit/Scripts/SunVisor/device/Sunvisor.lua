dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()

local update_time_step = 0.02  
make_default_activity(update_time_step)

local handlePower = get_param_handle("SUNVISOR_PWR")

local animSunVisor = false
local sunVisorState = false
local sunLevel = 0

function post_initialize()

end

dev:listen_command(Keys.sunVisorToggle)

function SetCommand(command, value)   
    if command == Keys.sunVisorToggle then
		animSunVisor = true
		if sunVisorState then 
			sunVisorState = false
			sunLevel = 1
		else
			sunVisorState = true
			sunLevel = 0
		end
	end
end

function update()
	if animSunVisor then
		if sunVisorState and sunLevel < 1 then
			sunLevel = sunLevel + update_time_step
			if sunLevel >= 1 then
				sunLevel = 1
				animSunVisor = false
			end
			--set_aircraft_draw_argument_value(posPilot, sunLevel)
			if sunLevel >= 0.5 and handlePower:get() == 0 then
				handlePower:set(1)
				print_message_to_user("Sunvisor ON", keybindsTempo)
			end
		elseif not sunVisorState and sunLevel > 0 then
			sunLevel = sunLevel - update_time_step
			if sunLevel <= 0 then
				sunLevel = 0
				animSunVisor = false
			end
			--set_aircraft_draw_argument_value(posPilot, sunLevel)
			if sunLevel <= 0.5 and handlePower:get() == 1 then
				handlePower:set(0)	
				print_message_to_user("Sunvisor OFF", keybindsTempo)	
			end	
		end
	end
end

need_to_be_closed = false
