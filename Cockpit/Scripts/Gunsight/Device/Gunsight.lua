dofile(LockOn_Options.script_path .."command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")

DEGREE_TO_MRAD = 17.4532925199433
dz={0.208024, 0.254598,0.301214, 0.347718, 0.393957, 0.423086, 0.452083, 0.480912, 0.50954}
x = {-1.0,-0.75,-0.5,-0.25,0.0,0.25,0.5,0.75,1.0}
function lin_interp_dz(x_val)
	index0 =1
	index1 =2
	while index1<=9 and x_val > x[index1] do
		index0 = index0 +1
		index1 = index1 +1
	end
	return dz[index0]-dz[5]+(dz[index1]-dz[index0])/(x[index1]-x[index0])*(x_val-x[index0])
end

local dc_ok = false

local use_aiming_mark = get_plugin_option_value("OH-6A", "OH6AimingMark", "local")
local aiming_mark_offset = get_plugin_option_value("OH-6A", "OH6AimingMarkOffset", "local")
local aiming_mark_keyoffset = 0.0

local SHOW_SIGHT = get_param_handle("SHOW_SIGHT")
local GUNSIGHT_VISIBLE = get_param_handle("Gunsight_visible")
local AIM_MARK_VISIBLE = get_param_handle("AIM_MARK_VISIBLE")

local AIM_OFFSET = get_param_handle("AIM_OFFSET")

local sight_offset = 0.0
local hud_stow = 0.0
local gunsight_brightness=1.0
dev = GetSelf()
local update_time_step = 0.02
make_default_activity(update_time_step)
local sensor_data = get_base_data()


local hud_power = get_param_handle("GUNSIGHT_POWER")
local hud_opacity = get_param_handle("GUNSIGHT_OPACITY")
local hud_depression = get_param_handle("GUN_DEPRESSION")
local hud_correction = get_param_handle("DEPRESSION_CORRECTION")
local Up_down_handle = get_param_handle("GunsightUpDown")

local dc_elec = get_param_handle("DC_POWER_AVAIL")

dev:listen_command(Keys.gunsight_up)
dev:listen_command(Keys.gunsight_down)
dev:listen_command(Keys.toggle_gunsight)
dev:listen_command(Keys.sight_brightness_inc)
dev:listen_command(Keys.sight_brightness_dec)

function post_initialize()
	dev:performClickableAction(device_commands.toggle_gunsight,1.0,true)
end


function SetCommand(command,value)
	if command == Keys.sight_brightness_inc then
		gunsight_brightness = gunsight_brightness + 0.005
		if gunsight_brightness > 1.0 then gunsight_brightness =1 end	
	end
	if command == Keys.sight_brightness_dec then
		gunsight_brightness = gunsight_brightness - 0.005
		if gunsight_brightness < 0.0 then gunsight_brightness =0.0 end	
	end

	if command == Keys.gunsight_up then
		sight_offset = sight_offset + 0.01--1.0/7.0
		if sight_offset > 1.0 then sight_offset = 1.0 end

		aiming_mark_keyoffset = aiming_mark_keyoffset+0.002
		if aiming_mark_keyoffset >0.5 then aiming_mark_keyoffset =0.5 end
	end

	if command == Keys.gunsight_down then
		sight_offset = sight_offset - 0.01-- 1.0/7.0
		if sight_offset < -1.0 then	sight_offset = -1.0	end

		aiming_mark_keyoffset = aiming_mark_keyoffset-0.002
		if aiming_mark_keyoffset <-0.5 then aiming_mark_keyoffset =-0.5 end
	end

	if command == device_commands.toggle_gunsight then
		if value<0.5 then
			hud_stow = 0.0
		else
			hud_stow = 1.0
		end
	end
	if command == Keys.toggle_gunsight then
		if hud_stow >0.5 then
			dev:performClickableAction(device_commands.toggle_gunsight,0.0,true)
		else
			dev:performClickableAction(device_commands.toggle_gunsight,1.0,true)
		end
	end
end

function update()
	dc_ok = dc_elec:get() > 0.5
	hud_opacity:set(gunsight_brightness)
	Up_down_handle:set(sight_offset)
	
	if SHOW_SIGHT:get() >0.5 then

		if use_aiming_mark then
			GUNSIGHT_VISIBLE:set(0.0)
			AIM_MARK_VISIBLE:set(1.0)
			
			
			local val =aiming_mark_offset/200.0+aiming_mark_keyoffset
			if val > 0.5 then val =0.5 end
			if val < -0.5 then val =-0.5 end
			AIM_OFFSET:set(val)
		else
			GUNSIGHT_VISIBLE:set(1.0)
			AIM_MARK_VISIBLE:set(0.0)
			if hud_stow < 0.01 then 
				if dc_ok then 
					hud_power:set(1.0)
				else
					hud_power:set(0.0)
				end
			else
				hud_power:set(0.0)
			end
		end
		gunposition = get_aircraft_draw_argument_value(450)*90
		--print_message_to_user(gunposition)
		hud_depression:set(gunposition*DEGREE_TO_MRAD)
		offset = lin_interp_dz(sight_offset)
		hud_correction:set(-offset*1320) -- determined by playing arround. offset is z_offset in blender
		--print_message_to_user(sight_offset)
		--print_message_to_user(offset)
		--print_message_to_user("Done")
	else
		GUNSIGHT_VISIBLE:set(0.0)
		AIM_MARK_VISIBLE:set(0.0)
		hud_power:set(0.0)
	end
end	

need_to_be_closed = false
