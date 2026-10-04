dofile(LockOn_Options.script_path.."command_defs.lua")

local update_rate = 0.01
local t_since_out = 0.0

local rate = 0.75
make_default_activity(update_rate)
local dev = GetSelf()

local front_doors_t = 0.0
local rear_doors_t = 0.0

local front_doors_val = 0.0
local rear_doors_val = 0.0

local CROSSTALK = get_param_handle("CROSSTALKTEST")

local OPEN_DOORS = get_param_handle("OPEN_DOORS")
local DOORS_OFF = get_param_handle("DOORS_OFF")
local DOOR_OFF_L = get_param_handle("DOOR_OFF_L")
local DOOR_OFF_R = get_param_handle("DOOR_OFF_R")

function removed_doors()
    local front_doors = get_aircraft_draw_argument_value(209)
    local rear_doors = get_aircraft_draw_argument_value(210)
    DOORS_OFF:set(get_aircraft_draw_argument_value(209))
    DOOR_OFF_L:set(get_aircraft_draw_argument_value(205))
    DOOR_OFF_R:set(get_aircraft_draw_argument_value(206))
    return front_doors > 0.5 or rear_doors > 0.5
end

local function removed_front_doors()
    local front_doors = get_aircraft_draw_argument_value(209)
    return front_doors > 0.5
end


function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
        front_doors_t = 0.0
        rear_doors_t = 0.0
        front_doors_val = 0.0
        rear_doors_val = 0.0
    elseif birth=="GROUND_COLD" then
        front_doors_t = 0.9
        rear_doors_t = 0.9
        front_doors_val = 0.9
        rear_doors_val = 0.9
    end
    if removed_front_doors() then 
        front_doors_t = 0.9
        front_doors_val = 0.9
    end
    set_aircraft_draw_argument_value(38,front_doors_val)
end

dev:listen_command(Keys.ToggleDoors)

function SetCommand(command,value)

    if not removed_front_doors() then 
        if command == Keys.ToggleDoors then
            local val = front_doors_t
            if val >0.5 then
                front_doors_t = 0.0
            else
                front_doors_t = 0.9
            end
        end
    end
end

local function update_door_val(val,t)
    if val < t then 
        val = val + math.min(rate * update_rate, t - val)
    else
        val = val - math.min(rate * update_rate, val - t)
    end
    return val
end

local function update_doors()
    front_doors_val = update_door_val(front_doors_val, front_doors_t)
    rear_doors_val = update_door_val(rear_doors_val, rear_doors_t)
    
    OPEN_DOORS:set(front_doors_val)
    set_aircraft_draw_argument_value(35,front_doors_val)
    set_aircraft_draw_argument_value(38,front_doors_val)
    if removed_doors() then 
        set_aircraft_draw_argument_value(38,0.9)
    end
end

function update()
    
    t_since_out = t_since_out + update_rate
    if t_since_out >0.5 then
        t_since_out = 0.0
    end
    update_doors()
end


need_to_be_closed = false -- close lua state after initialization