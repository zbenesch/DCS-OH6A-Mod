dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")
dofile(LockOn_Options.script_path.."math_tools.lua")

package.cpath 	= package.cpath..";".. LockOn_Options.script_path.. "..\\..\\bin\\?.dll"
require('cefmRadio')

local COM2 = nil
local INTERCOM = nil
local ELECTRIC_SYSTEM = nil


local dev = GetSelf()

local update_time_step = 0.05  
local dc_ok = false
make_default_activity(update_time_step)

dev:listen_command(device_commands.anarc54_mode)
dev:listen_command(device_commands.anarc54_squelch)
dev:listen_command(device_commands.anarc54_volume)
dev:listen_command(device_commands.anarc54_tune1)
dev:listen_command(device_commands.anarc54_tune2)

dev:listen_command(Keys.anarc_54_mode_up)
dev:listen_command(Keys.anarc_54_mode_down)
dev:listen_command(Keys.anarc_54_inc_tune1)
dev:listen_command(Keys.anarc_54_dec_tune1)
dev:listen_command(Keys.anarc_54_inc_tune2)
dev:listen_command(Keys.anarc_54_dec_tune2)
dev:listen_command(Keys.anarc_54_inc_vol)
dev:listen_command(Keys.anarc_54_dec_vol)

local freq_Nxxx = get_param_handle("Anarc54Nxxx")
local freq_xNxx = get_param_handle("Anarc54xNxx")
local freq_xxNx = get_param_handle("Anarc54xxNx")
local freq_xxxN = get_param_handle("Anarc54xxxN")

local dc_elec = get_param_handle("DC_POWER_AVAIL")

local freq = 30.00
local mega_cycles = 30
local deci_mega_cycles = 00
local volume = 0.5
local power_position = false

function getDigit(num, digit)
    local n = 10 ^ digit
    local n1 = 10 ^ (digit - 1)
    return math.floor((num % n) / n1)
end

function update_frequency_display()
    local f_Nxxx = getDigit(mega_cycles,2)
    local f_xNxx = getDigit(mega_cycles,1)
    local f_xxNx = getDigit(deci_mega_cycles,2)
    local f_xxxN = getDigit(deci_mega_cycles,1)

    local norm = 9.1 --tuned due to bad uv shift animation
    freq_Nxxx:set(1/norm*f_Nxxx)
	freq_xNxx:set(1/norm*f_xNxx)
    freq_xxNx:set(1/norm*f_xxNx)
    freq_xxxN:set(1/norm*f_xxxN)
end

function update_frequency()
    freq = mega_cycles + deci_mega_cycles*0.01
    COM2:set_frequency(freq*1E6)
end



function post_initialize()
    COM2 = GetDevice(devices.COM2)
    INTERCOM = GetDevice(devices.INTERCOM)
    ELECTRIC_SYSTEM = GetDevice(devices.ELECTRIC_SYSTEM)
    
    if cefmRadio.SetElectricSystem(GetDevice(devices.ELECTRIC_SYSTEM)) then
		--print_message_to_user("FM Radio - Set Electric System: Succesful")
	
		if cefmRadio.SetIntercom(INTERCOM) then
			--print_message_to_user("FM Radio - Set Intercom: Succesful")
	
			if cefmRadio.AddRadio(GetDevice(devices.COM2)) then
				--print_message_to_user("FM Radio - Set Radio: Succesful")
	
				if cefmRadio.Setup() == true then
					cefmRadio.SetCrewComm(true)
					cefmRadio.SetBareVoice(true)
                    cefmRadio.SetEnableTransmission(1,true)
                    --cefmRadio.SetPower(1, true)

					--print_message_to_user("FM Radio - Setup: Succesful")
				else
					--print_message_to_user("FM Radio - Setup: Failed")
				end	
			else
				--print_message_to_user("FM Radio - Set Radio: Failed")
			end
		else
			--print_message_to_user("FM Radio - Set Intercom: Failed")
		end
	else
		--print_message_to_user("Radio - Set Electric System: Failed")
	end

    INTERCOM:set_communicator(devices.COM2)
    INTERCOM:make_setup_for_communicator()
    
    
    dev:performClickableAction(device_commands.anarc54_mode,-1.0,true)
	local dev = GetSelf()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 			  
        dev:performClickableAction(device_commands.anarc54_mode,0.3333,true)
        power_position = true
    elseif birth=="GROUND_COLD" then
		dev:performClickableAction(device_commands.anarc54_mode,0.0000,true)
    end
    update_frequency()
end


function SetCommand(command,value)

    if command == device_commands.anarc54_volume then
        cefmRadio.SetVolume(1, value)
        volume =value
    end
    if command == Keys.anarc_54_inc_vol then 
        volume = volume + 0.005
        if volume > 1.0 then volume = 1.0 end
        dev:performClickableAction(device_commands.anarc54_volume,volume,true)
    end
    if command == Keys.anarc_54_dec_vol then 
        volume = volume - 0.005
        if volume < 0.0 then volume = 0.0 end
        dev:performClickableAction(device_commands.anarc54_volume,volume,true)
    end

    local update_freq = false
    if command == device_commands.anarc54_tune1 then
        if value > 0 then 
            mega_cycles = mega_cycles +1
        else
            mega_cycles = mega_cycles -1
        end
        if mega_cycles > 69 then mega_cycles = 69 end
        if mega_cycles < 30 then mega_cycles = 30 end
        update_freq = true
    end
    if command == Keys.anarc_54_inc_tune1 then
        dev:performClickableAction(device_commands.anarc54_tune1,0.1,true)
    end
    if command == Keys.anarc_54_dec_tune1 then
        dev:performClickableAction(device_commands.anarc54_tune1,-0.1,true)
    end


    if command == device_commands.anarc54_tune2 then
        if value > 0 then 
            deci_mega_cycles = deci_mega_cycles +5
        else
            deci_mega_cycles = deci_mega_cycles -5
        end
        if deci_mega_cycles > 99 then deci_mega_cycles = 0 end
        if deci_mega_cycles < 0 then deci_mega_cycles = 95 end
        update_freq = true
    end
    if command == Keys.anarc_54_inc_tune2 then
        dev:performClickableAction(device_commands.anarc54_tune2,0.05,true)
    end
    if command == Keys.anarc_54_dec_tune2 then
        dev:performClickableAction(device_commands.anarc54_tune2,-0.05,true)
    end


    if command == device_commands.anarc54_mode then
        power_position = value
        if value <0.2 then 
            power_position = false
            cefmRadio.SetPower(1,false)
        elseif value <0.5 then 
            power_position = true
            cefmRadio.SetPower(1,true)
        end
    end
    if command == Keys.anarc_54_mode_up then 
        power_position = power_position +1.0/3.0
        if power_position >1.0 then power_position=1.0 end
        dev:performClickableAction(device_commands.anarc54_mode,power_position,true)
    end
    if command == Keys.anarc_54_mode_down then 
        power_position = power_position -1.0/3.0
        if power_position <0.0 then power_position=0.0 end
        dev:performClickableAction(device_commands.anarc54_mode,power_position,true)
    end


    if update_freq then
        update_frequency()
    end
end


function update()
    update_frequency_display()
    local actual_power =dc_elec:get() > 0.5
    if dc_ok ~= actual_power then 
        dc_ok = actual_power
        if dc_ok and power_position then 
            cefmRadio.SetPower(1,true)
        else
            cefmRadio.SetPower(1,false)
        end
    end
end

need_to_be_closed = false 