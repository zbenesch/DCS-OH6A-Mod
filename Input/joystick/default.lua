local cockpit = folder.."../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

local kneeboard_id = 100
if devices and devices.KNEEBOARD then
   kneeboard_id = devices.KNEEBOARD
end

return {

forceFeedback = {
    trimmer = 1.0,
    shake = 0.5,
    swapAxes = false,
    invertX = false,
    invertY = false,
},

keyCommands = {

-- Systems

	--{down = Keys.LogDataPoint, name = _('Log Single Data Point'), category = _('Systems')}, 
    {down = Keys.ToggleDoors, name = _('Open/close Door'), category = _('Systems')}, 
	
	--{down = Keys.StartLateralFT, name = _('Lateral dynamic'), category = _('Flighttests')}, 
	--{down = Keys.StartLongFT, name = _('Longitudinal dynamic'), category = _('Flighttests')}, 
	
	{down = Keys.DropGrenade, name = _('Drop Grenade'), category = _('Weapons')}, 
	{down = Keys.SwitchGrenadeColor, name = _('Switch Color'), category = _('Weapons')}, 

    {down = Keys.BattSwitchBatt, name = _('Battery Switch BAT'), category = _('Systems')},
    {down = Keys.BattSwitchOff, name = _('Battery Switch OFF'), category = _('Systems')},
	{down = Keys.BattSwitchExt, name = _('Battery Switch EXT'), category = _('Systems')},

    {down = Keys.gen_on, name = _('Generator On'), category = _('Systems')},
    {down = Keys.gen_off, name = _('Generator Off'), category = _('Systems')},
    {down = Keys.gen_toggle, name = _('Generator Toggle'), category = _('Systems')},

    {down = Keys.inverter_on, name = _('Inverter On'), category = _('Systems')},
    {down = Keys.inverter_off, name = _('Inverter Off'), category = _('Systems')},
    {down = Keys.inverter_toggle, name = _('Inverter Toggle'), category = _('Systems')},

    {down = Keys.fuel_valve_on, name = _('Fuel Valve Open'), category = _('Systems')},
    {down = Keys.fuel_valve_off, name = _('Fuel Valve Close'), category = _('Systems')},
    {down = Keys.fuel_valve_toggle, name = _('Fuel Valve Toggle'), category = _('Systems')},

    {down = Keys.gyro_mag, name = _('Gyro On'), category = _('Systems')},
    {down = Keys.gyro_dir, name = _('Gyro Off'), category = _('Systems')},
    {down = Keys.gyro_toggle, name = _('Gyro Toggle'), category = _('Systems')},

    {down = Keys.inc_intercom_select, name = _('Intercom Channel Increase'), category = _('Communications')},
    {down = Keys.dec_intercom_select, name = _('Intercom Channel Decrease'), category = _('Communications')},

    {down = Keys.anarc_51_inc_channel, name = _('An/Arc-51 Channel Increase'), category = _('Communications')},
    {down = Keys.anarc_51_dec_channel, name = _('An/Arc-51 Channel Decrease'), category = _('Communications')},
    {down = Keys.anarc_51_inc_tune1, name = _('An/Arc-51 Ten Mega Cycles Increase'), category = _('Communications')},
    {down = Keys.anarc_51_dec_tune1, name = _('An/Arc-51 Ten Mega Cycles Decrease'), category = _('Communications')},
    {down = Keys.anarc_51_inc_tune2, name = _('An/Arc-51 Mega Cycles Increase'), category = _('Communications')},
    {down = Keys.anarc_51_dec_tune2, name = _('An/Arc-51 Mega Cycles Decrease'), category = _('Communications')},
    {down = Keys.anarc_51_inc_tune3, name = _('An/Arc-51 Deci Mega Cycles Increase'), category = _('Communications')},
    {down = Keys.anarc_51_dec_tune3, name = _('An/Arc-51 Deci Mega Cycles Decrease'), category = _('Communications')},
    {pressed = Keys.anarc_51_inc_vol, name = _('An/Arc-51 Volume Increase'), category = _('Communications')},
    {pressed = Keys.anarc_51_dec_vol, name = _('An/Arc-51 Volume Decrease'), category = _('Communications')},
    {down = Keys.anarc_51_preset, name = _('An/Arc-51 Preset Frequency'), category = _('Communications')},
    {down = Keys.anarc_51_manual, name = _('An/Arc-51 Tuned Frequency'), category = _('Communications')},
    {down = Keys.anarc_51_mode_up, name = _('An/Arc-51 Mode Up'), category = _('Communications')},
    {down = Keys.anarc_51_mode_down, name = _('An/Arc-51 Mode Down'), category = _('Communications')},

    {down = Keys.anarc_54_inc_tune1, name = _('An/Arc-54 Mega Cycles Increase'), category = _('Communications')},
    {down = Keys.anarc_54_dec_tune1, name = _('An/Arc-54 Mega Cycles Decrease'), category = _('Communications')},
    {down = Keys.anarc_54_inc_tune2, name = _('An/Arc-54 Deci Mega Cycles Increase'), category = _('Communications')},
    {down = Keys.anarc_54_dec_tune2, name = _('An/Arc-54 Deci Mega Cycles Decrease'), category = _('Communications')},
    {down = Keys.anarc_54_mode_up, name = _('An/Arc-54 Mode Up'), category = _('Communications')},
    {down = Keys.anarc_54_mode_down, name = _('An/Arc-54 Mode Down'), category = _('Communications')},
    {pressed = Keys.anarc_54_inc_vol, name = _('An/Arc-54 Volume Increase'), category = _('Communications')},
    {pressed = Keys.anarc_54_dec_vol, name = _('An/Arc-54 Volume Decrease'), category = _('Communications')},



    {down = Keys.ThrottleIdle, name = _('Throttle Idle'), category = _('Systems')},
	{down = Keys.ThrottleCutoff, name = _('Throttle Cutoff'), category = _('Systems')},	
	{pressed = Keys.ThrottleIncrease, up = Keys.ThrottleStop,  name = _('Throttle Up'), category = _('Systems')},
	{pressed = Keys.ThrottleDecrease, up = Keys.ThrottleStop,  name = _('Throttle Down'), category = _('Systems')},
	
	{down = EFM_commands.collectiveUp,     up = EFM_commands.collectiveUp,   value_up =0.0,value_down = 1.0,name = _('Collective up'), category = _('Systems')},
    {down = EFM_commands.collectiveDown,   up = EFM_commands.collectiveDown, value_up =0.0,value_down = 1.0,name = _('Collective down'), category = _('Systems')},
    {down = EFM_commands.joystickUp,       up = EFM_commands.joystickUp,     value_up =0.0,value_down = 1.0,name = _('Cyclic up'), category = _('Systems')},
    {down = EFM_commands.joystickDown,     up = EFM_commands.joystickDown,   value_up =0.0,value_down = 1.0,name = _('Cyclic down'), category = _('Systems')},
    {down = EFM_commands.joystickLeft,     up = EFM_commands.joystickLeft,   value_up =0.0,value_down = 1.0,name = _('Cyclic left'), category = _('Systems')},
    {down = EFM_commands.joystickRight,    up = EFM_commands.joystickRight,  value_up =0.0,value_down = 1.0,name = _('Cyclic right'), category = _('Systems')},
    {down = EFM_commands.pedalLeft,        up = EFM_commands.pedalLeft,      value_up =0.0,value_down = 1.0,name = _('Pedals left'), category = _('Systems')},
    {down = EFM_commands.pedalRight,       up = EFM_commands.pedalRight,     value_up =0.0,value_down = 1.0,name = _('Pedals right'), category = _('Systems')},

		
	{pressed =  Keys.StarterButton, up = Keys.StarterButtonRelease,  name = _('Starter Button'), category = _('Systems')},
	
	{pressed =  Keys.GovTrimUp, up = Keys.GovTrimUp,  name = _('Govenor Trim up'), category = _('Systems')},
	{pressed =  Keys.GovTrimDown, up = Keys.GovTrimDown,  name = _('Govenor Trim down'), category = _('Systems')},
	
	{pressed = EFM_commands.trimUp, name = _('Cyclic Trim Up'), category = _('Systems')},
	{pressed = EFM_commands.trimDown, name = _('Cyclic Trim Down'), category = _('Systems')},
	{pressed = EFM_commands.trimLeft, name = _('Cyclic Trim Left'), category = _('Systems')},
	{pressed = EFM_commands.trimRight, name = _('Cyclic Trim Right'), category = _('Systems')},
    {down = EFM_commands.trimRelease, up = EFM_commands.trimReleaseRelease, name = _('Cyclic Trim Release'), category = _('Systems')},
    {down = EFM_commands.trimReset, name = _('Cyclic Trim Reset'), category = _('Systems')},
	
	{down = Keys.FireOn, up = Keys.FireOff, name = _('Gun Fire'), category = _('Weapons')},
    
    {down = Keys.weapon_select_gun, name = _('Select Gun'), category = _('Weapons')},
    {down = Keys.weapon_select_rockets, name = _('Select Rockets'), category = _('Weapons')},

    {down = Keys.Master_arm_on, name = _('Master Arm On'), category = _('Weapons')},
    {down = Keys.Master_arm_off, name = _('Master Arm Off'), category = _('Weapons')},
    {down = Keys.Master_arm_toggle, name = _('Master Arm Toggle'), category = _('Weapons')},

    {down = Keys.weapon_mode_off, name = _('Weapon Mode Off'), category = _('Weapons')},
    {down = Keys.weapon_mode_toclear, name = _('Weapon Mode Fire to clear'), category = _('Weapons')},
    {down = Keys.weapon_mode_normal, name = _('Weapon Mode Normal'), category = _('Weapons')},
    {down = Keys.weapon_mode_toggle, name = _('Weapon Mode Toggle'), category = _('Weapons')},

    {down = Keys.increase_salvo_length, name = _('Increase Rocket Salvo Length'), category = _('Weapons')},
    {down = Keys.decrease_salvo_length, name = _('Decrease Rocket Salvo Length'), category = _('Weapons')},

    {down = Keys.jettison_cover, name = _('Toggle Jettison Cover'), category = _('Weapons')},
    {down = Keys.jettison, name = _('Jettison'), category = _('Weapons')},

	{pressed = Keys.GunUp, name = _('Gun Up'), category = _('Weapons')},
	{pressed = Keys.GunDown, name = _('Gun Down'), category = _('Weapons')},

    {down = Keys.toggle_gunsight, name = _('Toggle Gunsight'), category = _('Weapons')},
    {pressed = Keys.gunsight_up, name = _('Gunsight Up'), category = _('Weapons')},
    {pressed = Keys.gunsight_down, name = _('Gunsight Down'), category = _('Weapons')},
    {pressed = Keys.sight_brightness_inc, name = _('Gunsight Brightness Increase'), category = _('Weapons')},
    {pressed = Keys.sight_brightness_dec, name = _('Gunsight Brightness Decrease'), category = _('Weapons')},
    

-- lights
    {down = Keys.LandingLight, name = _('Landing/Hover Light'), category = _('Systems')},
    {down = Keys.SearchLight, name = _('Search Light'), category = _('Systems')},
    {down = Keys.SearchLightMode, name = _('Toggle Searchlight Mode'), category = _('Systems')},
    {down = Keys.SearchLightUp, up = Keys.SearchLightUpDownRelease, name = _('Searchlight Up'), category = _('Systems')},
    {down = Keys.SearchLightDown, up = Keys.SearchLightUpDownRelease, name = _('Searchlight Down'), category = _('Systems')},
    {down = Keys.SearchLightLeft, up = Keys.SearchLightLeftRightRelease, name = _('Searchlight Left'), category = _('Systems')},
    {down = Keys.SearchLightRight, up = Keys.SearchLightLeftRightRelease, name = _('Searchlight Right'), category = _('Systems')},
	{down = Keys.SearchLightLock, name = _('Searchlight Lock'), category = _('Systems')},

    {down = Keys.roe,  name = _('Toggle Door Gunner ROE'), category = _('Weapons')},
    {down = Keys.toggle_burst_length,  name = _('Toggle Door Gunner Burst Lenght'), category = _('Weapons')},
    {down = Keys.toggle_crew_gui,  name = _('Toggle Crew Status'), category = _('Weapons')},

    {pressed = Keys.inc_light_engine, name = _('Light Engine Increase'), category = _('Lights')},
    {pressed = Keys.dec_light_engine, name = _('Light Engine Decrease'), category = _('Lights')},
    {pressed = Keys.inc_light_panel, name = _('Light Panel Increase'), category = _('Lights')},
    {pressed = Keys.dec_light_panel, name = _('Light Panel Decrease'), category = _('Lights')},
    {pressed = Keys.inc_light_radio, name = _('Light Radio Increase'), category = _('Lights')},
    {pressed = Keys.dec_light_radio, name = _('Light Radio Decrease'), category = _('Lights')},
    {pressed = Keys.inc_light_flight, name = _('Light Flight Increase'), category = _('Lights')},
    {pressed = Keys.dec_light_flight, name = _('Light Flight Decrease'), category = _('Lights')},

    {down = Keys.pos_light_off, name = _('Positions Lights Off'), category = _('Lights')},
    {down = Keys.pos_light_dim, name = _('Positions Lights Dim'), category = _('Lights')},
    {down = Keys.pos_light_bright, name = _('Positions Lights Bright'), category = _('Lights')},
    {down = Keys.acol_light_off, name = _('Anticollision Lights Off'), category = _('Lights')},
    {down = Keys.acol_light_on, name = _('Anticollision Lights On'), category = _('Lights')},

    {down = iCommandCockpitClickModeOnOff, name = _('Clickable mouse cockpit mode On/Off'), category = _('General')},

    -- Night Vision Goggles
	{down = iCommandViewNightVisionGogglesOn,	 name = _('Toggle Night Vision Goggles'), 	category = _('NVG')},
	{pressed = iCommandPlane_Helmet_Brightess_Up  , name = _('Gain NVG up')  , category = _('NVG')},
	{pressed = iCommandPlane_Helmet_Brightess_Down, name = _('Gain NVG down'), category = _('NVG')},

-- Multicrew
	{down = iCommandViewCockpitChangeSeat, value_down = 1, name = _('Occupy Pilot Seat'),	category = _('Crew Control')},
	{down = iCommandViewCockpitChangeSeat, value_down = 2, name = _('Occupy Copilot Seat'),	category = _('Crew Control')},	
	{down = iCommandNetCrewRequestControl,	name = _('Request Aircraft Control'),category = _('Crew Control')},
	
	--{combos = {{key = 'P', reformers = {'RShift'}}}, down = iCommandCockpitShowPilotOnOff, name = _('Show Pilot Body'), category = _('General')},

    {down = Keys.showControlInd, name = _('Show controls indicator'), category = _('General')},


    -- Communications
    {down = Keys.ptt, up = Keys.ptt, value_up =0.0,value_down = 1.0,name = _('PTT'), category = _('Communications')},
    {down = Keys.ptt_voice,up = Keys.ptt_voice, value_up =0.0,value_down = 1.0, name = _('PTT VOICE'), category = _('Communications')},


    {down = iCommandToggleCommandMenu,name = _('Communication menu'),category = _('Communications')},
    {down = ICommandSwitchDialog,				name = _('Switch dialog'),						  category = _('Communications')},
    {down = ICommandSwitchToCommonDialog,		name = _('Switch to main menu'),				  category = _('Communications')},
	--{combos = {{key = '\\', reformers = {'RShift'}}, {key = 'M', reformers = {'RShift'}}}, down = iCommandToggleReceiveMode, name = _('Receive Mode'), category = _('Communications')},

    -- View
    {pressed = iCommandViewLeftSlow,		 up = iCommandViewStopSlow, name = _('View Left slow'),		  category = _('View')},
    {pressed = iCommandViewRightSlow,	 up = iCommandViewStopSlow, name = _('View Right slow'),	  category = _('View')},
    {pressed = iCommandViewUpSlow,		 up = iCommandViewStopSlow, name = _('View Up slow'),		  category = _('View')},
    {pressed = iCommandViewDownSlow,		 up = iCommandViewStopSlow, name = _('View Down slow'),		  category = _('View')},
    {pressed = iCommandViewUpRightSlow,	 up = iCommandViewStopSlow, name = _('View Up Right slow'),	  category = _('View')},
    {pressed = iCommandViewDownRightSlow, up = iCommandViewStopSlow, name = _('View Down Right slow'), category = _('View')},
    {pressed = iCommandViewDownLeftSlow,	 up = iCommandViewStopSlow, name = _('View Down Left slow'),  category = _('View')},
    {pressed = iCommandViewUpLeftSlow,	 up = iCommandViewStopSlow, name = _('View Up Left slow'),	  category = _('View')},
    {pressed = iCommandViewCenter,		 							name = _('View Center'),		  category = _('View')},

    {pressed = iCommandViewForwardSlow, up = iCommandViewForwardSlowStop, name = _('Zoom in slow'), category = _('View')},
    {pressed = iCommandViewBackSlow, up = iCommandViewBackSlowStop, name = _('Zoom out slow'), category = _('View')},
    {down = iCommandViewAngleDefault, name = _('Zoom normal'), category = _('View')},
    {pressed = iCommandViewExternalZoomIn, up = iCommandViewExternalZoomInStop, name = _('Zoom external in'), category = _('View')},
    {pressed = iCommandViewExternalZoomOut, up = iCommandViewExternalZoomOutStop, name = _('Zoom external out'), category = _('View')},
    {down = iCommandViewExternalZoomDefault, name = _('Zoom external normal'), category = _('View')},
    {down = iCommandViewSpeedUp, name = _('F11 Camera moving forward'), category = _('View')},
    {down = iCommandViewSlowDown, name = _('F11 Camera moving backward'), category = _('View')},

    {down = iCommandMissionResourcesManagement,		name = _('Rearming and Refueling Window'),		 category = _('General')},
    {down = iCommandSoundOnOff,	name = _('Sound On/Off'), category = _('General')},
    {down = iCommandPlaneEject,	name = _('Eject (3 times)'), category = _('Systems')},

{down = iCommandViewCockpit, name = _('F1 Cockpit view'), category = _('View')},
{down = iCommandNaturalViewCockpitIn, name = _('F1 Natural head movement view'), category = _('View')},
{down = iCommandViewHUDOnlyOnOff, name = _('F1 HUD only view switch'), category = _('View')},
{down = iCommandViewAir, name = _('F2 Aircraft view'), category = _('View')},
{down = iCommandViewMe, name = _('F2 View own aircraft'), category = _('View')},
{down = iCommandViewFromTo, name = _('F2 Toggle camera position'), category = _('View')},
{down = iCommandViewLocal, name = _('F2 Toggle local camera control'), category = _('View')},
{down = iCommandViewTower, name = _('F3 Fly-By view'), category = _('View')},
{down = iCommandViewTowerJump, name = _('F3 Fly-By jump view'), category = _('View')},
{down = iCommandViewRear, name = _('F4 Camera mounted on object'), category = _('View')},
{down = iCommandViewChase, name = _('F4 Chase view'), category = _('View')},
{down = iCommandViewChaseArcade, name = _('F4 Arcade Chase view'), category = _('View')},
{down = iCommandViewFight, name = _('F5 Nearest AC view'), category = _('View')},
{down = iCommandViewFightGround, name = _('F5 Ground hostile view'), category = _('View')},
{down = iCommandViewWeapons, name = _('F6 Released weapon view'), category = _('View')},
{down = iCommandViewWeaponAndTarget, name = _('F6 Weapon to target view'), category = _('View')},
{down = iCommandViewGround, name = _('F7 Ground unit view'), category = _('View')},
{down = iCommandViewNavy, name = _('F9 Ship view'), category = _('View')},
{down = iCommandViewLndgOfficer, name = _('F9 Landing signal officer view'), category = _('View')},
{down = iCommandViewAWACS, name = _('F10 Theater map view'), category = _('View')},
{down = iCommandViewAWACSJump, name = _('F10 Jump to theater map view over current point'), category = _('View')},
{down = iCommandViewFree, name = _('F11 Airport free camera'), category = _('View')},
{down = iCommandViewFreeJump, name = _('F11 Jump to free camera'), category = _('View')},
{down = iCommandViewStatic, name = _('F12 Static object view'), category = _('View')},
{down = iCommandViewMirage, name = _('F12 Civil traffic view'), category = _('View')},
{down = iCommandViewLocomotivesToggle, name = _('F12 Trains/cars toggle'), category = _('View')},

{down = iCommandViewFastKeyboard, name = _('Camera view keyboard rate fast'), category = _('View')},
{down = iCommandViewSlowKeyboard, name = _('Camera view keyboard rate slow'), category = _('View')},
{down = iCommandViewNormalKeyboard, name = _('Camera view keyboard rate normal'), category = _('View')},
{down = iCommandViewFastMouse, name = _('Camera view mouse rate fast'), category = _('View')},
{down = iCommandViewSlowMouse, name = _('Camera view mouse rate slow'), category = _('View')},
{down = iCommandViewNormalMouse, name = _('Camera view mouse rate normal'), category = _('View')},

    -- Cockpit view
    {down = iCommandViewTempCockpitOn, up = iCommandViewTempCockpitOff, name = _('Cockpit panel view in'), category = _('View Cockpit')},
    {down = iCommandViewTempCockpitToggle, name = _('Cockpit panel view toggle'), category = _('View Cockpit')},
    --// Save current cockpit camera angles for fast numpad jumps  
    {down = iCommandViewSaveAngles, name = _('Save Cockpit Angles'), category = _('View Cockpit')},
    {pressed = iCommandViewUp, up = iCommandViewStop, name = _('View up'), category = _('View Cockpit')},
    {pressed = iCommandViewDown, up = iCommandViewStop, name = _('View down'), category = _('View Cockpit')},
    {pressed = iCommandViewLeft, up = iCommandViewStop, name = _('View left'), category = _('View Cockpit')},
    {pressed = iCommandViewRight, up = iCommandViewStop, name = _('View right'), category = _('View Cockpit')},
    {pressed = iCommandViewUpRight, up = iCommandViewStop, name = _('View up right'), category = _('View Cockpit')},
    {pressed = iCommandViewDownRight, up = iCommandViewStop, name = _('View down right'), category = _('View Cockpit')},
    {pressed = iCommandViewDownLeft, up = iCommandViewStop, name = _('View down left'), category = _('View Cockpit')},
    {pressed = iCommandViewUpLeft, up = iCommandViewStop, name = _('View up left'), category = _('View Cockpit')},

    -- Cockpit Camera Motion
    {pressed = iCommandViewPitCameraMoveUp, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Up'), category = _('View Cockpit')},
    {pressed = iCommandViewPitCameraMoveDown, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Down'), category = _('View Cockpit')},
    {pressed = iCommandViewPitCameraMoveLeft, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Left'), category = _('View Cockpit')},
    {pressed = iCommandViewPitCameraMoveRight, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Right'), category = _('View Cockpit')},
    {pressed = iCommandViewPitCameraMoveForward, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Forward'), category = _('View Cockpit')},
    {pressed = iCommandViewPitCameraMoveBack, up = iCommandViewPitCameraMoveStop, name = _('Cockpit Camera Move Back'), category = _('View Cockpit')},
    {down = iCommandViewPitCameraMoveCenter, name = _('Cockpit Camera Move Center'), category = _('View Cockpit')},

    {down = iCommandViewCameraUp, up = iCommandViewCameraCenter, name = _('Glance up'), category = _('View Cockpit')},
    {down = iCommandViewCameraDown, up = iCommandViewCameraCenter, name = _('Glance down'), category = _('View Cockpit')},
    {down = iCommandViewCameraLeft, up = iCommandViewCameraCenter, name = _('Glance left'), category = _('View Cockpit')},
    {down = iCommandViewCameraRight, up = iCommandViewCameraCenter, name = _('Glance right'), category = _('View Cockpit')},
    {down = iCommandViewCameraUpLeft, up = iCommandViewCameraCenter, name = _('Glance up-left'), category = _('View Cockpit')},
    {down = iCommandViewCameraDownLeft, up = iCommandViewCameraCenter, name = _('Glance down-left'), category = _('View Cockpit')},
    {down = iCommandViewCameraUpRight, up = iCommandViewCameraCenter, name = _('Glance up-right'), category = _('View Cockpit')},
    {down = iCommandViewCameraDownRight, up = iCommandViewCameraCenter, name = _('Glance down-right'), category = _('View Cockpit')},
    {down = iCommandViewPanToggle, name = _('Camera pan mode toggle'), category = _('View Cockpit')},

    {down = iCommandViewCameraUpSlow, name = _('Camera snap view up'), category = _('View Cockpit')},
    {down = iCommandViewCameraDownSlow, name = _('Camera snap view down'), category = _('View Cockpit')},
    {down = iCommandViewCameraLeftSlow, name = _('Camera snap view left'), category = _('View Cockpit')},
    {down = iCommandViewCameraRightSlow, name = _('Camera snap view right'), category = _('View Cockpit')},
    {down = iCommandViewCameraUpLeftSlow, name = _('Camera snap view up-left'), category = _('View Cockpit')},
    {down = iCommandViewCameraDownLeftSlow, name = _('Camera snap view down-left'), category = _('View Cockpit')},
    {down = iCommandViewCameraUpRightSlow, name = _('Camera snap view up-right'), category = _('View Cockpit')},
    {down = iCommandViewCameraDownRightSlow, name = _('Camera snap view down-right'), category = _('View Cockpit')},
    {down = iCommandViewCameraCenter, name = _('Center Camera View'), category = _('View Cockpit')},
    {down = iCommandViewCameraReturn, name = _('Return Camera'), category = _('View Cockpit')},
    {down = iCommandViewCameraBaseReturn, name = _('Return Camera Base'), category = _('View Cockpit')},

    {down = iCommandViewSnapView0,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  0'), category = _('View Cockpit')},
    {down = iCommandViewSnapView1,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  1'), category = _('View Cockpit')},
    {down = iCommandViewSnapView2,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  2'), category = _('View Cockpit')},
    {down = iCommandViewSnapView3,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  3'), category = _('View Cockpit')},
    {down = iCommandViewSnapView4,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  4'), category = _('View Cockpit')},
    {down = iCommandViewSnapView5,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  5'), category = _('View Cockpit')},
    {down = iCommandViewSnapView6,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  6'), category = _('View Cockpit')},
    {down = iCommandViewSnapView7,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  7'), category = _('View Cockpit')},
    {down = iCommandViewSnapView8,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  8'), category = _('View Cockpit')},
    {down = iCommandViewSnapView9,	up = iCommandViewSnapViewStop, name = _('Custom Snap View  9'), category = _('View Cockpit')},

    {pressed = iCommandViewForward, up = iCommandViewForwardStop, name = _('Zoom in'), category = _('View Cockpit')},
    {pressed = iCommandViewBack, up = iCommandViewBackStop, name = _('Zoom out'), category = _('View Cockpit')},

    -- Extended view
    {down = iCommandViewCameraJiggle, name = _('Camera jiggle toggle'), category = _('View Extended')},
    {down = iCommandViewKeepTerrain, name = _('Keep terrain camera altitude'), category = _('View Extended')},
    {down = iCommandViewFriends, name = _('View friends mode'), category = _('View Extended')},
    {down = iCommandViewEnemies, name = _('View enemies mode'), category = _('View Extended')},
    {down = iCommandViewAll, name = _('View all mode'), category = _('View Extended')},
    {down = iCommandViewPlus, name = _('Toggle tracking launched weapon'), category = _('View Extended')},
    {down = iCommandViewSwitchForward, name = _('Objects switching direction forward '), category = _('View Extended')},
    {down = iCommandViewSwitchReverse, name = _('Objects switching direction reverse '), category = _('View Extended')},
    {down = iCommandViewObjectIgnore, name = _('Object exclude '), category = _('View Extended')},
    {down = iCommandViewObjectsAll, name = _('Objects all excluded - include'), category = _('View Extended')},

    -- Padlock
    {down = iCommandViewLock, name = _('Lock View (cycle padlock)'), category = _('View Padlock')},
    {down = iCommandViewUnlock, name = _('Unlock view (stop padlock)'), category = _('View Padlock')},
    {down = iCommandAllMissilePadlock, name = _('All missiles padlock'), category = _('View Padlock')},
    {down = iCommandThreatMissilePadlock, name = _('Threat missile padlock'), category = _('View Padlock')},
    {down = iCommandViewTerrainLock, name = _('Lock terrain view'), category = _('View Padlock')},

    -- Labels
    {down = iCommandMarkerState, name = _('All Labels'), category = _('Labels')},
    {down = iCommandMarkerStatePlane, name = _('Aircraft Labels'), category = _('Labels')},
    {down = iCommandMarkerStateRocket, name = _('Missile Labels'), category = _('Labels')},
    {down = iCommandMarkerStateShip, name = _('Vehicle & Ship Labels'), category = _('Labels')},

    --Kneeboard
    {down = iCommandPlaneShowKneeboard	, name = _('Kneeboard ON/OFF'), category = _('Kneeboard')},
    {down = iCommandPlaneShowKneeboard	, up = iCommandPlaneShowKneeboard ,value_down = 1.0,value_up = -1.0, name = _('Kneeboard glance view')  , category = _('Kneeboard')},
    {down = 3001		, cockpit_device_id  = kneeboard_id, value_down = 1.0, name = _('Kneeboard Next Page')  , category = _('Kneeboard')},
    {down = 3002		, cockpit_device_id  = kneeboard_id, value_down = 1.0, name = _('Kneeboard Previous Page'), category = _('Kneeboard')},
    {down = 3003		, cockpit_device_id  = kneeboard_id,value_down = 1.0, name = _('Kneeboard current position mark point')  , category = _('Kneeboard')},
    --shortcuts navigation
    {down = 3004		, cockpit_device_id  = kneeboard_id,value_down =  1.0, name = _('Kneeboard Make Shortcut'), category = _('Kneeboard')},
    {down = 3005		, cockpit_device_id  = kneeboard_id,value_down =  1.0, name = _('Kneeboard Next Shortcut'), category = _('Kneeboard')},
    {down = 3005		, cockpit_device_id  = kneeboard_id,value_down = -1.0, name = _('Kneeboard Previous Shortcut')  , category = _('Kneeboard')},
    {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 0   , name = _('Kneeboard Jump To Shortcut  1'), category = _('Kneeboard')},
    {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 1   , name = _('Kneeboard Jump To Shortcut  2'), category = _('Kneeboard')},
    {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 2   , name = _('Kneeboard Jump To Shortcut  3'), category = _('Kneeboard')},
    {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 3   , name = _('Kneeboard Jump To Shortcut  4'), category = _('Kneeboard')},
    {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 4   , name = _('Kneeboard Jump To Shortcut  5'), category = _('Kneeboard')},
    {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 5   , name = _('Kneeboard Jump To Shortcut  6'), category = _('Kneeboard')},
    {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 6   , name = _('Kneeboard Jump To Shortcut  7'), category = _('Kneeboard')},
    {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 7   , name = _('Kneeboard Jump To Shortcut  8'), category = _('Kneeboard')},
    {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 8   , name = _('Kneeboard Jump To Shortcut  9'), category = _('Kneeboard')},
    {down = 3006		, cockpit_device_id  = kneeboard_id,value_down = 9   , name = _('Kneeboard Jump To Shortcut 10'), category = _('Kneeboard')},
    {down = iCommandViewBriefing, name = _('Briefing window'), category = _('General')},
    {down = iCommandChatShowHide, name = _('Chat show/hide'), category = _('General')},
    {down = iCommandViewPitHeadOnOff, name = _('F1 Head shift movement on / off'), category = _('View')},
    {down = iCommandInfoOnOff, name = _('Info bar view toggle'), category = _('General')},
    {down = 3256,    cockpit_device_id = 0,    value_down = 1.0, name = _('Flashlight'), category = _('View Cockpit')},
    -- SunVisor Tanuki44
	{down = Keys.sunVisorToggle, name = _('SunVisor UP/DOWN'), category = _('General')},

    {down = EFM_commands.activateRotorBrake, name = _('Rotorbrake on'), category = _('Systems')},
    {down = EFM_commands.deactivateRotorBrake, name = _('Rotorbrake off'), category = _('Systems')},

    {down = Keys.anarc_83_mode_up, name = _('An/Arc-83 Mode Up'), category = _('Communications')},
    {down = Keys.anarc_83_mode_down, name = _('An/Arc-83 Mode Down'), category = _('Communications')},
    {down = Keys.anarc_83_band_up, name = _('An/Arc-83 Band Up'), category = _('Communications')},
    {down = Keys.anarc_83_band_down, name = _('An/Arc-83 Band Down'), category = _('Communications')},

    {pressed = Keys.anarc_83_tune_up, name = _('An/Arc-83 Tune Increase'), category = _('Communications')},
    {pressed = Keys.anarc_83_tune_down, name = _('An/Arc-83 Tune Decrease'), category = _('Communications')},
    {pressed = Keys.anarc_83_gain_up, name = _('An/Arc-83 Gain Increase'), category = _('Communications')},
    {pressed = Keys.anarc_83_gain_down, name = _('An/Arc-83 Gain Decrease'), category = _('Communications')},

    {down = Keys.RWROnOffSwitch, name = _('RWR Power toggle'), category = _('Systems')},
    {down = Keys.RWROn, name = _('RWR Power On'), category = _('Systems')},
    {down = Keys.RWROff, name = _('RWR Power Off'), category = _('Systems')},
    {pressed = Keys.RWRLoudnessIncrease, name = _('RWR Loudness Increase'), category = _('Systems')},
    {pressed = Keys.RWRLoudnessDecrease, name = _('RWR Loudness Decrease'), category = _('Systems')},
    {pressed = Keys.RWRBrightnessIncrease, name = _('RWR Brightness Increase'), category = _('Systems')},
    {pressed = Keys.RWRBrightnessDecrease, name = _('RWR Brightness Decrease'), category = _('Systems')},

    {down = Keys.DropFlare,up = Keys.DropFlare,value_up = 0.0,value_down = 1.0, name = _('Flares/Chaffs Dispense'), category = _('Weapons')},
    {down = Keys.FlareArmSafe, name = _('Flares/Chaffs Arm/Safe'), category = _('Weapons')},
    {down = Keys.FlareArm, name = _('Flares/Chaffs Arm'), category = _('Weapons')},
    {down = Keys.FlareSafe, name = _('Flares/Chaffs Safe'), category = _('Weapons')},
},

-- joystick axis 
axisCommands = {
    {action = iCommandViewHorizontalAbs			, name = _('Absolute Camera Horizontal View')},
    {action = iCommandViewVerticalAbs			, name = _('Absolute Camera Vertical View')},
    {action = iCommandViewZoomAbs				, name = _('Zoom View')},
    {action = iCommandViewRollAbs 				, name = _('Absolute Roll Shift Camera View')},
    {action = iCommandViewHorTransAbs 			, name = _('Absolute Horizontal Shift Camera View')},
    {action = iCommandViewVertTransAbs 			, name = _('Absolute Vertical Shift Camera View')},
    {action = iCommandViewLongitudeTransAbs 	, name = _('Absolute Longitude Shift Camera View')},
	
{combos = defaultDeviceAssignmentFor("roll")	, action = iCommandPlaneRoll,			name = _('Roll Cyclic')},
{combos = defaultDeviceAssignmentFor("pitch")	, action = iCommandPlanePitch,			name = _('Pitch Cyclic')},
{combos = defaultDeviceAssignmentFor("rudder")	, action = iCommandPlaneRudder, 		name = _('Pedals')},
{combos = defaultDeviceAssignmentFor("thrust")	, action = iCommandPlaneThrustCommon,	name = _('Collective')},
{combos = defaultDeviceAssignmentFor("throttle"), action = Keys.throttleAxis,	name = _('Throttle')},
{combos = defaultDeviceAssignmentFor("searchlightXAxis"), action = Keys.SearchlightXAxis,	name = _('Searchlight Left/Right')},
{combos = defaultDeviceAssignmentFor("searchlightYAxis"), action = Keys.SearchlightYAxis,	name = _('Searchlight Up/Down')},

},

}
