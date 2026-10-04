dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.common_script_path .. "tools.lua")

MainPanel                          = { "ccMainPanel", LockOn_Options.script_path .. "mainpanel_init.lua" }

creators                           = {}
creators[devices.ELECTRIC_SYSTEM]  = { "avSimpleElectricSystem",  LockOn_Options.script_path .. "Systems/Electric_System.lua" }
creators[devices.WEAPON_SYSTEM]    = { "avSimpleWeaponSystem", LockOn_Options.script_path .. "Systems/Weapons.lua" }
creators[devices.LIGHT_INTERFACE]  = { "avLuaDevice", LockOn_Options.script_path .. "Systems/light_interface.lua" }
creators[devices.FUEL_INTERFACE]   = { "avLuaDevice", LockOn_Options.script_path .. "Systems/fuel_interface.lua" }
creators[devices.EFM_HELPER]       = { "avLuaDevice", LockOn_Options.script_path .. "Systems/EFM_Helper.lua" }
creators[devices.COMPASS]          = { "avLuaDevice", LockOn_Options.script_path .. "Compass/Compass.lua", devices.COMPASS }
creators[devices.GUNSIGHT] 			= {"avLuaDevice", LockOn_Options.script_path.."Gunsight/Device/Gunsight.lua"}
creators[devices.ENGINE_INTERFACE] = { "avLuaDevice", LockOn_Options.script_path .. "engines/EngineInterface.lua", devices.ENGINE_INTERFACE }
creators[devices.BASIC_INDICATORS] = { "avLuaDevice", LockOn_Options.script_path .. "BasicIndicators/BasicIndicators.lua", devices.BASIC_INDICATORS }
creators[devices.GUNNER]  = { "avLuaDevice", LockOn_Options.script_path .. "Gunner/gunner.lua" }
creators[devices.SPECIAL_GEAR]  = { "avLuaDevice", LockOn_Options.script_path .. "special_gear/special_gear.lua" }
creators[devices.DOORS]  = { "avLuaDevice", LockOn_Options.script_path .. "Systems/Doors.lua" }

creators[devices.COM1] = {"avUHF_ARC_164", LockOn_Options.script_path.."Radios/uhf_radio.lua", {devices.INTERCOM, devices.ELECTRIC_SYSTEM} }
creators[devices.COM2] = {"avVHF_ARC_186", LockOn_Options.script_path.."Radios/fm_radio.lua", {devices.INTERCOM, devices.ELECTRIC_SYSTEM} }
creators[devices.INTERCOM]         = { "avIntercom", LockOn_Options.script_path .. "Radios/Intercom.lua", { } }
creators[devices.AN_ARC_51]        = { "avLuaDevice", LockOn_Options.script_path .. "Radios/anarc_51.lua", { devices.INTERCOM, devices.ELECTRIC_SYSTEM } }
creators[devices.AN_ARC_54]        = { "avLuaDevice", LockOn_Options.script_path .. "Radios/anarc_54.lua", { devices.INTERCOM, devices.ELECTRIC_SYSTEM } }
creators[devices.AN_ARC_83]        = { "avLuaDevice", LockOn_Options.script_path .. "Radios/anarc_83.lua", { devices.INTERCOM, devices.ELECTRIC_SYSTEM } }
creators[devices.INTERCOM_INTERFACE]  = { "avLuaDevice", LockOn_Options.script_path .. "Radios/Intercom_Interface.lua"}
creators[devices.HELMET_DEVICE]         = {"avNightVisionGoggles"}
-- Tanuki44
creators[devices.SUNVISOR]      = {"avLuaDevice"			,LockOn_Options.script_path.."SunVisor/device/Sunvisor.lua"}
creators[devices.RWR]	 			= {"avSimpleRWR"				,LockOn_Options.script_path.."RWR/rwr.lua"}	

indicators                         = {}
indicators[#indicators + 1] = {"ccIndicator",LockOn_Options.script_path .. "GunnerGui/GunnerGui.lua", nil }
indicators[#indicators + 1] = { "ccControlsIndicatorBase", LockOn_Options.script_path .. "ControlsIndicator/ControlsIndicator.lua", nil }
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."Gunsight/Indicator/init.lua", nil, 
  {
       {"PNT_SIGHT_CENTER"  ,"PNT_SIGHT_DOWN"  ,"PNT_SIGHT_RIGHT"},	
   }	
}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."SunVisor/indicator/init.lua",nil}
indicators[#indicators + 1] = {"ccIndicator" ,LockOn_Options.script_path.."RWR/indicator/init.lua",devices.RWR,{{"RWR_Center", "RWR_Bottom","RWR_Right"}}}

dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")