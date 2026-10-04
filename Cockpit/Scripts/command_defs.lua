local function counter()
	count = count + 1
	return count
end

count = 10000

Keys =
{
	DropGrenade                 = counter(),
	SwitchGrenadeColor          = counter(),
	FireOn                      = counter(),
	FireOff                     = counter(),
	GunUp                       = counter(),
	GunDown                     = counter(),
	BattSwitchBatt              = counter(),
	BattSwitchOff               = counter(),
	BattSwitchExt               = counter(),
	LandingLight                = counter(),
	GovTrimUp                   = counter(),
	GovTrimDown                 = counter(),
	StarterButton               = counter(),
	StarterButtonRelease        = counter(),
	ThrottleIncrease            = counter(),
	ThrottleDecrease            = counter(),
	ThrottleIdle                = counter(),
	ThrottleCutoff              = counter(),
	showControlInd              = counter(),
	LogDataPoint                = counter(),
	StartLateralFT              = counter(),
	StartLongFT                 = counter(),

	gen_on                      = counter(),
	gen_off                     = counter(),
	gen_toggle                  = counter(),
	inverter_on                 = counter(),
	inverter_off                = counter(),
	inverter_toggle             = counter(),
	gyro_mag                    = counter(),
	gyro_dir                    = counter(),
	gyro_toggle                 = counter(),
	fuel_valve_on               = counter(),
	fuel_valve_off              = counter(),
	fuel_valve_toggle           = counter(),

	gunsight_up                 = counter(),
	gunsight_down               = counter(),
	toggle_gunsight             = counter(),
	weapon_select_gun           = counter(),
	weapon_select_rockets       = counter(),
	Master_arm_on               = counter(),
	Master_arm_off              = counter(),
	Master_arm_toggle           = counter(),

	increase_salvo_length       = counter(),
	decrease_salvo_length       = counter(),

	jettison_cover              = counter(),
	jettison                    = counter(),

	weapon_mode_off             = counter(),
	weapon_mode_normal          = counter(),
	weapon_mode_toclear         = counter(),
	weapon_mode_toggle          = counter(),

	roe                         = counter(),
	toggle_burst_length         = counter(),
	toggle_crew_gui             = counter(),

	SearchLightUp               = counter(),
	SearchLightDown             = counter(),
	SearchLightUpDownRelease    = counter(),
	SearchLightLeft             = counter(),
	SearchLightRight            = counter(),
	SearchLightLeftRightRelease = counter(),
	SearchLight                 = counter(),
	SearchLightMode             = counter(),
	SearchLightLock             = counter(),

	ToggleDoors                 = counter(),
	ptt                         = counter(),
	ptt_voice                   = counter(),

	throttleAxis                = counter(),
	SearchlightXAxis            = counter(),
	SearchlightYAxis            = counter(),

	pos_light_dim               = counter(),
	pos_light_bright            = counter(),
	pos_light_off               = counter(),
	acol_light_off              = counter(),
	acol_light_on               = counter(),

	inc_light_panel             = counter(),
	dec_light_panel             = counter(),
	inc_light_radio             = counter(),
	dec_light_radio             = counter(),
	inc_light_engine            = counter(),
	dec_light_engine            = counter(),
	inc_light_flight            = counter(),
	dec_light_flight            = counter(),

	inc_intercom_select         = counter(),
	dec_intercom_select         = counter(),

	anarc_51_inc_channel        = counter(),
	anarc_51_dec_channel        = counter(),
	anarc_51_inc_tune1          = counter(),
	anarc_51_dec_tune1          = counter(),
	anarc_51_inc_tune2          = counter(),
	anarc_51_dec_tune2          = counter(),
	anarc_51_inc_tune3          = counter(),
	anarc_51_dec_tune3          = counter(),
	anarc_51_inc_vol            = counter(),
	anarc_51_dec_vol            = counter(),
	anarc_51_preset             = counter(),
	anarc_51_manual             = counter(),
	anarc_51_mode_up            = counter(),
	anarc_51_mode_down          = counter(),

	anarc_54_mode_up            = counter(),
	anarc_54_mode_down          = counter(),
	anarc_54_inc_tune1          = counter(),
	anarc_54_dec_tune1          = counter(),
	anarc_54_inc_tune2          = counter(),
	anarc_54_dec_tune2          = counter(),
	anarc_54_inc_vol            = counter(),
	anarc_54_dec_vol            = counter(),

	sunVisorToggle              = counter(),
	sight_brightness_dec 		= counter(),
	sight_brightness_inc 		= counter(),

	anarc_83_mode_up =counter(),
	anarc_83_mode_down =counter(),
	anarc_83_band_up =counter(),
	anarc_83_band_down =counter(),
	anarc_83_tune_up =counter(),
	anarc_83_tune_down =counter(),
	anarc_83_gain_up =counter(),
	anarc_83_gain_down =counter(),

	RWROnOffSwitch = counter(),
	RWROn = counter(),
	RWROff = counter(),
	RWRBrightnessIncrease = counter(),
	RWRBrightnessDecrease = counter(),
	RWRLoudnessIncrease = counter(),
	RWRLoudnessDecrease = counter(),

	DropFlare = counter(),
	FlareArmSafe = counter(),
	FlareArm = counter(),
	FlareSafe = counter(),
}

count = 3200
device_commands = { -- commands for lua
	intercom_switch11 = counter(),
	intercom_switch12 = counter(),
	intercom_switch13 = counter(),
	intercom_switch14 = counter(),
	intercom_switch1Int = counter(),
	intercom_switch1Nav = counter(),
	intercom_knob1vol = counter(),
	intercom_knob1select = counter(),
	intercom_switch21 = counter(),
	intercom_switch22 = counter(),
	intercom_switch23 = counter(),
	intercom_switch24 = counter(),
	intercom_switch2Int = counter(),
	intercom_switch2Nav = counter(),
	intercom_knob2vol = counter(),
	intercom_knob2select = counter(),

	weapon_arm = counter(),
	weapon_safe = counter(),
	weapon_mode = counter(),
	weapon_select = counter(),
	weapon_rocketpairs = counter(),
	weapon_jettison_cover = counter(),
	weapon_jettison = counter(),

	lightpanels_pos_light = counter(),
	lightpanels_anticol_light = counter(),
	lightpanels_light_panel = counter(),
	lightpanels_light_radio = counter(),
	lightpanels_light_engine = counter(),
	lightpanels_light_flight = counter(),

	avionic_baroAltPressure = counter(),

	anarc54_tune1 = counter(),
	anarc54_tune2 = counter(),
	anarc54_volume = counter(),
	anarc54_squelch = counter(),
	anarc54_mode = counter(),

	anarc51_channel = counter(),
	anarc51_switch = counter(),
	anarc51_volume = counter(),
	anarc51_selector2 = counter(),
	anarc51_selector1 = counter(),
	anarc51_tune1 = counter(),
	anarc51_tune2 = counter(),
	anarc51_tune3 = counter(),

	anarc83_loop = counter(),
	anarc83_switch = counter(),
	anarc83_power = counter(),
	anarc83_gain = counter(),
	anarc83_band = counter(),
	anarc83_tune = counter(),

	

	electricsystem_gyro = counter(),
	electricsystem_aux_tank = counter(),
	electricsystem_inverter = counter(),
	electricsystem_gen = counter(),
	electricsystem_fuel_pump = counter(),
	electricsystem_batt = counter(),
	fuelsystem_fuel_valve = counter(),

	engine_throttle = counter(),

	toggle_gunsight = counter(),

	RWROnOffSwitch = counter(),
	RWRBrightness = counter(),
	RWRLoudness = counter(),

	DropFlare = counter(),
	FlareArmSafe = counter(),
}


EFM_commands = -- commands for use in EFM (make sure to copy to inputs.h)
{
	starterButton            = 3014,
	govtrim                  = 3015,
	throttle                 = 3016,
	trimUp                   = 3017,
	trimDown                 = 3018,
	trimLeft                 = 3019,
	trimRight                = 3020,
	electricsystem_gyro      = 3021,
	electricsystem_aux_tank  = 3022,
	electricsystem_inverter  = 3023,
	electricsystem_gen       = 3024,
	electricsystem_fuel_pump = 3025,
	electricsystem_batt      = 3026,
	fuelsystem_fuel_valve    = 3027,
	collectiveUp             = 3028,
	collectiveDown           = 3029,
	joystickLeft             = 3030,
	joystickRight            = 3031,
	joystickUp               = 3032,
	joystickDown             = 3033,
	pedalLeft                = 3034,
	pedalRight               = 3035,

	logDataPoint             = 3100,
	startLateralFT           = 3101,
	startLongFT              = 3102,
	trimRelease              = 3103,
	trimReset                = 3104,
	trimReleaseRelease		 =3105,

	activateRotorBrake		=3106,
	deactivateRotorBrake	=3107,



}
