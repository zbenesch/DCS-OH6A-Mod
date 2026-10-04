local count = 0

local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices                       = {}
devices["ELECTRIC_SYSTEM"]    = counter()
devices["WEAPON_SYSTEM"]      = counter()
devices["EFM_HELPER"]         = counter()
devices["BASIC_INDICATORS"]   = counter()
devices["ENGINE_INTERFACE"]   = counter()
devices["FUEL_INTERFACE"]     = counter()
devices["LIGHT_INTERFACE"]    = counter()
devices["GUNSIGHT"]           = counter()
devices["COMPASS"]            = counter()
devices["RWR"]				  = counter()
devices["GUNNER"]             = counter()
devices["SPECIAL_GEAR"]       = counter()
devices["DOORS"]              = counter()

devices["COM1"]               = counter()
devices["COM2"]               = counter()
devices["AN_ARC_51"]          = counter()
devices["AN_ARC_54"]          = counter()
devices["AN_ARC_83"]          = counter()
devices["INTERCOM"]           = counter()
devices["INTERCOM_INTERFACE"] = counter()
devices["KNEEBOARD"]          = counter()
devices["HELMET_DEVICE"]      = counter()

-- Tanuki44
devices["SUNVISOR"]			= counter()