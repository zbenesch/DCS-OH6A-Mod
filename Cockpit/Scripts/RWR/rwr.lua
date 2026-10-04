
dofile(LockOn_Options.script_path.."devices.lua")

dofile(LockOn_Options.script_path.."command_defs.lua")

function round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

local symbols=dofile(LockOn_Options.script_path.."RWR/rwr_symbols.lua")

rwrPower = get_param_handle("RWR_POWER")
rwrBrightness = get_param_handle("RWR_BRIGHTNESS")
rwrLoudness = get_param_handle("RWR_LOUDNESS")
rwrVisible = get_param_handle("RWR_VISIBLE")


local dev 	    = GetSelf()
update_time_step = 0.025
make_default_activity(update_time_step) 

local rwr_equipped = false

dev:listen_command(device_commands.RWROnOffSwitch)
dev:listen_command(device_commands.RWRBrightness)
dev:listen_command(device_commands.RWRLoudness)

dev:listen_command(Keys.RWROnOffSwitch)
dev:listen_command(Keys.RWROn)
dev:listen_command(Keys.RWROff)
dev:listen_command(Keys.RWRBrightnessIncrease)
dev:listen_command(Keys.RWRBrightnessDecrease)
dev:listen_command(Keys.RWRLoudnessIncrease)
dev:listen_command(Keys.RWRLoudnessDecrease)

local ac_ok = get_param_handle("AC_POWER_AVAIL")

local volume =0.5
local volumeLock =0.5
local volumeWarn =0.5

local brightness = 0.5


local RWR_Power=0

local gettext = require("i_18n")
_ = gettext.translate





local electric_system=GetDevice(devices.ELECTRIC_SYSTEM)


MaxThreats          = 20
EmitterLiveTime     = 7.0
EmitterSoundTime    = 0.5
LaunchSoundDelay    = 15.0

DefaultType          = 100

RWR_detection_coeff = 0.85
DEFAULT_TYPE_ = {DefaultType, DefaultType, DefaultType, DefaultType}

eyes ={}	-- sensor locations
eyes[1] =
	{
		position      = {x = 2.57,y = -0.7,z =  0.8}, --{Forward/Back,U/D,L/R}
		orientation   = {azimuth  = math.rad(45),elevation = math.rad(0.0)},
		field_of_view = math.rad(120) 
	}
eyes[2] =
	{
		position      = {x = 2.57,y = -0.7,z = -0.8},
		orientation   = {azimuth  = math.rad(-45),elevation = math.rad(0.0)},
		field_of_view = math.rad(120) 
	}
eyes[3] =
	{
		position      = {x = -3,y = 0.5,z =  0.3},
		orientation   = {azimuth  = math.rad(135),elevation = math.rad(0.0)},
		field_of_view = math.rad(120) 
	}
eyes[4] =
	{
		position      = {x = -3,y = 0.5,z =  -0.3},
		orientation   = {azimuth  = math.rad(-135),elevation = math.rad(0.0)},
		field_of_view = math.rad(120) 
	}


rwr = 	{}
for ia = 1,20  do	
	if ia  < 10 then
		i = "_0".. ia .."_"
	else
		i = "_".. ia .."_"
	end
	rwr[ia] =
	{
		elevation_h 	= get_param_handle("RWR_CONTACT" .. i .. "ELEVATION"),
		azimuth_h 		= get_param_handle("RWR_CONTACT" .. i .. "AZIMUTH"),
		power_h 		= get_param_handle("RWR_CONTACT" .. i .. "POWER"),
		unit_type_h			= get_param_handle("RWR_CONTACT" .. i .. "UNIT_TYPE"),
	
		general_type_h		= get_param_handle("RWR_CONTACT" .. i .. "GENERAL_TYPE"),
		priority_h		= get_param_handle("RWR_CONTACT" .. i .. "PRIORITY"),
		signal_h		= get_param_handle("RWR_CONTACT" .. i .. "SIGNAL"),
		time_h		= get_param_handle("RWR_CONTACT" .. i .. "TIME"),
		source_h		= get_param_handle("RWR_CONTACT" .. i .. "SOURCE"),
		
		unit_type_sym_h= get_param_handle("RWR_CONTACT" .. i .. "UNIT_TYPE_SYM"),
		unit_type_sym_num= get_param_handle("RWR_CONTACT" .. i .. "UNIT_TYPE_SYM_NUMERIC"),
		
		unit_type_is_num= get_param_handle("RWR_CONTACT" .. i .. "UNIT_TYPE_IS_NUMERIC"),
		power_sym_h 	= get_param_handle("RWR_CONTACT" .. i .. "POWER_SYM"),
		lock_sym_h 	= get_param_handle("RWR_CONTACT" .. i .. "LOCK_SYM"),
	}
end


function updateVolume()
	volumeLock = math.pow((((round(volume/0.5,2))*0.3)),3)
	volumeWarn = math.pow((((round(volume/0.5,2))*0.4)),3)
end



function SetCommand(command,value)
	if rwr_equipped >0.5 then 
		if command == device_commands.RWROnOffSwitch then
			RWR_Power = value
		end

		
		if command == device_commands.RWRBrightness then
			brightness = value
			rwrBrightness:set(brightness)
		end
		
		if command == device_commands.RWRLoudness then
			volume = value
			updateVolume()
			rwrLock:update(nil,volumeLock,nil)
			rwrWarn:update(nil,volumeWarn,nil)
		end

		if command == Keys.RWROn then 
			dev:performClickableAction(device_commands.RWROnOffSwitch,1.0,true)
		end
		
		if command == Keys.RWROff then 
			dev:performClickableAction(device_commands.RWROnOffSwitch,0.0,true)
		end

		if command == Keys.RWROnOffSwitch then 
			if RWR_Power > 0.5 then 
				dev:performClickableAction(device_commands.RWROnOffSwitch,0.0,true)
			else
				dev:performClickableAction(device_commands.RWROnOffSwitch,1.0,true)
			end
		end
		
		if command == Keys.RWRLoudnessIncrease then 
			volume = volume+0.01
			if volume > 1.0 then volume = 1.0 end
			dev:performClickableAction(device_commands.RWRLoudness,volume,true)
			updateVolume()
		end

		if command == Keys.RWRLoudnessDecrease then 
			volume = volume-0.01
			if volume < 0.0 then volume = 0.0 end
			dev:performClickableAction(device_commands.RWRLoudness,volume,true)
			updateVolume()
		end

		if command == Keys.RWRBrightnessIncrease then 
			brightness = brightness + 0.01
			if brightness >1.0 then brightness = 1.0 end
			dev:performClickableAction(device_commands.RWRBrightness,brightness,true)
		end

		if command == Keys.RWRBrightnessDecrease then 
			brightness = brightness - 0.01
			if brightness < 0.0 then brightness = 0.0 end
			dev:performClickableAction(device_commands.RWRBrightness,brightness,true)
		end
	end

end

function post_initialize()
	rwr_equipped = get_aircraft_property("RWREquipped")
	soundhost = create_sound_host("COCKPIT_RADAR_WARN","HEADPHONES",0,0,0)

	rwrWarn 	= soundhost:create_sound("Cockpit/rwr_warn") 
	rwrLock 	= soundhost:create_sound("Cockpit/rwr_lock") 
	
	
	--update()
	
	local birth = LockOn_Options.init_conditions.birth_place

    if birth=="GROUND_HOT" or birth=="AIR_HOT" then 	
        dev:performClickableAction(device_commands.RWROnOffSwitch,1,true)
    elseif birth=="GROUND_COLD" then
		dev:performClickableAction(device_commands.RWROnOffSwitch,0,true)
    end

	dev:performClickableAction(device_commands.RWRBrightness, 0.5) -- Brightness at 50%
	dev:performClickableAction(device_commands.RWRLoudness, 0.5) -- Volume knobs at 50%
end


function update()
	
	if rwr_equipped >0.5 then 
		rwrVisible:set(1)
		set_aircraft_draw_argument_value(31, 1)

		local tmp_type,tmp_signal,tmp_gen_type
		local lock =false
		local warn = false
		for i = 1,20 do
		
			tmp_type 		= rwr[i].unit_type_h:get()
			
			--rwr[i].power_h:get(),rwr[i].signal_h:get()
			tmp_gen_type 	= rwr[i].general_type_h:get()
			if  tmp_type and tmp_type ~= "" then
				
				if tmp_type~=0 then
					--print_message_to_user("Unit:"..tmp_type..",power:"..rwr[i].power_h:get()..",signal:"..rwr[i].signal_h:get())	
					tmp_signal = rwr[i].signal_h:get()
					if tmp_signal == 2 then				-- 2 Lock
						lock=true
						rwr[i].lock_sym_h:set(0.5)
					elseif tmp_signal == 3 then			-- 3 Launch
						warn=true
						if rwr[i].lock_sym_h:get() == 1 then
							rwr[i].lock_sym_h:set(0.5)
							lock=true
						else
							rwr[i].lock_sym_h:set(0.5)
							lock=true
						end
					else								--else 1 - Search
						rwr[i].lock_sym_h:set(1.0)
					end
					
					
					symb=symbols[tmp_type]
					if symb==nil then
						--print_message_to_user("Unit:"..tmp_type)	
						symb="UU"
					end	
					--textfromparameter did not work from numeric text in string don't know why. Added an extra renderitem
					if tonumber(symb)~=nil then
						rwr[i].unit_type_sym_num:set(symb)
						rwr[i].unit_type_is_num:set(1.0)
					else
						rwr[i].unit_type_sym_h:set(symb)
						rwr[i].unit_type_is_num:set(0.5)
					end
					--tmp_gen_type: 1->plane, 2->SearchRadar,3->ship,0 ewr
					
				end
			end
			tmp = 1-rwr[i].power_h:get() + 0.1
			rwr[i].power_sym_h:set(tmp)
		end

		if ac_ok:get()==1 and RWR_Power ==1 then
			--print_message_to_user(volumeLock)
			if lock == false then
				if rwrLock:is_playing() then
					rwrLock:stop()
					rwrLock:update(nil,volumeLock,nil)
				end
			else
				
				if not rwrLock:is_playing() then
					
					rwrLock:play_continue()
					rwrLock:update(nil,volumeLock,nil)
				end
			end
				
			if warn == false then
				if rwrWarn:is_playing() then
					rwrWarn:stop()
				end
			else
				if not rwrWarn:is_playing() then
					rwrWarn:play_continue()
				end
			end
		else
			if rwrLock:is_playing() then
				--print_message_to_user("Stop")
				rwrLock:stop()
			end
			if rwrWarn:is_playing() then
					rwrWarn:stop()
			end
		end
			rwrLock:update(nil,volumeLock,nil)
			rwrWarn:update(nil,volumeWarn,nil)	
		
		if ac_ok:get()==1 and RWR_Power ==1 then
			rwrPower:set(1)
			dev:set_power(true)
		else
			rwrPower:set(0)
			dev:set_power(false)
		end	
	else
		rwrVisible:set(0)
		set_aircraft_draw_argument_value(31, 0)
	end
	
end

