dofile(LockOn_Options.script_path .. "clickable_defs.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path.."sounds.lua")

local gettext = require("i_18n")
_ = gettext.translate

elements = {}

elements["C_Knob_BaroAlt"] = default_axis(_("adjust pressure"), devices.BASIC_INDICATORS,
    device_commands.avionic_baroAltPressure, 327, 0, 0.01, false, true, true)

-- Intercom ----------------------------------------------------------------------

elements["C_Switch_Intercom1_1"] = multiposition_switch(_("Intercom1 1"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_switch11, 348, 2, 2.0, false, 0.0, 100, true)
elements["C_Switch_Intercom1_2"] = multiposition_switch(_("Intercom1 2"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_switch12, 349, 2, 2.0, false, 0.0, 100, true)
elements["C_Switch_Intercom1_3"] = multiposition_switch(_("Intercom1 3"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_switch13, 350, 2, 2.0, false, 0.0, 100, true)
elements["C_Switch_Intercom1_4"] = multiposition_switch(_("Intercom1 4"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_switch14, 351, 2, 2.0, false, 0.0, 100, true)
elements["C_Switch_Intercom1_Int"] = multiposition_switch(_("Intercom1 Int"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_switch1Int, 352, 2, 2.0, false, 0.0, 100, true)
elements["C_Switch_Intercom1_Nav"] = multiposition_switch(_("Intercom1 Nav"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_switch1Nav, 353, 2, 2.0, false, 0.0, 100, true)
elements["C_Knob_Intercom1_Vol"] = default_axis_limited(_("Intercom1 Vol"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_knob1vol, 354, 0, 0.05, false, false, { -1.0, 1.0 })
elements["C_Knob_Intercom1_switch"] = multiposition_switch(_("Intercom1 Select"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_knob1select, 355, 6, (1.0-0.165)*0.2, false, 0.165, 200, false)


elements["C_Switch_Intercom2_1"] = multiposition_switch(_("Intercom2 1"), devices.AN_ARC_54,
    device_commands.intercom_switch21, 340, 2, 1.0, false, 0.0, 100, true)
elements["C_Switch_Intercom2_2"] = multiposition_switch(_("Intercom2 2"), devices.AN_ARC_51,
    device_commands.intercom_switch22, 341, 2, 1.0, false, 0.0, 100, true)
elements["C_Switch_Intercom2_3"] = multiposition_switch(_("Intercom2 3"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_switch23, 342, 2, 1.0, false, 0.0, 100, true)
elements["C_Switch_Intercom2_4"] = multiposition_switch(_("Intercom2 4"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_switch24, 343, 2, 1.0, false, 0.0, 100, true)
elements["C_Switch_Intercom2_Int"] = multiposition_switch(_("Intercom2 Int"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_switch2Int, 344, 2, 1.0, false, 0.0, 100, true)
elements["C_Switch_Intercom2_Nav"] = multiposition_switch(_("Intercom2 Nav"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_switch2Nav, 345, 2, 1.0, false, 0.0, 100, true)
elements["C_Knob_Intercom2_Vol"] = default_axis_limited(_("Intercom2 Vol"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_knob2vol, 346, 0, 0.05, false, false, { -1.0, 1.0 })
elements["C_Knob_Intercom2_switch"] = multiposition_switch(_("Intercom2 Select"), devices.INTERCOM_INTERFACE,
    device_commands.intercom_knob2select, 347, 6, (1.0-0.165)*0.2, false,0.165, 200, false)

-- Weaponpanels ----------------------------------------------------------------------

elements["C_Knob_armpanel"] = multiposition_switch(_("Off/CLEAR/FIRE"), devices.WEAPON_SYSTEM,
    device_commands.weapon_mode, 369, 3, 0.5, false, 0.0, 100, false)
elements["C_Switch_armpanel"] = multiposition_switch(_("ARM/SAFE "), devices.WEAPON_SYSTEM, device_commands.weapon_arm,
    370, 2, 1.0, false, 0.0, 100, true)

-- Rockets --------------------------------------------------------------------------------------------
elements["C_Switch_Gun_Rockets"] = multiposition_switch(_("Gun/Rockets"), devices.WEAPON_SYSTEM,
    device_commands.weapon_select, 371, 2, 2.0, false, -1.0, 100, true)
elements["C_Knob_Salve"] = multiposition_switch(_("Rocket Pairs"), devices.WEAPON_SYSTEM,
    device_commands.weapon_rocketpairs, 372, 8, 1/7.0, false, 0.0, 100, false)
elements["C_Cover_Jettison"] = default_red_cover(_("Jettison Cover"),devices.WEAPON_SYSTEM,
    device_commands.weapon_jettison_cover, 373,10)
elements["C_Switch_Jettison"] = multiposition_switch(_("Jettison"), devices.WEAPON_SYSTEM,
    device_commands.weapon_jettison, 374, 2, 1.0, false, 0.0, 100, true)

-- Lightpanel ----------------------------------------------------------------------
elements["C_Switch_PosLight"] = multiposition_switch(_("Pos. light DIM/OFF/BRT"), devices.LIGHT_INTERFACE,
    device_commands.lightpanels_pos_light, 356, 3, 1.0, false, -1.0, 100, false)

elements["C_Switch_AntiColLight"] = multiposition_switch(_("Anti. Col. OFF/ON"), devices.LIGHT_INTERFACE,
    device_commands.lightpanels_anticol_light, 357, 2, 2.0, false, -1.0, 100, true)

elements["C_Knob_Light_Panel"] = default_axis_limited(_("Panel"), devices.LIGHT_INTERFACE,
    device_commands.lightpanels_light_panel, 358, 0, 0.05, false, false, { -1.0, 1.0 })
elements["C_Knob_Light_Radio"] = default_axis_limited(_("Radio"), devices.LIGHT_INTERFACE,
    device_commands.lightpanels_light_radio, 359, 0, 0.05, false, false, { -1.0, 1.0 })
elements["C_Knob_Light_Engine"] = default_axis_limited(_("Engine"), devices.LIGHT_INTERFACE,
    device_commands.lightpanels_light_engine, 360, 0, 0.05, false, false, { -1.0, 1.0 })
elements["C_Knob_Light_Flight"] = default_axis_limited(_("Flight"), devices.LIGHT_INTERFACE,
    device_commands.lightpanels_light_flight, 361, 0, 0.05, false, false, { -1.0, 1.0 })

-- Electric Panel -------------------------------------------------------------------

elements["C_Switch_Gyro"] = multiposition_switch(_("Gyro. ON/OFF"), devices.ELECTRIC_SYSTEM,
device_commands.electricsystem_gyro, 362, 2, 1.0, false, 0.0, 100, false)
elements["C_Switch_Aux_Tank"] = multiposition_switch(_("Aux. tank ON/OFF"), devices.ELECTRIC_SYSTEM,
device_commands.electricsystem_aux_tank, 363, 2, 1.0, false, 0.0, 100,false)
elements["C_Switch_Inverter"] = multiposition_switch(_("Inverter ON/OFF"), devices.ELECTRIC_SYSTEM,
device_commands.electricsystem_inverter, 364, 2, 1.0, false, 0.0, 100, false)
elements["C_Switch_Gen"] = multiposition_switch(_("Gen ON/OFF"), devices.ELECTRIC_SYSTEM, 
device_commands.electricsystem_gen, 365, 2, 1.0, false, 0.0, 100, false)
elements["C_Switch_fuel_pump"] = multiposition_switch(_("Fuelpump ON/OFF"), devices.ELECTRIC_SYSTEM,
device_commands.electricsystem_fuel_pump, 366, 2, 1.0, false, 0.0, 100, false)
elements["C_Switch_Power"] = multiposition_switch(_("Power BATT/OFF/EXT"), devices.ELECTRIC_SYSTEM,
device_commands.electricsystem_batt, 367, 3, 1.0, false, -1.0, 100, false)

-- Fuel --------------------------------------------------------------------------------

elements["C_Fuel_valve_lever"] = multiposition_switch(_("Fuel Valve"), devices.FUEL_INTERFACE,
    EFM_commands.fuelsystem_fuel_valve, 368, 2, 1.0, false, 0.0, 100, false)

-- Radios ------------------------------------------------------------------------

-- AN/Arc-54------------

elements["C_Knob_arc_54_Tune1"] = default_axis(_("Megacycle"), devices.AN_ARC_54,
device_commands.anarc54_tune1, 53, 0, 0.1, false, true, true)
elements["C_Knob_arc_54_Tune2"] = default_axis(_("Decimal-Megacycle"), devices.AN_ARC_54,
device_commands.anarc54_tune2, 54, 0, 0.05, false, true, true)
elements["C_Knob_arc_54_volume"] = default_axis(_("Volume"), devices.AN_ARC_54,
device_commands.anarc54_volume, 51, 0, 0.05, false,false, false)

elements["C_Knob_arc_54_squelch"] = multiposition_switch(_("Squelch"), devices.AN_ARC_54,
device_commands.anarc54_squelch, 50, 3,1.0, false, -1.0, 20, false)
elements["C_Knob_arc_54_Mode"] = multiposition_switch(_("Mode"), devices.AN_ARC_54,
device_commands.anarc54_mode, 52, 4,0.33, false, 0.0, 20, false)

-- AN/Arc-51------------
elements["C_Knob_arc_51_Channel"] =  multiposition_switch(_("Preset Channel"), devices.AN_ARC_51,
device_commands.anarc51_channel, 337, 20,1/19.0, false, 0.0, 200, false)
elements["C_Switch_ANARC51"] =  multiposition_switch(_("Squelch"), devices.AN_ARC_51,
device_commands.anarc51_switch, 61, 2,2.0, false, -1.0, 20, false)
elements["C_Knob_arc_51_volume"] = default_axis(_("Volume"), devices.AN_ARC_51,
device_commands.anarc51_volume, 57, 0, 0.2, false, false, false)
elements["C_Knob_arc_51_selector_2"] =  multiposition_switch(_("Mode"), devices.AN_ARC_51,
device_commands.anarc51_selector2, 55, 2, 1.0, false, 0.0, 20, false)
elements["C_Knob_arc_51_selector_1"] =  multiposition_switch(_("Function"), devices.AN_ARC_51,
device_commands.anarc51_selector1, 56, 4, 1.0/3.0, false, 0.0, 20, false)

elements["C_Knob_arc_51_Tune1"] =  multiposition_switch(_("10 Megacycle"), devices.AN_ARC_51,
device_commands.anarc51_tune1, 58, 18,1/18.0, false, 0.0, 200, false)
elements["C_Knob_arc_51_Tune2"] =  multiposition_switch(_("Megacycle"), devices.AN_ARC_51,
device_commands.anarc51_tune2, 59, 10,1/10.0, false, 0.0, 200, false)
elements["C_Knob_arc_51_Tune3"] =  multiposition_switch(_("deci Megacycle"), devices.AN_ARC_51,
device_commands.anarc51_tune3, 60, 20,1/20.0, false, 0.0, 200, false)

--- AN/Arc-83 --------
elements["C_Knob_ANARC83_Loop"] = default_axis_limited(_("Panel"), devices.AN_ARC_83,
    device_commands.anarc83_loop, 62, 0, 0.05, false, false, { -1.0, 1.0 })

elements["C_Switch_ANARC83"] =  multiposition_switch(_("Squelch"), devices.AN_ARC_83,
device_commands.anarc83_switch, 67, 2,2.0, false, -1.0, 20, false)

elements["ANARC83_Power"] =  multiposition_switch(_("Function"), devices.AN_ARC_83,
device_commands.anarc83_power, 64, 4, 0.33, false, 0.0, 20, false)

elements["C_Knob_ANARC83_Gain"] = default_axis(_("Gain"), devices.AN_ARC_83,
device_commands.anarc83_gain, 63, 0, 0.01, false, true, true)

elements["C_Knob_ANARC83_Band"] = multiposition_switch(_("Band"), devices.AN_ARC_83,
device_commands.anarc83_band, 66, 3,0.5, false, 0.0, 20, false)
--elements["C_Knob_ANARC83_Tune"] =  65
elements["C_Knob_ANARC83_Tune"] = default_axis(_("Tune"), devices.AN_ARC_83,
device_commands.anarc83_tune, 65, 0, 0.01, false, true, true)



elements["C_Gunsight"] = multiposition_switch(_("Toggle Gunsight"), devices.GUNSIGHT,
    device_commands.toggle_gunsight, 170, 2, 1.0, false, 0.0, 3, true)

elements["RWR_ONOFF_PTR"]	=  multiposition_switch(_("RWR, ON/OFF"), devices.RWR,
device_commands.RWROnOffSwitch, 70, 2, 1.0, false, 0.0, 20, true)

elements["RWR_Loundness"]	= default_axis_limited(_("RWR, Loudness"), devices.RWR, device_commands.RWRLoudness, 71, 0.5)
elements["RWR_Brightness_PTR"]	= default_axis_limited(_("RWR, Brightness"), devices.RWR, device_commands.RWRBrightness, 72, 0.5)

elements["C_CMWS_Disp"] = default_button(_("Flare Dispense"),devices.WEAPON_SYSTEM,device_commands.DropFlare,76,20)
elements["C_Switch_CMWS"]	=  multiposition_switch(_("CMWS Arm/Safe"), devices.WEAPON_SYSTEM,
    device_commands.FlareArmSafe, 75, 2, 1.0, false, 0.0, 20, true)
