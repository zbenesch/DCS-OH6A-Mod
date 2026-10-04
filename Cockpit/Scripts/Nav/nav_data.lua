--Type
BEACON_TYPE_NULL = 0
BEACON_TYPE_VOR = 1
BEACON_TYPE_DME = 2
BEACON_TYPE_VOR_DME = 3
BEACON_TYPE_TACAN = 4
BEACON_TYPE_VORTAC = 5
BEACON_TYPE_RSBN = 128
BEACON_TYPE_BROADCAST_STATION = 1024

BEACON_TYPE_HOMER = 8
BEACON_TYPE_AIRPORT_HOMER = 4104
BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER = 4136
BEACON_TYPE_ILS_FAR_HOMER = 16408
BEACON_TYPE_ILS_NEAR_HOMER = 16424

BEACON_TYPE_ILS_LOCALIZER = 16640
BEACON_TYPE_ILS_GLIDESLOPE = 16896

BEACON_TYPE_PRMG_LOCALIZER = 33024
BEACON_TYPE_PRMG_GLIDESLOPE = 33280

BEACON_TYPE_ICLS_LOCALIZER = 131328
BEACON_TYPE_ICLS_GLIDESLOPE = 131584

BEACON_TYPE_NAUTICAL_HOMER = 65536

-- Display
BEACON_TYPE = {}
BEACON_TYPE[BEACON_TYPE_NULL] = "BEACON_TYPE_NULL"
BEACON_TYPE[BEACON_TYPE_VOR] = "BEACON_TYPE_VOR"
BEACON_TYPE[BEACON_TYPE_DME] = "BEACON_TYPE_DME"
BEACON_TYPE[BEACON_TYPE_VOR_DME] = "BEACON_TYPE_VOR_DME"
BEACON_TYPE[BEACON_TYPE_TACAN] = "BEACON_TYPE_TACAN"
BEACON_TYPE[BEACON_TYPE_VORTAC] = "BEACON_TYPE_VORTAC"
BEACON_TYPE[BEACON_TYPE_RSBN] = "BEACON_TYPE_RSBN"
BEACON_TYPE[BEACON_TYPE_BROADCAST_STATION] = "BEACON_TYPE_BROADCAST_STATION"
BEACON_TYPE[BEACON_TYPE_HOMER] = "BEACON_TYPE_HOMER"
BEACON_TYPE[BEACON_TYPE_AIRPORT_HOMER] = "BEACON_TYPE_AIRPORT_HOMER"
BEACON_TYPE[BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER] = "BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER"
BEACON_TYPE[BEACON_TYPE_ILS_FAR_HOMER] = "BEACON_TYPE_ILS_FAR_HOMER"
BEACON_TYPE[BEACON_TYPE_ILS_NEAR_HOMER] = "BEACON_TYPE_ILS_NEAR_HOMER"
BEACON_TYPE[BEACON_TYPE_ILS_LOCALIZER] = "BEACON_TYPE_ILS_LOCALIZER"
BEACON_TYPE[BEACON_TYPE_ILS_GLIDESLOPE] = "BEACON_TYPE_ILS_GLIDESLOPE"
BEACON_TYPE[BEACON_TYPE_PRMG_LOCALIZER] = "BEACON_TYPE_PRMG_LOCALIZER"
BEACON_TYPE[BEACON_TYPE_PRMG_GLIDESLOPE] = "BEACON_TYPE_PRMG_GLIDESLOPE"
BEACON_TYPE[BEACON_TYPE_ICLS_LOCALIZER] = "BEACON_TYPE_ICLS_LOCALIZER"
BEACON_TYPE[BEACON_TYPE_ICLS_GLIDESLOPE] = "BEACON_TYPE_ICLS_GLIDESLOPE"
BEACON_TYPE[BEACON_TYPE_NAUTICAL_HOMER] = "BEACON_TYPE_NAUTICAL_HOMER"

--Beacon state
BEACON_DISABLED = 0
BEACON_ACTIVE = 1 --default status
BEACON_INACTIVE = 2
BEACON_DESTROYED = 3

-- Define Morse code mappings
local morseCode = {
    ['A'] = '.-',     ['B'] = '-...',   ['C'] = '-.-.',   ['D'] = '-..',
    ['E'] = '.',      ['F'] = '..-.',   ['G'] = '--.',    ['H'] = '....',
    ['I'] = '..',     ['J'] = '.---',   ['K'] = '-.-',    ['L'] = '.-..',
    ['M'] = '--',     ['N'] = '-.',     ['O'] = '---',    ['P'] = '.--.',
    ['Q'] = '--.-',   ['R'] = '.-.',    ['S'] = '...',    ['T'] = '-',
    ['U'] = '..-',    ['V'] = '...-',   ['W'] = '.--',    ['X'] = '-..-',
    ['Y'] = '-.--',   ['Z'] = '--..',   
    ['1'] = '.----',  ['2'] = '..---',  ['3'] = '...--',  ['4'] = '....-', 
    ['5'] = '.....',  ['6'] = '-....',  ['7'] = '--...',  ['8'] = '---..',
    ['9'] = '----.',  ['0'] = '-----',
}

-- Function to translate a string to Morse code
function GetMorse(ident)
    local morse = ""
    for i = 1, #ident do
        local char = string.upper(ident:sub(i, i))
        if morseCode[char] then
            morse = morse .. morseCode[char] .. " "
        elseif char == ' ' then
            -- Add a space to separate words
            morse = morse .. " "
        end
    end
    return morse
end


--local name = get_terrain_related_data("name")
local beaconFile =  get_terrain_related_data("beacons") or get_terrain_related_data("beaconsFile")
if beaconFile then 
    dofile(beaconFile)
end

local terrain           = require('terrain')

local antenna_height = 25
local nautical_mile_to_meter = 1852
local max_range_adf = 200
local max_range_vor = 130
local max_range_dme = 199
local max_range_tacan = 200

function GetMaxRange(beacon)
    if beacon.type == BEACON_TYPE_HOMER 
	or beacon.type == BEACON_TYPE_AIRPORT_HOMER 
	or beacon.type == BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER 
	or beacon.type == BEACON_TYPE_ILS_FAR_HOMER
	or beacon.type == BEACON_TYPE_ILS_NEAR_HOMER
	or beacon.type == BEACON_TYPE_BROADCAST_STATION 
	or beacon.type == BEACON_TYPE_NAUTICAL_HOMER then
        return max_range_adf * nautical_mile_to_meter
    elseif beacon.type == BEACON_TYPE_VOR 
    or beacon.type == BEACON_TYPE_VOR_DME
    or beacon.type == BEACON_TYPE_VORTAC then
        return max_range_vor * nautical_mile_to_meter
    elseif beacon.type == BEACON_TYPE_DME then
        return max_range_dme * nautical_mile_to_meter
    elseif beacon.type == BEACON_TYPE_TACAN then
        return max_range_tacan * nautical_mile_to_meter
	end

    return 0
end

function GetDistance(selfPosition, beacon)
    -- Extract coordinates from the aircraftPosition and beaconPosition vectors
    local aircraftX = selfPosition[1]
    local aircraftY = selfPosition[2]
    local aircraftZ = selfPosition[3]

    local beaconX = beacon.position[1]
    local beaconY = beacon.position[2] + antenna_height -- assume the beacon antenna is located a few meters above the ground
    local beaconZ = beacon.position[3]

    -- Calculate the distance between the aircraft and the beacon
    local delta_x = beaconX - aircraftX
    local delta_y = beaconY - aircraftY
    local delta_z = beaconZ - aircraftZ

    local distance = math.sqrt(delta_x * delta_x + delta_y * delta_y + delta_z * delta_z)
    return distance
end

function IsVisible(selfPosition, beacon)
    selfPositionX = selfPosition[1]
    selfPositionY = selfPosition[2]
    selfPositionZ = selfPosition[3]

    beaconPositionX = beacon.position[1]
    beaconPositionY = beacon.position[2] + antenna_height -- assume the beacon antenna is located a few meters above the ground
    beaconPositionZ = beacon.position[3]
        
    local distance = GetDistance(selfPosition, beacon)
    local max_range = GetMaxRange(beacon)

    if distance <= max_range and terrain.isVisible(selfPositionX, selfPositionY, selfPositionZ, beaconPositionX, beaconPositionY, beaconPositionZ) then
        return true
    else
        return false
    end
end

function GetBearing(selfPosition, beacon)
    -- Note: X and Z is coordinate and Y is altitude

    selfPositionX = selfPosition[1]
    selfPositionY = selfPosition[2]
    selfPositionZ = selfPosition[3]

    beaconPositionX = beacon.position[1]
    beaconPositionY = beacon.position[2] + antenna_height -- assume the beacon antenna is located a few meters above the ground
    beaconPositionZ = beacon.position[3]

    -- Calculate the distance between the aircraft and the beacon
    local delta_x = beaconPositionX - selfPositionX
    local delta_z = beaconPositionZ - selfPositionZ
    
    local bearing = math.deg(math.atan2(delta_z, delta_x)) % 360

    return bearing
end

function GetDeviation(selfPosition, beacon, radial)
    -- Note: X and Z are coordinates and Y is altitude

    -- Extract coordinates from the aircraftPosition and beaconPosition vectors
    local aircraftX = selfPosition[1]
    local aircraftY = selfPosition[2]
    local aircraftZ = selfPosition[3]

    local beaconX = beacon.position[1]
    local beaconY = beacon.position[2] -- No need to adjust for antenna height in VOR calculation
    local beaconZ = beacon.position[3]

    -- Calculate the angle between the aircraft's position and the beacon's position
    local delta_x = beaconX - aircraftX
    local delta_z = beaconZ - aircraftZ

    local angle = math.deg(math.atan2(delta_z, delta_x))

    -- Calculate the difference between the selected radial and the angle to the beacon
    local deviation = radial - angle

    -- Ensure deviation is within [-180, 180) range
    deviation = (deviation + 180) % 360 - 180    
    return deviation
end

function GetBeaconADF(selfPosition, frequency)
    local result = nil
    local power = 0.0
    -- find closest visible beacon
    local beacon_candidate = nil
    local min_dist = 2000E3
    
    -- Pre-calculate self position for distance checks
    local selfX = selfPosition[1]
    local selfY = selfPosition[2]
    local selfZ = selfPosition[3]
    
    for key,beacon in pairs(beacons) do
        if beacon.type == BEACON_TYPE_HOMER 
        or beacon.type == BEACON_TYPE_AIRPORT_HOMER 
        or beacon.type == BEACON_TYPE_AIRPORT_HOMER_WITH_MARKER 
        or beacon.type == BEACON_TYPE_ILS_FAR_HOMER
        or beacon.type == BEACON_TYPE_ILS_NEAR_HOMER
        or beacon.type == BEACON_TYPE_BROADCAST_STATION 
        or beacon.type == BEACON_TYPE_NAUTICAL_HOMER then
            local freq_dist = math.abs(beacon.frequency - frequency)
            if freq_dist < 20.0E3 then
                -- Quick distance check (squared distance, no sqrt needed) before expensive terrain.isVisible
                local max_range = GetMaxRange(beacon)
                local dx = beacon.position[1] - selfX
                local dy = (beacon.position[2] + antenna_height) - selfY
                local dz = beacon.position[3] - selfZ
                local sqr_distance = dx*dx + dy*dy + dz*dz
                local max_range_sqr = max_range * max_range
                
                -- Only call expensive IsVisible if beacon is within range
                if sqr_distance <= max_range_sqr then
                    if IsVisible(selfPosition, beacon) then
                        if freq_dist < min_dist then
                            beacon_candidate = beacon
                            min_dist = freq_dist
                            
                            -- found a beacon with matching frequency
                            result = beacon_candidate
                            power = 1.0-min_dist/20.0E3
                        end
                    end
                end
            end
        end
    end

    return result, power
end

function GetBearingADF(selfPosition, frequency)
    local beacon, power = GetBeaconADF(selfPosition, frequency)

    if beacon ~= nil then
        local bearing = GetBearing(selfPosition, beacon)
        return bearing, power
    else
        return nil, 0.0
    end
end

function GetIdentADF(selfPosition, frequency)
    local beacon = GetBeaconADF(selfPosition, frequency)

    if beacon ~= nil then
        local morse = GetMorse(beacon.callsign)
        return morse
    else
        return ""
    end
end

function GetBeaconVOR(selfPosition, frequency)
    local result = nil
    for key,beacon in pairs(beacons) do
		if beacon.frequency == frequency then
			-- found a beacon with matching frequency
			if beacon.type == BEACON_TYPE_VOR 
			or beacon.type == BEACON_TYPE_VOR_DME 
			or beacon.type == BEACON_TYPE_VORTAC then
                
                if IsVisible(selfPosition, beacon) then
                    result = beacon
                end
            end            
        end
    end

    return result
end

function GetDeviationVOR(selfPosition, frequency, radial)
    local beacon = GetBeaconVOR(selfPosition, frequency)

    if deviation ~= nil then
        local deviation = GetDeviation(selfPosition, beacon, radial)
        return deviation
    else
        return nil
    end
end

function GetBeaconDME(selfPosition, frequency)
    local result = nil
    for key,beacon in pairs(beacons) do
		if beacon.frequency == frequency then
			-- found a beacon with matching frequency
            -- Note: TACAN has DME for distance
			if beacon.type == BEACON_TYPE_DME
			or beacon.type == BEACON_TYPE_VOR_DME
            or beacon.type == BEACON_TYPE_TACAN 
			or beacon.type == BEACON_TYPE_VORTAC then
                
                if IsVisible(selfPosition, beacon) then
                    result = beacon
                end
            end            
        end
    end

    return result
end

function GetDistanceDME(selfPosition, frequency)
    local beacon = GetBeaconDME(selfPosition, frequency)

    if distance ~= nil then
        local distance = GetDistance(selfPosition, beacon)
        return distance
    else
        return nil
    end
end

function GetBeaconTACAN(selfPosition, frequency)
    local result = nil
    for key,beacon in pairs(beacons) do
		if beacon.frequency == frequency then
			-- found a beacon with matching frequency
			if beacon.type == BEACON_TYPE_TACAN 
			or beacon.type == BEACON_TYPE_VORTAC then
                
                if IsVisible(selfPosition, beacon) then
                    result = beacon
                end
            end            
        end
    end

    return result
end

function GetDeviationTACAN(selfPosition, frequency, radial)
    local beacon = GetBeaconTACAN(selfPosition, frequency)

    if deviation ~= nil then
        local deviation = GetDeviation(selfPosition, beacon, radial)
        return deviation
    else
        return nil
    end
end

function GetDistanceTACAN(selfPosition, frequency)
    -- Using DME beacons, as they include TACAN beacons for distance
    local beacon = GetBeaconDME(selfPosition, frequency)

    if distance ~= nil then
        local distance = GetDistance(selfPosition, beacon)
        return distance
    else
        return nil
    end
end