dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."math_tools.lua")

package.cpath 	= package.cpath..";".. LockOn_Options.script_path.. "..\\..\\bin\\?.dll"
require('XH6GunnerTools')
local Terrain = require('terrain')

local dev = GetSelf()
local sensor_data = get_base_data()
local update_time_step = 0.02  

local targets={}
local old_targets={}
local actual_target
local position
local p_lock = nil
local dc_elec = get_param_handle("DC_POWER_AVAIL")

dev:listen_command(Keys.SearchLight)
dev:listen_command(Keys.SearchLightMode)
dev:listen_command(Keys.SearchLightUp)
dev:listen_command(Keys.SearchLightDown)
dev:listen_command(Keys.SearchLightUpDownRelease)
dev:listen_command(Keys.SearchLightLeft)
dev:listen_command(Keys.SearchLightRight)
dev:listen_command(Keys.SearchLightLeftRightRelease)
dev:listen_command(Keys.SearchLightLock)
dev:listen_command(Keys.SearchlightXAxis)
dev:listen_command(Keys.SearchlightYAxis)

local qx = get_param_handle("QUATERNIONX")
local qy = get_param_handle("QUATERNIONY")
local qz = get_param_handle("QUATERNIONZ")
local qw = get_param_handle("QUATERNIONW")

local FLOATERS_EQUIPPED  = get_param_handle("FLOATERS_EQUIPPED")

local center_of_view_az = 0
local center_of_view_el = 0

local fov_az_min = -90	
local fov_az_max = 90

local fov_el_min = -80
local fov_el_max = 45

local target_az = 0.0
local target_el = 0.0

local cam_az = 0.0
local cam_el = 0.0

local cam_equipped = false
local cam_man_equipped = false
local light_equipped = false
local floaters_equipped = false

local light_enabled = false


local locked = false

local x_axis = 0.0
local y_axis = 0.0


-- 'AUTOMATIC' or 'MANUAL'
local searchlight_mode = 'MANUAL' 

local v_az = 0.0
local v_el = 0.0
local R =nil 
local position = {x=0,y=0,z=0}
local contacts = 	{}

make_default_activity(update_time_step)


local N = 50
for ia = 0,N  do	
	contacts[ia] =
	{
		id = get_param_handle("VIS_CONTACT" .. ia .. "ID"),
		x = get_param_handle("VIS_CONTACT" .. ia .. "X"),
		y = get_param_handle("VIS_CONTACT" .. ia .. "Y"),
		z = get_param_handle("VIS_CONTACT" .. ia .. "Z"),
		type = get_param_handle("VIS_CONTACT" .. ia .. "TYPE"),
	}
end

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place	
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then

    elseif birth=="GROUND_COLD" then

    end
	cam_equipped =  get_aircraft_draw_argument_value(140) > 0.55 and  get_aircraft_draw_argument_value(140) < 0.65
	cam_man_equipped =  get_aircraft_draw_argument_value(140) > 0.3 and  get_aircraft_draw_argument_value(140) < 0.45
	light_equipped =  get_aircraft_draw_argument_value(140) > 0.75
	floaters_equipped =  get_aircraft_draw_argument_value(140) < -0.5
	
end


local function find_lock_position()
	
	local cosaz = math.cos((target_az+center_of_view_az)/180.0*math.pi)
	local sinaz = math.sin((target_az+center_of_view_az)/180.0*math.pi)
	local cosel = math.cos((target_el+center_of_view_el)/180.0*math.pi)
	local sinel = math.sin((target_el+center_of_view_el)/180.0*math.pi)
	local n = {
		x=cosel*cosaz,
		y=-sinel,
		z=cosel*sinaz,
	}
	-- plane
	local strn = "n: ("..tostring(n.x)..","..tostring(n.y)..","..tostring(n.z)..")"
	n = MatMulVec(R,n)
	local close_dist = 0.0
	local test_dist = 100.0
	local iter = 0
	local found = false
	local p
	while ((not found) and iter < 20) do
	 	p = {x=position.x+test_dist*n.x,y=position.y+test_dist*n.y,z=position.z+test_dist*n.z}
		local visible = Terrain.isVisible(position.x,position.y,position.z, p.x,p.y,p.z)
	 	if visible then 
	 		close_dist = test_dist
	 		test_dist = test_dist*2.0
	 	else
	 		test_dist = close_dist + (test_dist-close_dist)*0.5
	 		if test_dist - close_dist < 1.0 then
	 			found = true
	 		end
	 	end
	 	iter = iter + 1
	end
	p_lock = p
	--print_message_to_user(iter)
	--local str = "Dist: "..tostring(test_dist).."("..tostring(p.x-position.x)..","..tostring(p.y-position.y)..","..tostring(p.z-position.z)..")"
	--print_message_to_user(str)
	--print_message_to_user(test_dist-close_dist)
	
end

function SetCommand(command,value)
	if command == Keys.SearchLightMode then
        if searchlight_mode == 'AUTOMATIC' then 
			searchlight_mode = 'MANUAL'
		--elseif searchlight_mode == 'MANUAL' then 
		--	searchlight_mode = 'GROUNDLOCK'
		else
			searchlight_mode = 'AUTOMATIC'
		end
		print_message_to_user(searchlight_mode)
    end
	if command == Keys.SearchLight then 
		if light_enabled then 
			light_enabled = false
		else
			light_enabled = true
		end
	end

	if searchlight_mode == 'MANUAL' or searchlight_mode == 'GROUNDLOCK' then
		local rate = 15.0
		if not locked then 
			if command == Keys.SearchlightXAxis then
				x_axis=value
			end
			
			if command == Keys.SearchlightYAxis then
				y_axis=-value
			end


			if command == Keys.SearchLightDown then
				y_axis=1.0
			end
						
			if command == Keys.SearchLightUp then
				y_axis=-1.0
			end
			
			if command == Keys.SearchLightUpDownRelease then
				y_axis = 0.0
			end


			if command == Keys.SearchLightRight then
				x_axis = 1.0
			end
			
			if command == Keys.SearchLightLeft then
				x_axis = -1.0
			end

			if command == Keys.SearchLightLeftRightRelease then
				x_axis = 0.0
			end
		
		end
	end

	if searchlight_mode == 'MANUAL' then 
		if command == Keys.SearchLightLock then 
			if locked then 
				locked = false
				print_message_to_user("unlock")
			else
				print_message_to_user("Try Lock")
				find_lock_position()
				locked = true
			end
		end
	end

end



local function read_targets()
	targets = {}

	local x,y, z = sensor_data.getSelfVelocity()
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
				type=contacts[i].type:get(),
			}
			count =count + 1
		end
	end	
	
	local ia =0

	local target
	for k,v in pairs(targets) do
		local rel_pos =
		{
			x=v.position.x-position.x,
			y=v.position.y-position.y,
			z=v.position.z-position.z
		}
		local dist
		v.az, v.el, dist = XH6GunnerTools.calcAzAndElDirect(rel_pos.x,rel_pos.y,rel_pos.z)
		local cam_az_tmp = v.az+center_of_view_az
		local cam_el_tmp = v.el+center_of_view_el
		v.in_fov = cam_az_tmp >= fov_az_min and cam_az_tmp <= fov_az_max and cam_el_tmp>= fov_el_min and cam_el_tmp <= fov_el_max
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
			actual_target = k
			--print_message_to_user("Got new target")
			return
		end
	end
end

local function track()
	local k=50.0
	local D=8.0
	k=200.0
	D=5.0
	local v_max = 45
	local a_az = (target_az-cam_az)*k-v_az*D
	local a_el = (target_el-cam_el)*k-v_el*D

	v_az = v_az+a_az*update_time_step
	v_el = v_el+a_el*update_time_step

	local v = math.sqrt(v_az*v_az+v_el*v_el)
	if v > v_max then
		v_az = v_az/v*v_max
		v_el = v_el/v*v_max
	end

	cam_az = cam_az + v_az*update_time_step
	cam_el = cam_el + v_el*update_time_step
	
	cam_az = Limit(cam_az,fov_az_min,fov_az_max)
	cam_el = Limit(cam_el,fov_el_min,fov_el_max)
	

	set_aircraft_draw_argument_value(141,cam_az/90.0)
	set_aircraft_draw_argument_value(142,cam_el/90.0)

end

local function set_target_coords()
	if searchlight_mode == 'AUTOMATIC' or cam_equipped or cam_man_equipped then 
		if actual_target ~= nil then
			local target = targets[actual_target]
			if target ~= nil then 
				target_az = target.az+center_of_view_az
				target_el = target.el+center_of_view_el
			end
		end
	end

	if searchlight_mode == 'MANUAL' and locked then 
		if p_lock ~= nil then 
			local rel_pos =
			{
				x=p_lock.x-position.x,
				y=p_lock.y-position.y,
				z=p_lock.z-position.z
			}
			local dist
			target_az, target_el, dist = XH6GunnerTools.calcAzAndElDirect(rel_pos.x,rel_pos.y,rel_pos.z)
			target_az = Limit(target_az,fov_az_min,fov_az_max)
			target_el = Limit(target_el,fov_el_min,fov_el_max)
		end
	end
end

function update()
	cam_equipped =  get_aircraft_draw_argument_value(140) > 0.55 and  get_aircraft_draw_argument_value(140) < 0.65
	cam_man_equipped =  get_aircraft_draw_argument_value(140) > 0.3 and  get_aircraft_draw_argument_value(140) < 0.45
	light_equipped =  get_aircraft_draw_argument_value(140) > 0.75
	floaters_equipped =  get_aircraft_draw_argument_value(140) < -0.5

	if floaters_equipped then 
		FLOATERS_EQUIPPED:set(1.0) 
	else
		FLOATERS_EQUIPPED:set(0.0) 
	end

	if cam_man_equipped then
		center_of_view_az = -90
		center_of_view_el = 0

		fov_az_min = -70	
		fov_az_max = 70
		fov_el_min = -80
		fov_el_max = 25
	else
		center_of_view_az = 0
		center_of_view_el = 0
		
		fov_az_min = -90	
		fov_az_max = 90
		fov_el_min = -80
		fov_el_max = 45
	end

	if cam_equipped or light_equipped or cam_man_equipped then  
		local x,y, z = sensor_data.getSelfCoordinates()
		XH6GunnerTools.prepareR(qx:get(),qy:get(),qz:get(),qw:get())
		R = RFromQuaternion(qx:get(),qy:get(),qz:get(),qw:get())
		position = {x=x,y=y,z=z}
		read_targets()
		choose_target()
		set_target_coords()
		track()
	end
	if light_equipped and light_enabled then 
		set_aircraft_draw_argument_value(116,1)
	else
		set_aircraft_draw_argument_value(116,0)
	end

	if searchlight_mode == 'MANUAL' or searchlight_mode == 'GROUNDLOCK' then
		local rate = 30.0
		if not locked then 
			target_az = target_az + rate*update_time_step*x_axis
			target_el = target_el + rate*update_time_step*y_axis
			
			if target_el + center_of_view_el > fov_el_max then 
				target_el = fov_el_max - center_of_view_el 
			end
			
			if target_el + center_of_view_el < fov_el_min then 
				target_el = fov_el_min - center_of_view_el 
			end
			
			if target_az + center_of_view_az > fov_az_max then 
				target_az = fov_az_max - center_of_view_az 
			end

			if target_az + center_of_view_az < fov_az_min then 
				target_az = fov_az_min - center_of_view_az 
			end
		end
	end

end

need_to_be_closed = false 