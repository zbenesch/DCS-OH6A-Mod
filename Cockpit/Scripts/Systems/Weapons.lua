dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."../../../Database/wsTypes.lua")

local dev 	    = GetSelf()

local GUN_POSITION  = get_param_handle("GUNPOSITION")
local SHOW_SIGHT = get_param_handle("SHOW_SIGHT")


local GUN_NOT_CLEARED = get_param_handle("Warning_Gun_Not_Cleared")
local GUN_ARMED = get_param_handle("Warning_Armed")
local LOW_AMMO = get_param_handle("Warning_Low_Ammo")
local WEAPONS_CURRENT = get_param_handle("WEAPONS_CURRENT")

local GRENADES_TEXT = get_param_handle("GRENADES_TEXT")


local weapon_mode = "OFF"
local weapon_arm = false
local grenadeactive = false
local anim=0.0
local barrel_speed = 0.0
local barrel_rate = 4000.0/60.0/6
local gun_trigger = false
local WeaponSystem = GetSelf()
local update_rate = 0.01
local gun_position =0.0
local shots_fired=true
local weapon_select = "gun"
local jettison_cover = true

local flares_equipped = 0

local flares_armed = false
local flares_pressed = false
local flare_delay = 0.5
local flare_time = 1.0


local ammo = 0 

local dc_elec = get_param_handle("DC_POWER_AVAIL")

make_default_activity(update_rate)

local g_color = {
	[1]=get_param_handle("G1_color"),
	[2]=get_param_handle("G2_color"),
	[3]=get_param_handle("G3_color"),
	[4]=get_param_handle("G4_color")
}

local g_count = {
	[1]=get_param_handle("G1_count"),
	[2]=get_param_handle("G2_count"),
	[3]=get_param_handle("G3_count"),
	[4]=get_param_handle("G4_count"),
	[5]=get_param_handle("Frag_count"),
}

local shoot_doorgun = get_param_handle("SHOOT_DOOR_GUN")

local color_arg = {}
color_arg['{OH6_SMOKE_RED}'] = 0.0
color_arg['{OH6_SMOKE_BLUE}'] = 0.25
color_arg['{OH6_SMOKE_GREEN}'] = 0.5
color_arg['{OH6_SMOKE_YELLOW}'] = 0.75

WeaponSystem:listen_command(Keys.DropGrenade)
WeaponSystem:listen_command(Keys.SwitchGrenadeColor)
WeaponSystem:listen_command(Keys.FireOn)
WeaponSystem:listen_command(Keys.FireOff)
WeaponSystem:listen_command(Keys.GunUp)
WeaponSystem:listen_command(Keys.GunDown)

WeaponSystem:listen_command(device_commands.weapon_arm)
WeaponSystem:listen_command(Keys.Master_arm_on)
WeaponSystem:listen_command(Keys.Master_arm_off)
WeaponSystem:listen_command(Keys.Master_arm_toggle)
WeaponSystem:listen_command(device_commands.weapon_mode)
WeaponSystem:listen_command(Keys.weapon_mode_off)
WeaponSystem:listen_command(Keys.weapon_mode_toclear)
WeaponSystem:listen_command(Keys.weapon_mode_normal)
WeaponSystem:listen_command(Keys.weapon_mode_toggle)
WeaponSystem:listen_command(Keys.decrease_salvo_length)
WeaponSystem:listen_command(Keys.increase_salvo_length)

WeaponSystem:listen_command(Keys.jettison_cover)
WeaponSystem:listen_command(Keys.jettison)

WeaponSystem:listen_command(device_commands.weapon_select)
WeaponSystem:listen_command(Keys.weapon_select_gun)
WeaponSystem:listen_command(Keys.weapon_select_rockets)
WeaponSystem:listen_command(Keys.weapon_rocketpairs)
WeaponSystem:listen_command(device_commands.weapon_jettison)
WeaponSystem:listen_command(device_commands.weapon_jettison_cover)

WeaponSystem:listen_command(Keys.DropFlare)
WeaponSystem:listen_command(Keys.FlareArmSafe)
WeaponSystem:listen_command(Keys.FlareArm)
WeaponSystem:listen_command(Keys.FlareSafe)

WeaponSystem:listen_command(device_commands.DropFlare)
WeaponSystem:listen_command(device_commands.FlareArmSafe)



local grenade_pylon = 0
local color_id = 1
local sounds ={}
local dc_ok
local current = 0.0


function play_sound(name)
	for k,v in pairs(sounds) do 
		if k == name then
			sounds[k]:play_once()
		else
			sounds[k]:stop()
		end	
	end
end


function launch_grenade(pylon)
	WeaponSystem:launch_station(grenade_pylon)
	anim=0.0
	grenadeactive = true
end


function update_grenades()
	for i = 1, 4 do
		info = WeaponSystem:get_station_info(i-1)
		n = info.count
		g_count[i]:set((4-n)/5.0)
		value = color_arg[info.CLSID]
		if value == nil then
			value = 0.0
		end
		g_color[i]:set(value)
	end
	
	info = WeaponSystem:get_station_info(4)
	
	if info.CLSID ~= "" then
		n = info.count
		g_count[5]:set((10-n)/11.0)
	else
		g_count[5]:set(1.0)
	end
end

function update_gun()
	local gunInfo = WeaponSystem:get_station_info(10)
	if gunInfo.weapon.level2 == wsType_Shell then
		if shoot_doorgun:get() ==1 then 
			WeaponSystem:launch_station(10)
		end
	end
	
	local gunInfo = WeaponSystem:get_station_info(7)
	if gun_trigger == true then
		if weapon_mode ~= "OFF" and weapon_arm and weapon_select == "gun" and dc_ok then
			barrel_speed = barrel_speed + 0.025
			current = current + 1
			if barrel_speed >= 1.0 then
				barrel_speed = 1.0
				if gunInfo.weapon.level2 == wsType_Shell then -- prevent shooting rockets if those are mounted
					if weapon_mode == "FIRE_TO_CLEAR" then
						if shots_fired == false then
							--WeaponSystem:launch_station(7)
							shots_fired = true
						end
					else
						WeaponSystem:launch_station(7)
					end
				end
			end
		end
	else
		barrel_speed = barrel_speed - 0.01
		if barrel_speed < 0.0 then
			barrel_speed = 0.0
		end
	end

	if gunInfo.weapon.level2 == wsType_Shell then
		anim = anim + barrel_speed * barrel_rate * 0.01
		if anim > 1 then
			anim = anim - 1
		end
		set_aircraft_draw_argument_value(112,anim)
	end

	set_aircraft_draw_argument_value(450,gun_position)
end

function update_sight()

	local show_sight = 0.0
	local gun_sight = 0.0
	local show_fixed_cross = 0.0
	local gunInfo = WeaponSystem:get_station_info(7)
	if gunInfo.weapon.level2 == wsType_Shell then
		show_sight=1.0
		gun_sight = 1.0
	end

	local pInfo1 = WeaponSystem:get_station_info(8)
	if pInfo1.weapon.level2 == wsType_NURS then
		show_sight=1.0
		gun_sight = 1.0
	end

	local pInfo2 = WeaponSystem:get_station_info(9)
	if pInfo2.weapon.level2 == wsType_NURS then
		show_sight=1.0
		gun_sight = 1.0
	end
	SHOW_SIGHT:set(show_sight)
end


local interval = 0.15
local timer = interval
local salve = 0
local rockets_left = salve

function update_rockets()
	local pInfo1 = WeaponSystem:get_station_info(8)
	local pInfo2 = WeaponSystem:get_station_info(9)
	
	timer = timer - update_rate
	if timer < -1.0 then timer =-1.0 end
	
	if weapon_select =="rockets" and weapon_arm == true and dc_ok then
		local shoot = false
		if timer < 0  then
			if gun_trigger == true and rockets_left > 0 then
				timer = interval
				shoot = true
				rockets_left = rockets_left - 1
			
			else
				gun_trigger = false
				rockets_left = salve
			end
		end
		if pInfo1.weapon.level2 == wsType_NURS then
			if shoot == true then
				WeaponSystem:launch_station(8)
			end
		end

		if pInfo2.weapon.level2 == wsType_NURS then
			if shoot == true then
				WeaponSystem:launch_station(9)
			end
		end
	end
end


local function update_flares()
	flares_equipped = get_aircraft_property("FlaresEquipped")
	if flares_equipped >0.5 then 
		get_param_handle("FLARES_EQUIPPED"):set(1.0)
		local n_f =WeaponSystem:get_flare_count()
		local n_c = WeaponSystem:get_chaff_count()
		local n = n_f
		if n_c > n_f then n = n_c end
		local arg_val = 1.0-(30-n)/30.0*0.9
		set_aircraft_draw_argument_value(127, arg_val)

		if flares_armed then 
			if flares_pressed then
				if flare_time >= flare_delay then
					if dc_ok then
						if n_f >0 then 
							dev:drop_flare(1, 0)
						end
						if n_c >0 then 
							dev:drop_chaff(1, 0)
						end
						flare_time = 0.0
					end
				else
					flare_time = flare_time+update_rate
				end
			else
				flare_time =1.0
			end
		else
			flare_time =1.0
		end
	else
		get_param_handle("FLARES_EQUIPPED"):set(0.0)
		set_aircraft_draw_argument_value(127, 0.0)
	end
end

local function getCLSIDfromColor(color)

	local colors = {}
	colors['BLUE']='{OH6_SMOKE_BLUE}'
	colors['GREEN']='{OH6_SMOKE_GREEN}'
	colors['RED']='{OH6_SMOKE_RED}'
	colors['YELLOW']='{OH6_SMOKE_YELLOW}'
	colors['HE']='{OH6_FRAG}'

	return colors[color]
end

function getColorfromID(id)
	local colors = {}
	colors[1] = 'BLUE'
	colors[2] = 'GREEN'
	colors[3] = 'RED'
	colors[4] = 'YELLOW'
	colors[5] = 'HE'
	return colors[id]
end

function getNGrenades()
	local n = 0
	for i = 1, 5 do
		n=n + WeaponSystem:get_station_info(i-1).count
	end
	return n
end

local function getNumberOfGrenades(color)
	CLSID = getCLSIDfromColor(color)
	local n=0
	for i = 1, 5 do
		local info = WeaponSystem:get_station_info(i-1)
		if info.CLSID == CLSID then 
			n=n + info.count
		end
	end
	return n
end

local function getPylonIdFromColorID(id)
	local color = getColorfromID(id)
	if getNumberOfGrenades(color)>0 then
		local CLSID = getCLSIDfromColor(color)
		for i = 1, 5 do
			local info = WeaponSystem:get_station_info(i-1)
			if info.CLSID == CLSID then
				if info.count >0 then
					return i-1
				end
			end
		end
	else
		return -1
	end
end

local function initGrenadeColor()
	if getNGrenades() >0 then
		for i =1,5 do
			if getNumberOfGrenades(getColorfromID(i))>0 then
				color_id = i
				break
			end
		end
		grenade_pylon = getPylonIdFromColorID(color_id)
		local color_str = getColorfromID(color_id)
		GRENADES_TEXT:set(color_str)
	else
		GRENADES_TEXT:set('-')
	end

end

local function switchGrenadeColor()
	print("Switch")
	if getNGrenades() >0 then
		for i =1,4 do
			local i_t = i + color_id
			if i_t > 5 then	i_t =i_t-5 end
			print(i_t)
			print(getColorfromID(i_t))
			local n = getNumberOfGrenades(getColorfromID(i_t))
			if n>0 then
				color_id = i_t
				break
			end
		end
		grenade_pylon = getPylonIdFromColorID(color_id)
		local color_str = getColorfromID(color_id)
		GRENADES_TEXT:set(color_str)
		play_sound("prep_"..color_str)
	else
		GRENADES_TEXT:set('-')
	end
	print("Ende")
end

function post_initialize()

	

	sndhost = create_sound_host("COCKPIT_ARMS","HEADPHONES",-1.0,1.0,0)

	sounds["prep_RED"] = sndhost:create_sound("Cockpit/prep_red")
	sounds["prep_BLUE"] = sndhost:create_sound("Cockpit/prep_blue")
	sounds["prep_GREEN"] = sndhost:create_sound("Cockpit/prep_green")
	sounds["prep_YELLOW"] = sndhost:create_sound("Cockpit/prep_yellow")
	sounds["prep_HE"] = sndhost:create_sound("Cockpit/prep_he")
	sounds["dropped_RED"] = sndhost:create_sound("Cockpit/dropped_red")
	sounds["dropped_BLUE"] = sndhost:create_sound("Cockpit/dropped_blue")
	sounds["dropped_GREEN"] = sndhost:create_sound("Cockpit/dropped_green")
	sounds["dropped_YELLOW"] = sndhost:create_sound("Cockpit/dropped_yellow")
	sounds["dropped_HE"] = sndhost:create_sound("Cockpit/dropped_he")

	weapon_arm = false

	dev:performClickableAction(device_commands.weapon_arm,0.0,true)
	dev:performClickableAction(device_commands.weapon_mode,0.0,true)
	dev:performClickableAction(device_commands.weapon_select,-1.0,true)
	
	local gunInfo = WeaponSystem:get_station_info(10)
	if gunInfo.weapon.level2 == wsType_Shell then
		ammo = 2000		
	end
	--play_sound("prep_red")
	initGrenadeColor()

end


function update()

	current = 0
	dc_ok = dc_elec:get() > 0.5
	update_grenades()
	update_gun()
	update_sight()
	update_rockets()
	update_flares()

	local gunnerInfo = WeaponSystem:get_station_info(10)
	if gunnerInfo.weapon.level2 == wsType_Shell then
		if gunnerInfo.CLSID == "{OH-6 M134 Door}" then 
			set_aircraft_draw_argument_value(113,1.0)
		end
		if gunnerInfo.CLSID == "{OH-6 M60 Door}" then
			set_aircraft_draw_argument_value(113,0.5)
		end
	end
	
	
	if weapon_arm ==true and dc_ok then
		GUN_ARMED:set(1.0)
	else
		GUN_ARMED:set(0.0)
	end

	if shots_fired == true or not dc_ok then
		GUN_NOT_CLEARED:set(0.0)
	else
		GUN_NOT_CLEARED:set(1.0)
	end
	WEAPONS_CURRENT:set(current)

	if getNGrenades() >0 then
		if getNumberOfGrenades(getColorfromID(color_id))==0 then 
			switchGrenadeColor()
		end
		local color_str = getColorfromID(color_id)
		GRENADES_TEXT:set(color_str)
	else
		GRENADES_TEXT:set('-')
	end

end

function SetCommand(command,value)
	if flares_equipped >0.5 then 
		if command == Keys.DropFlare or command == device_commands.DropFlare then 
			if value>0.5 then flares_pressed = true else flares_pressed = false end
		end
		
		if command == Keys.FlareArm then
			dev:performClickableAction(device_commands.FlareArmSafe,1.0,true)
		end
		if command == Keys.FlareSafe then
			dev:performClickableAction(device_commands.FlareArmSafe,0.0,true)
		end
		if command == Keys.FlareArmSafe then
			if flares_armed then 
				dev:performClickableAction(device_commands.FlareArmSafe,0.0,true)
			else
				dev:performClickableAction(device_commands.FlareArmSafe,1.0,true)
			end
		end

		if command == device_commands.FlareArmSafe then
			flares_armed = value >0.5
		end
	end

    if command == Keys.DropGrenade then
		if getNGrenades() >0 then 
			WeaponSystem:launch_station(grenade_pylon)
			local color_str=getColorfromID(color_id)
			play_sound("dropped_"..color_str)
		end
		--print_message_to_user(grenade_pylon)
		local info = WeaponSystem:get_station_info(grenade_pylon)
		if info.count == 0 then
			if getNumberOfGrenades(getColorfromID(color_id))>0 then 
				grenade_pylon = getPylonIdFromColorID(color_id)
			else
				switchGrenadeColor()
			end
		end
	end

	if command == Keys.SwitchGrenadeColor then
		switchGrenadeColor()
	end
	if command == Keys.FireOn then
		gun_trigger = true
	end
	if command == Keys.FireOff then
		gun_trigger = false
	end

	if command == Keys.GunUp then
		gun_position = gun_position+0.001
		if gun_position > 10.0/90.0 then 
			gun_position = 10.0/90.0
		end
	end
	if command == Keys.GunDown then
		gun_position = gun_position-0.001
		if gun_position < -24.0/90.0 then 
			gun_position = -24.0/90.0
		end
	end

	if command == device_commands.weapon_arm then
		
		if value < 0.5 then
			--print_message_to_user("Save")
			weapon_arm = false
		else
			--print_message_to_user("Arm")
			weapon_arm = true
		end
	end

	if command == Keys.Master_arm_on then
		dev:performClickableAction(device_commands.weapon_arm,1.0,true)
	end
	if command == Keys.Master_arm_off then
		dev:performClickableAction(device_commands.weapon_arm,0.0,true)
	end
	if command == Keys.Master_arm_toggle then
		if weapon_arm then 
			dev:performClickableAction(device_commands.weapon_arm,0.0,true)
		else
			dev:performClickableAction(device_commands.weapon_arm,1.0,true)
		end

	end

	if command == device_commands.weapon_mode then
		--print_message_to_user(value)
		if value < 0.4 then
			weapon_mode = "OFF"
		elseif value >0.6 then
			weapon_mode = "FIRE"
			shots_fired = false
		else
			weapon_mode = "FIRE_TO_CLEAR"
			--shots_fired = false
		end
	end

	if command == Keys.weapon_mode_off then
		dev:performClickableAction(device_commands.weapon_mode,0.0,true)
	end
	if command == Keys.weapon_mode_toclear then
		dev:performClickableAction(device_commands.weapon_mode,0.5,true)
	end
	if command == Keys.weapon_mode_normal then
		print_message_to_user("normal")
		dev:performClickableAction(device_commands.weapon_mode,1.0,true)
	end
	if command == Keys.weapon_mode_toggle then
		print_message_to_user("toggle")
		if weapon_mode == "OFF" then 
			dev:performClickableAction(device_commands.weapon_mode,0.5,true)
		elseif weapon_mode == "FIRE_TO_CLEAR" then 
			dev:performClickableAction(device_commands.weapon_mode,1.0,true)
		else
			dev:performClickableAction(device_commands.weapon_mode,0.0,true)
		end
	end

	if command == device_commands.weapon_select then
		if value < -0.0 then
			weapon_select = "gun"
			--print_message_to_user("gun")
		else 
			weapon_select = "rockets"
			--print_message_to_user("rockets")
		end
	end

	if command == Keys.weapon_select_gun then
		dev:performClickableAction(device_commands.weapon_select,-1.0,true)
	end
	if command == Keys.weapon_select_rockets then
		dev:performClickableAction(device_commands.weapon_select,1.0,true)
	end


	if command == device_commands.weapon_rocketpairs then
		salve =math.floor(value*7+0.1)
		rockets_left = salve
	end

	if command == Keys.increase_salvo_length then 
		salve = salve +1
		if salve>7 then salve = 7 end
		dev:performClickableAction(device_commands.weapon_rocketpairs,salve/7.0,true)
	end

	if command == Keys.decrease_salvo_length then 
		salve = salve -1
		if salve<0 then salve = 0 end
		dev:performClickableAction(device_commands.weapon_rocketpairs,salve/7.0,true)
	end


	if command == device_commands.weapon_jettison then
		if not jettison_cover then
			if value>0.5 then 
				WeaponSystem:emergency_jettison(8)
				WeaponSystem:emergency_jettison(9)
			end
		end
	end

	if command == device_commands.weapon_jettison_cover then
		if value>0.5 then 
			jettison_cover = false
		else
			jettison_cover = true
		end
	end

	if command == Keys.jettison_cover then 
		if jettison_cover then 
			dev:performClickableAction(device_commands.weapon_jettison_cover,1.0,true)
		else
			dev:performClickableAction(device_commands.weapon_jettison_cover,0.0,true)
		end
	end

	if command == Keys.jettison then
		dev:performClickableAction(device_commands.weapon_jettison,1.0,true)
	end
	


end



need_to_be_closed = false -- close lua state after initialization
