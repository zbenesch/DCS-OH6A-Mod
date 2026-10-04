dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
--dofile(LockOn_Options.script_path.."utils.lua")

local dev = GetSelf()

local update_time_step = 0.02 --update will be called once per second



function post_initialize()
	
end

function SetCommand(command,value)
    --print_message_to_user(tostring(command).." : "..tostring(value))
end


need_to_be_closed = false -- close lua state after initialization

