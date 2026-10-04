--[[
sounds ids 1 ... n
]]
local count = 0
local function counter()
	count = count + 1
	return count
end

SWITCH_BASIC = counter()
