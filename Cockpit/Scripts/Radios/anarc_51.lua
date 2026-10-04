dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")
dofile(LockOn_Options.script_path.."math_tools.lua")

dofile(LockOn_Options.script_path.. "..\\..\\default_radio_presets.lua")

package.cpath 	= package.cpath..";".. LockOn_Options.script_path.. "..\\..\\bin\\?.dll"
require('cefmRadio')

local COM1 = nil
local INTERCOM = nil
local ELECTRIC_SYSTEM = nil

local dev = GetSelf()

local ten_mega_cycles = 26
local mega_cycles = 2
local deci_mega_cycles = 0

local preset_channel = 1
local mode = "MANUAL"-- "PRESET"
local frequency
local manual_frequency = 262.0
local volume =0.5
local power_position =false

local dc_ok = false

dev:listen_command(device_commands.anarc51_selector1)
dev:listen_command(device_commands.anarc51_selector2)
dev:listen_command(device_commands.anarc51_switch)
dev:listen_command(device_commands.anarc51_channel)
dev:listen_command(device_commands.anarc51_tune1)
dev:listen_command(device_commands.anarc51_tune2)
dev:listen_command(device_commands.anarc51_tune3)
dev:listen_command(device_commands.anarc51_volume)

dev:listen_command(Keys.anarc_51_inc_channel)
dev:listen_command(Keys.anarc_51_dec_channel)
dev:listen_command(Keys.anarc_51_inc_tune1)
dev:listen_command(Keys.anarc_51_dec_tune1)
dev:listen_command(Keys.anarc_51_inc_tune2)
dev:listen_command(Keys.anarc_51_dec_tune2)
dev:listen_command(Keys.anarc_51_inc_tune3)
dev:listen_command(Keys.anarc_51_dec_tune3)
dev:listen_command(Keys.anarc_51_inc_vol)
dev:listen_command(Keys.anarc_51_dec_vol)
dev:listen_command(Keys.anarc_51_preset)
dev:listen_command(Keys.anarc_51_manual)   
dev:listen_command(Keys.anarc_51_mode_up)  
dev:listen_command(Keys.anarc_51_mode_down)

local dc_elec = get_param_handle("DC_POWER_AVAIL")

local radio_presets
local update_time_step = 0.01
make_default_activity(update_time_step)



function GetRadioChannels()
    if get_aircraft_mission_data == nil then
        return get_default_radio_presets()
    end
      local radio = get_aircraft_mission_data("Radio")
      if radio == nil then
        return get_default_radio_presets()
    end
      if radio[1] == nil then
        return get_default_radio_presets()
    end
    if radio[1].channels then
        return radio[1].channels
    end
    return get_default_radio_presets()
 end

function post_initialize()
    --radio_presets = get_aircraft_mission_data("Radio")[1].channels
    radio_presets = GetRadioChannels()
    

    COM1 = GetDevice(devices.COM1)
    INTERCOM = GetDevice(devices.INTERCOM)
    ELECTRIC_SYSTEM = GetDevice(devices.ELECTRIC_SYSTEM)
    

    if cefmRadio.SetElectricSystem(GetDevice(devices.ELECTRIC_SYSTEM)) then
		--print_message_to_user("Radio - Set Electric System: Succesful")
	
		if cefmRadio.SetIntercom(INTERCOM) then
			--print_message_to_user("Radio - Set Intercom: Succesful")
	
			if cefmRadio.AddRadio(GetDevice(devices.COM1)) then
				--print_message_to_user("Radio - Set Radio: Succesful")
	
				if cefmRadio.Setup() == true then
					cefmRadio.SetCrewComm(true)
					cefmRadio.SetBareVoice(true)
                    cefmRadio.SetEnableTransmission(0,true)
                    --cefmRadio.SetPower(0, true)

					--print_message_to_user("Radio - Setup: Succesful")
				else
					--print_message_to_user("Radio - Setup: Failed")
				end	
			else
				--print_message_to_user("Radio - Set Radio: Failed")
			end
		else
			--print_message_to_user("Radio - Set Intercom: Failed")
		end
	else
		--print_message_to_user("Radio - Set Electric System: Failed")
	end
    INTERCOM:set_communicator(devices.COM1)
    INTERCOM:make_setup_for_communicator()

    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
        dev:performClickableAction(device_commands.anarc51_selector1,0.6666,true)
    elseif birth=="GROUND_COLD" then
        dev:performClickableAction(device_commands.anarc51_selector1,0.0,true)
    end
    dev:performClickableAction(device_commands.anarc51_selector2, 0.0,true)
    dev:performClickableAction(device_commands.anarc51_tune1,0.16666,true)
    dev:performClickableAction(device_commands.anarc51_tune2,0.1,true)
    dev:performClickableAction(device_commands.anarc51_tune3,0.0,true)
end


function SetCommand(command,value)
    local update_frequency = false
    if command == device_commands.anarc51_tune1 then
        ten_mega_cycles =  round(22.0+value*18.0,0)
        update_frequency = true
    end
    if command == Keys.anarc_51_inc_tune1 then 
        local val = (ten_mega_cycles -22.0)/18.0
        val= val + 1.0/18.0
        if val > 1.0 then val =1.0 end
        dev:performClickableAction(device_commands.anarc51_tune1,val,true)
    end
    if command == Keys.anarc_51_dec_tune1 then 
        local val = (ten_mega_cycles -22.0)/18.0
        val= val - 1.0/18.0
        if val < 0.0 then val =0.0 end
        dev:performClickableAction(device_commands.anarc51_tune1,val,true)
    end


    if command == device_commands.anarc51_tune2 then
        mega_cycles = round(value*10.0,0)
        update_frequency = true
    end
    if command == Keys.anarc_51_inc_tune2 then 
        local val = mega_cycles/10.0
        val= val + 1.0/10.0
        if val > 1.0 then val =1.0 end
        dev:performClickableAction(device_commands.anarc51_tune2,val,true)
    end
    if command == Keys.anarc_51_dec_tune2 then 
        local val = mega_cycles/10.0
        val= val - 1.0/10.0
        if val < 0.0 then val =0.0 end
        dev:performClickableAction(device_commands.anarc51_tune2,val,true)
    end


    if command == device_commands.anarc51_tune3 then
        deci_mega_cycles = round(value*20.0,0)/20
        update_frequency = true
    end
    if command == Keys.anarc_51_inc_tune3 then 
        local val = deci_mega_cycles
        val= val + 1.0/20.0
        if val > 1.0 then val =1.0 end
        dev:performClickableAction(device_commands.anarc51_tune3,val,true)
    end
    if command == Keys.anarc_51_dec_tune3 then 
        local val = deci_mega_cycles
        val= val - 1.0/20.0
        if val < 0.0 then val =0.0 end
        dev:performClickableAction(device_commands.anarc51_tune3,val,true)
    end


    if command == device_commands.anarc51_volume then
        cefmRadio.SetVolume(0, value)
        volume = value
    end
    if command == Keys.anarc_51_inc_vol then 
        volume = volume + 0.005
        if volume > 1.0 then volume =1.0 end
        dev:performClickableAction(device_commands.anarc51_volume,volume,true)
    end
    if command == Keys.anarc_51_dec_vol then 
        volume = volume - 0.005
        if volume < 0.0 then volume =0.0 end
        dev:performClickableAction(device_commands.anarc51_volume,volume,true)
    end
  
    if command == device_commands.anarc51_selector1 then
        
        if value >0.2 and value <0.7 then
            power_position = true
        else
            power_position = false
        end
        
        if dc_ok and power_position then 
            cefmRadio.SetPower(0,true)
        else
            cefmRadio.SetPower(0,false)
        end
    end
    if command == Keys.anarc_51_mode_up then 
        power_position = power_position + 1.0/3.0
        if power_position>1.0 then power_position =1.0 end
        dev:performClickableAction(device_commands.anarc51_selector1,power_position,true)
    end
    if command == Keys.anarc_51_mode_down then 
        power_position = power_position - 1.0/3.0
        if power_position<0.0 then power_position =0.0 end
        dev:performClickableAction(device_commands.anarc51_selector1,power_position,true)
    end
    

    if command == device_commands.anarc51_selector2 then
        if value>0.5 then 
            mode = "PRESET"
        else
            mode = "MANUAL"
        end
        update_frequency = true
    end
    if command == Keys.anarc_51_preset then 
        dev:performClickableAction(device_commands.anarc51_selector2,1.0,true)
    end
    if command == Keys.anarc_51_manual then 
        dev:performClickableAction(device_commands.anarc51_selector2,0.0,true)
    end

    if command == device_commands.anarc51_channel then
        local channel = round(value*19.0,0)
        preset_channel = channel+1
        update_frequency = true
    end
    if command == Keys.anarc_51_inc_channel then
        preset_channel = preset_channel+1
        if preset_channel>19 then preset_channel=19 end
        dev:performClickableAction(device_commands.anarc51_channel,preset_channel/19.0,true)
    end
    if command == Keys.anarc_51_dec_channel then
        preset_channel = preset_channel-1
        if preset_channel<0 then preset_channel=0 end
        dev:performClickableAction(device_commands.anarc51_channel,preset_channel/19.0,true)
    end

    if update_frequency then 
        if mode == "MANUAL" then 
            manual_frequency =10*ten_mega_cycles +mega_cycles+deci_mega_cycles
            frequency = manual_frequency
        else
            frequency = radio_presets[preset_channel]
        end
        --print_message_to_user(frequency)
        COM1:set_frequency(frequency*1E6)
    end
end


function update()
    local actual_power =dc_elec:get() > 0.5
    if dc_ok ~= actual_power then 
        dc_ok = actual_power
        if dc_ok and power_position then 
            cefmRadio.SetPower(0,true)
        else
            cefmRadio.SetPower(0,false)
        end
    end
end

need_to_be_closed = false 