dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."math_tools.lua")
dofile(LockOn_Options.common_script_path..'Radio.lua')
--dofile(LockOn_Options.script_path.."utils.lua")

package.cpath 	= package.cpath..";".. LockOn_Options.script_path.. "..\\..\\bin\\?.dll"
require('cefmRadio')
local pos2=0
local dev = GetSelf()

local update_time_step = 0.02 --update will be called once per second
local INTERCOM = nil
make_default_activity(update_time_step)

dev:listen_command(device_commands.intercom_knob2select)
dev:listen_command(Keys.ptt)
dev:listen_command(Keys.ptt_voice)

dev:listen_command(Keys.inc_intercom_select)
dev:listen_command(Keys.dec_intercom_select)

local PPT_PILOT = get_param_handle("PPT_PILOT")
local PPT_COPILOT = get_param_handle("PPT_COPILOT")

function post_initialize()
	INTERCOM = GetDevice(devices.INTERCOM)
	dev:performClickableAction(device_commands.intercom_switch11,1,true)
	dev:performClickableAction(device_commands.intercom_switch12,1,true)
	dev:performClickableAction(device_commands.intercom_switch13,1,true)
	dev:performClickableAction(device_commands.intercom_switch14,1,true)
	dev:performClickableAction(device_commands.intercom_switch1Int,1,true)
	dev:performClickableAction(device_commands.intercom_switch1Nav,1,true)
	dev:performClickableAction(device_commands.intercom_knob1vol,0,true)
	dev:performClickableAction(device_commands.intercom_knob1select,0.501,true)

	dev:performClickableAction(device_commands.intercom_switch21,1,true)
	dev:performClickableAction(device_commands.intercom_switch22,1,true)
	dev:performClickableAction(device_commands.intercom_switch23,1,true)
	dev:performClickableAction(device_commands.intercom_switch24,1,true)
	dev:performClickableAction(device_commands.intercom_switch2Int,1,true)
	dev:performClickableAction(device_commands.intercom_switch2Nav,1,true)
	dev:performClickableAction(device_commands.intercom_knob2vol,0,true)
	dev:performClickableAction(device_commands.intercom_knob2select,0.501,true)
end

function SetCommand(command,value)
	if command == device_commands.intercom_knob2select then 
		pos2 = round((value-0.165)/(1-0.165)*5,0)
		if pos2 == 2 then
			INTERCOM:set_communicator(devices.COM2)
			INTERCOM:make_setup_for_communicator()
			cefmRadio.SetCurrentCommunicator(1)
		elseif pos2 == 3 then
			INTERCOM:set_communicator(devices.COM1)
			INTERCOM:make_setup_for_communicator()
			cefmRadio.SetCurrentCommunicator(0)
		end
	end
	if command == Keys.inc_intercom_select then
		pos2 = pos2+1
		if pos2 > 5 then pos2 = 5 end
		local new_value = 0.165+pos2/5.0*(1-0.165)
		dev:performClickableAction(device_commands.intercom_knob2select,new_value,true)
	end
	if command == Keys.dec_intercom_select then
		pos2 = pos2-1
		if pos2 < 0 then pos2 = 0 end
		local new_value = 0.165+pos2/5.0*(1-0.165)
		dev:performClickableAction(device_commands.intercom_knob2select,new_value,true)
	end

	if command == Keys.ptt then 
		if value > 0.5 then 
			cefmRadio.PTT()
			PPT_PILOT:set(1.0)
			PPT_COPILOT:set(1.0)
		else
			PPT_PILOT:set(0.0)
			PPT_COPILOT:set(0.0)
		end
	end

	if command == Keys.ptt_voice then 
		if value > 0.5 then 
			cefmRadio.PTT_VOIP(true)
		else
			cefmRadio.PTT_VOIP(false)
		end
	end
end

function update()

end


need_to_be_closed = false -- close lua state after initialization

