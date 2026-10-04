dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."math_tools.lua")

package.cpath 	= package.cpath..";".. LockOn_Options.script_path.. "..\\..\\bin\\?.dll"
require('XH6GunnerTools')
local dev = GetSelf()
local sensor_data = get_base_data()
local update_time_step = 0.02  

local targets={}
local old_targets={}
local actual_target
local position
local velocity
local muz_vel = 856.2
local bullet_drag = 0.00102
local gun_trigger = false
local is_aimed = false
local m60_equipped = false
local m134_equipped = false

local gunner_offset = {
			x = -0.0, -- -forward, + back
			y = 0,  -- - down, + up
			z = -1.0,  -- -right, + left
		},

make_default_activity(update_time_step)

local qx = get_param_handle("QUATERNIONX")
local qy = get_param_handle("QUATERNIONY")
local qz = get_param_handle("QUATERNIONZ")
local qw = get_param_handle("QUATERNIONW")
local shoot_doorgun = get_param_handle("SHOOT_DOOR_GUN")

local roe_text = get_param_handle("ROE_TEXT")
local burst_text = get_param_handle("BURST_TEXT")

local show_gui_handle = get_param_handle("SHOW_CREW_GUI")


local center_of_view_az = -90
local center_of_view_el = 0

local fov_az_min = -70
local fov_az_max = 70

local fov_el_min = -80
local fov_el_max = 80

local target_az = 0.0
local target_el = 0.0

local gun_az = 0.0
local gun_el = 0.0

local v_az = 0.0
local v_el = 0.0

local time_on_target = 0
local time_shooting = 0
local time_rest = 0
local burst_time =1.0
local rest_time =0.5
local max_dev = 2
local shooting = false

local t_data = 0.0

local burst_mode = 'SHORT'-- 'LONG'

roe_text:set("HOLD")
burst_text:set(burst_mode)

local N = 50
local roe =0
local show_gui = 0.0
if get_plugin_option_value("OH-6A", "OH6ShowCrewStatus", "local") then
	show_gui = 1.0
end
show_gui_handle:set(show_gui)
dev:listen_command(Keys.roe)
dev:listen_command(Keys.toggle_burst_length)
dev:listen_command(Keys.toggle_crew_gui)

local contacts = 	{}
for ia = 0,N do	
	contacts[ia] =
	{
		id = get_param_handle("VIS_CONTACT" .. ia .. "ID"),
		x = get_param_handle("VIS_CONTACT" .. ia .. "X"),
		y = get_param_handle("VIS_CONTACT" .. ia .. "Y"),
		z = get_param_handle("VIS_CONTACT" .. ia .. "Z"),
		vx = get_param_handle("VIS_CONTACT" .. ia .. "VX"),
		vy = get_param_handle("VIS_CONTACT" .. ia .. "VY"),
		vz = get_param_handle("VIS_CONTACT" .. ia .. "VZ"),
		type = get_param_handle("VIS_CONTACT" .. ia .. "TYPE"),
	}
end
updateddata = get_param_handle("VISCONTACTUPDATE");


function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
		
    elseif birth=="GROUND_COLD" then
		
    end
	

	
end

local function set_burst_time()
	if burst_mode == 'SHORT' then 
		burst_time = 1.0
	else
		burst_time = 2.0
	end
end

function SetCommand(command,value)
	if m60_equipped or m134_equipped then  
		if command == Keys.roe then
			if roe < 0.5 then
				roe = 1
				print_message_to_user("Doorgunner: Free Fire")
			else
				roe = 0
				print_message_to_user("Doorgunner: Hold")
			end
		end

		if command == Keys.toggle_burst_length then
			if burst_mode == 'SHORT' then
				burst_mode = 'LONG'
			else
				burst_mode = 'SHORT'
			end
			set_burst_time()
		end
	end

	if command == Keys.toggle_crew_gui then
		if show_gui >0.5 then 
			show_gui = 0.0
		else
			show_gui = 1.0
		end
		show_gui_handle:set(show_gui)
	end
end


local function read_targets()
	if updateddata:get()>0.5 then 
		old_targets = targets
		targets = {}
		local x,y, z = sensor_data.getSelfCoordinates()
		position = {x=x,y=y,z=z}
		x,y, z = sensor_data.getSelfVelocity()
		velocity ={x=x,y=y,z=z}
		local count = 0
		for i = 0,N do
			--printm
			local id= contacts[i].id:get()
			if id > 0 then 
				targets[id] = {
					position = {
						x=contacts[i].x:get(),
						y=contacts[i].y:get(),
						z=contacts[i].z:get()
					},
					v = 
					{
						x=contacts[i].vx:get(),
						y=contacts[i].vy:get(),
						z=contacts[i].vz:get()
						
					},
					type=contacts[i].type:get(),
				}
				--print_message_to_user(contacts[i].v.x)
				count =count + 1
			end
		end	
		t_data = 0.0
		
		updateddata:set(0.0)
	end
	local ia =0

	Rw_to_plane = InverseRotationMatrix(RFromQuaternion(qx:get(),qy:get(),qz:get(),qw:get()))
	
	XH6GunnerTools.prepareR(qx:get(),qy:get(),qz:get(),qw:get())

	local target
	for k,v in pairs(targets) do
		local rel_pos =
		{
			x=v.position.x-position.x,
			y=v.position.y-position.y,
			z=v.position.z-position.z
		}

		local rel_vel =
		{
			x=v.v.x-velocity.x,
			y=v.v.y-velocity.y,
			z=v.v.z-velocity.z
		}
		
		rel_pos.x = rel_pos.x+rel_vel.x*t_data
		rel_pos.y = rel_pos.y+rel_vel.y*t_data
		rel_pos.z = rel_pos.z+rel_vel.z*t_data

		local az, el, dist = XH6GunnerTools.calcAzAndEl(
			rel_pos.x,rel_pos.y,rel_pos.z,
			rel_vel.x,rel_vel.y,rel_vel.z,
			gunner_offset.x, gunner_offset.y, gunner_offset.z,
			bullet_drag,muz_vel)
		v.az = az
		v.el = el
		local gun_az = v.az + center_of_view_az
		local gun_el = v.el + center_of_view_el
		v.in_fov = gun_az >= fov_az_min and gun_az <= fov_az_max and gun_el>= fov_el_min and gun_el <= fov_el_max
		v.in_range = dist<1000
	end

end

local function choose_target()
	if actual_target ~= nil then 
		if targets then 
			if targets[actual_target] then
				if targets[actual_target].in_fov and targets[actual_target].in_range then
					return 				
				else
					--print_message_to_user("Out of fov")
				end
			else
				
				--print_message_to_user("Looking for new target")
			end
		end
	end
	
	actual_target = nil
	for k,v in pairs(targets) do
		if v.in_fov and v.in_range then 
			--check prio --range
			actual_target = k
			--print_message_to_user("Got new target")
			time_on_target = 0.0
			return
		end
	end
end

local function aim()
	is_aimed= false
	if actual_target ~= nil then
		local target = targets[actual_target]
		if target ~= nil then 
			target_az = target.az+center_of_view_az
			target_el = target.el+center_of_view_el
			local k=50.0
			local D=8.0
			k=200.0
			D=5.0
			local v_max = 45
			local a_az = (target_az-gun_az)*k-v_az*D
			local a_el = (target_el-gun_el)*k-v_el*D

			v_az = v_az+a_az*update_time_step
			v_el = v_el+a_el*update_time_step

			local v = math.sqrt(v_az*v_az+v_el*v_el)
			if v > v_max then
				v_az = v_az/v*v_max
				v_el = v_el/v*v_max
			end

			gun_az = gun_az + v_az*update_time_step
			gun_el = gun_el + v_el*update_time_step
			
			gun_az = Limit(gun_az,fov_az_min,fov_az_max)
			gun_el = Limit(gun_el,fov_el_min,fov_el_max)
			
			local on_target = math.abs(gun_az - target_az) < max_dev and math.abs(gun_el - target_el) < max_dev
			
			if on_target then 
				time_on_target = time_on_target + update_time_step
			else
				time_on_target = 0.0
			end
			if time_on_target > 1.5 then
				is_aimed = true
			end
			set_aircraft_draw_argument_value(1000,gun_az/90.0)
			set_aircraft_draw_argument_value(1001,gun_el/90.0)
		end
	end
end

function update()

	local value = get_aircraft_draw_argument_value(113)
	if value > 0.4 and value <0.6 then 
		m60_equipped = true
	elseif value > 0.8 then
		m134_equipped = true 
	end

	if m60_equipped or m134_equipped then  
		read_targets()
		choose_target()
		aim()
		

		if is_aimed and roe == 1 and time_rest >= rest_time then 
			time_shooting = time_shooting + update_time_step
			if time_shooting > burst_time then
				time_rest = 0.0
				time_shooting = 0.0
				shooting = false
			else
				shooting = true
			end
		else
			time_rest = time_rest + update_time_step
			shooting = false
		end
		
		if roe >0.5  then 
			roe_text:set("FIRE")
		else
			roe_text:set("HOLD")
		end

 		if shooting then 
			shoot_doorgun:set(1)
		else
			shoot_doorgun:set(0)
		end
		burst_text:set(burst_mode)
	else
		burst_text:set("-")
		roe_text:set("-")
	end
	t_data =t_data+update_time_step
end

need_to_be_closed = false 