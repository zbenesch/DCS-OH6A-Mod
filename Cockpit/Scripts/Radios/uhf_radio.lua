dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local gettext = require("i_18n")
_ = gettext.translate

radio_type = 0

device_timer_dt = 0.2

frequency_dialer = {{143,20.0},{144,10.0},{145,10.0},{146,100.0}}

innerNoise 			= getInnerNoise(3E-6, 10)--V/m (dB S+N/N)
innerNoise_108_116_MHz_coeff = 1.2
frequency_accuracy 	= 2000.0			--Hz
band_width			= 19E3				--Hz (6 dB selectivity)
power 				= 10.0				--Wt

agr = {
	input_signal_deviation		= rangeUtoDb(4E-6, 0.5), --Db
	output_signal_deviation		= 5 - (-4),  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

GUI = {
	range = {min = 225E6, max = 399.95E6, step = 25E3}, --Hz
	displayName = _('VHF Radio KX 155'),
	AM = true,
	FM = false
}

need_to_be_closed = false -- close lua state after initialization