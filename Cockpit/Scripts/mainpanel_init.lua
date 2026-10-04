shape_name  	 			 = "cockpit_oh-6a"
draw_pilot					 = false

day_texture_set_value   = 0.0
night_texture_set_value = 0.1
dusk_border					 = 0.4


external_model_canopy_arg	 = 38
--render_debug_info = false

local controllers = LoRegisterPanelControls()

Pedals			= CreateGauge("parameter")
Pedals.arg_number	= 213
Pedals.input		= {-1, 1}
Pedals.output		= {-1, 1}
Pedals.parameter_name= "PEDALS_COCKPIT"

Cyclic_pitch			= CreateGauge("parameter")
Cyclic_pitch.arg_number	= 214
Cyclic_pitch.input		= {-1, 1}
Cyclic_pitch.output		= {-1, 1}
Cyclic_pitch.parameter_name= "CYCLIC_PITCH_COCKPIT"

Cyclic_roll			= CreateGauge("parameter")
Cyclic_roll.arg_number	= 215
Cyclic_roll.input		= {-1, 1}
Cyclic_roll.output		= {-1, 1}
Cyclic_roll.parameter_name= "CYCLIC_ROLL_COCKPIT"

Collective_pitch			= CreateGauge("parameter")
Collective_pitch.arg_number	= 210
Collective_pitch.input		= {0, 1}
Collective_pitch.output		= {0, 1}
Collective_pitch.parameter_name= "COLLECTIVE_COCKPIT"

Collective_throttle			= CreateGauge("parameter")
Collective_throttle.arg_number	= 211
Collective_throttle.input		= {0, 1}
Collective_throttle.output		= {0, 1}
Collective_throttle.parameter_name= "COLLECTIVE_THROTTLE"

Collective_idle			= CreateGauge("parameter")
Collective_idle.arg_number	= 212
Collective_idle.input		= {0, 1}
Collective_idle.output		= {0, 1}
Collective_idle.parameter_name= "COLLECTIVE_IDLE"


Throttle			= CreateGauge("parameter")
Throttle.arg_number	= 4
Throttle.input		= {0, 1}
Throttle.output		= {0, 1}
Throttle.parameter_name= "THROTTLE"

G1_color			= CreateGauge("parameter")
G1_color.arg_number	= 400
G1_color.input		= {0, 1}
G1_color.output		= {0, 1}
G1_color.parameter_name= "G1_color"

G2_color			= CreateGauge("parameter")
G2_color.arg_number	= 402
G2_color.input		= {0, 1}
G2_color.output		= {0, 1}
G2_color.parameter_name= "G2_color"

G3_color			= CreateGauge("parameter")
G3_color.arg_number	= 404
G3_color.input		= {0, 1}
G3_color.output		= {0, 1}
G3_color.parameter_name= "G3_color"

G4_color			= CreateGauge("parameter")
G4_color.arg_number	= 406
G4_color.input		= {0, 1}
G4_color.output		= {0, 1}
G4_color.parameter_name= "G4_color"

G1_count			= CreateGauge("parameter")
G1_count.arg_number	= 401
G1_count.input		= {0, 1}
G1_count.output		= {0, 1}
G1_count.parameter_name = "G1_count"

G2_count			= CreateGauge("parameter")
G2_count.arg_number	= 403
G2_count.input		= {0, 1}
G2_count.output		= {0, 1}
G2_count.parameter_name = "G2_count"

G3_count			= CreateGauge("parameter")
G3_count.arg_number	= 405
G3_count.input		= {0, 1}
G3_count.output		= {0, 1}
G3_count.parameter_name = "G3_count"

G4_count			= CreateGauge("parameter")
G4_count.arg_number	= 407
G4_count.input		= {0, 1}
G4_count.output		= {0, 1}
G4_count.parameter_name = "G4_count"

Frag_count			= CreateGauge("parameter")
Frag_count.arg_number	= 408
Frag_count.input		= {0, 1}
Frag_count.output		= {0, 1}
Frag_count.parameter_name = "Frag_count"



Throttle			= CreateGauge("parameter")
Throttle.arg_number	= 4
Throttle.input		= {0, 1}
Throttle.output		= {0, 1}
Throttle.parameter_name= "THROTTLE"

ADIBank					= CreateGauge("parameter")
ADIBank.arg_number		= 300
ADIBank.input			= {-math.pi, math.pi}
ADIBank.output			= {1, -1}
ADIBank.parameter_name	= "ADI_BANK"

ADIPitch				= CreateGauge("parameter")
ADIPitch.arg_number		= 301
ADIPitch.input			= {-math.rad(180),0, math.rad(180)}
ADIPitch.output			= {-1,0, 1}
ADIPitch.parameter_name	= "ADI_PITCH"

ADIslip					= CreateGauge("parameter")
ADIslip.arg_number		= 302
ADIslip.input			= {-math.pi, math.pi}
ADIslip.output			= {-1, 1}
ADIslip.parameter_name	= "ADI_SLIP"

ClimbNeedle			= CreateGauge("parameter")
ClimbNeedle.arg_number	= 303
ClimbNeedle.input		= {-6.0,-2.0, -1.0,-0.5,0.0,0.5,1.0,2.0,6} 
ClimbNeedle.output		= {-1.0,-9.5/18.0,-7.0/18.0,-4.0/18.0,0.0,4.0/18.0,7.0/18.0,9.5/18.0,1.0}
ClimbNeedle.parameter_name	= "IND_CLIMB"


IASneedle = CreateGauge("parameter")
IASneedle.arg_number= 307
IASneedle.input  = {0.0, 2.0/15.0, 4.0/15.0,  5.0/15.0,  6.0/15.0,  8.0/15.0,  1.0} 
IASneedle.output = {0.0, 2.0/36.0, 10.0/36.0, 12.5/36.0, 14.0/36.0, 18.5/36.0, 34.0/36.0}
IASneedle.parameter_name = "IND_IAS"


altind						= CreateGauge("parameter")
altind.arg_number			= 304
altind.input				= {0.0, 1.0} 
altind.output				= {0.0, 1.0}
altind.parameter_name		= "altind"

RPM_R							= CreateGauge("parameter")
RPM_R.arg_number				= 308
RPM_R.input					    = {0, 1.2} 
RPM_R.output					= {0, 30.0/36.0}
RPM_R.parameter_name			= "RPM_R"


RPM_N1							= CreateGauge("parameter")
RPM_N1.arg_number					= 311
RPM_N1.input						= {0, 1.0} 
RPM_N1.output						= {0, 1.0}
RPM_N1.parameter_name				= "RPM_N1"

RPM_N2							= CreateGauge("parameter")
RPM_N2.arg_number					= 309
RPM_N2.input						= {0, 1.2} 
RPM_N2.output						= {0, 30.0/36.0}
RPM_N2.parameter_name				= "RPM_N2"


Torque						= CreateGauge("parameter")
Torque.arg_number			= 310
Torque.input				= {0,5983} 
Torque.output				= {0,32.5/36.0}
Torque.parameter_name		= "TORQUE"


Temperature_ind = CreateGauge("parameter")
Temperature_ind.arg_number= 312
Temperature_ind.input  = {0.0, 1200.0} 
Temperature_ind.output = {0.0, 28.0/36.0}
Temperature_ind.parameter_name = "IND_TEMP"

Fuel_ind = CreateGauge("parameter")
Fuel_ind.arg_number= 313
Fuel_ind.input  = {0.0, 1.0} 
Fuel_ind.output = {0.0, 9.0/36.0,19.5/36.0,21.5/36.0}
Fuel_ind.parameter_name = "IND_FUEL"

OilTemp_ind = CreateGauge("parameter")
OilTemp_ind.arg_number= 314
OilTemp_ind.input  = {0.0, 50.0,100.0,150.0} 
OilTemp_ind.output = {0.0, 1.5/36.0,7.5/36.0,9.0/36.0}
OilTemp_ind.parameter_name = "IND_OILTEMP"

OilPress_ind = CreateGauge("parameter")
OilPress_ind.arg_number= 316
OilPress_ind.input  = {0.0, 50.0,100.0,150.0} 
OilPress_ind.output = {0.0, 2.5/36.0,6.0/36.0,8.5/36.0}
OilPress_ind.parameter_name = "IND_OILPRESS"

DCAmps_ind = CreateGauge("parameter")
DCAmps_ind.arg_number= 315
DCAmps_ind.input  = {-150.0,150.0} 
DCAmps_ind.output = {0.0, 8.0/36.0}
DCAmps_ind.parameter_name = "IND_DCAMPS"

PANEL_SHAKEX = CreateGauge("parameter")
PANEL_SHAKEX.arg_number= 200
PANEL_SHAKEX.input  = {-1.0,1.0} 
PANEL_SHAKEX.output = {-1.0,1.0}
PANEL_SHAKEX.parameter_name = "SHAKE_X"

PANEL_SHAKEY = CreateGauge("parameter")
PANEL_SHAKEY.arg_number= 201
PANEL_SHAKEY.input  = {-1.0,1.0} 
PANEL_SHAKEY.output = {-1.0,1.0}
PANEL_SHAKEY.parameter_name = "SHAKE_Y"

IND_FUEL					= CreateGauge("parameter")
IND_FUEL.arg_number			= 313
IND_FUEL.input				= {0.0, 100.0,300.0,400.0} 
IND_FUEL.output				= {0.0, 9.0/36.0,19.5/36.0,21.5/36.0}
IND_FUEL.parameter_name		= "IND_FUEL"

altadjxxxN						= CreateGauge("parameter")
altadjxxxN.arg_number			= 320
altadjxxxN.input				= {0.0, 1.0} 
altadjxxxN.output				= {0.0, 1.0}
altadjxxxN.parameter_name		= "altadjxxxN"

altadjxxNx						= CreateGauge("parameter")
altadjxxNx.arg_number			= 321
altadjxxNx.input				= {0.0, 1.0} 
altadjxxNx.output				= {0.0, 1.0}
altadjxxNx.parameter_name		= "altadjxxNx"

altadjxNxx						= CreateGauge("parameter")
altadjxNxx.arg_number			= 322
altadjxNxx.input				= {0.0, 1.0} 
altadjxNxx.output				= {0.0, 1.0}
altadjxNxx.parameter_name		= "altadjxNxx"

altadjNxxx						= CreateGauge("parameter")
altadjNxxx.arg_number			= 323
altadjNxxx.input				= {0.0, 1.0} 
altadjNxxx.output				= {0.0, 1.0}
altadjNxxx.parameter_name		= "altadjNxxx"


altxxN						= CreateGauge("parameter")
altxxN.arg_number			= 324
altxxN.input				= {0.0, 1.0} 
altxxN.output				= {0.0, 1.0}
altxxN.parameter_name		= "altxxN"

altxNx						= CreateGauge("parameter")
altxNx.arg_number			= 325
altxNx.input				= {0.0, 1.0} 
altxNx.output				= {0.0, 1.0}
altxNx.parameter_name		= "altxNx"

altNxx						= CreateGauge("parameter")
altNxx.arg_number			= 326
altNxx.input				= {0.0, 1.0} 
altNxx.output				= {0.0, 1.0}
altNxx.parameter_name		= "altNxx"



Anarc54Nxxx   		        = CreateGauge("parameter")
Anarc54Nxxx.arg_number		= 328
Anarc54Nxxx.input			= {0.0, 1.0} 
Anarc54Nxxx.output			= {0.0, 1.0}
Anarc54Nxxx.parameter_name	= "Anarc54Nxxx"

Anarc54xNxx   		        = CreateGauge("parameter")
Anarc54xNxx.arg_number		= 329
Anarc54xNxx.input			= {0.0, 1.0} 
Anarc54xNxx.output			= {0.0, 1.0}
Anarc54xNxx.parameter_name	= "Anarc54xNxx"

Anarc54xxNx   		        = CreateGauge("parameter")
Anarc54xxNx.arg_number		= 330
Anarc54xxNx.input			= {0.0, 1.0} 
Anarc54xxNx.output			= {0.0, 1.0}
Anarc54xxNx.parameter_name	= "Anarc54xxNx"

Anarc54xxxN   		        = CreateGauge("parameter")
Anarc54xxxN.arg_number		= 331
Anarc54xxxN.input			= {0.0, 1.0} 
Anarc54xxxN.output			= {0.0, 1.0}
Anarc54xxxN.parameter_name	= "Anarc54xxxN"




Anarc83Band   		        = CreateGauge("parameter")
Anarc83Band.arg_number		= 317
Anarc83Band.input			= {-1.0, 1.0} 
Anarc83Band.output			= {-1.0, 1.0}
Anarc83Band.parameter_name	= "Anarc83Band"

Anarc83Freq   		        = CreateGauge("parameter")
Anarc83Freq.arg_number		= 318
Anarc83Freq.input			= {0.0, 1.0} 
Anarc83Freq.output			= {0.0, 1.0}
Anarc83Freq.parameter_name	= "Anarc83Freq"

Anarc83TuneMeter   		        = CreateGauge("parameter")
Anarc83TuneMeter.arg_number		= 319
Anarc83TuneMeter.input			= {0.0, 1.0} 
Anarc83TuneMeter.output			= {0.0, 1.0}
Anarc83TuneMeter.parameter_name	= "Anarc83TuneMeter"


GunsightUpDown   		        = CreateGauge("parameter")
GunsightUpDown.arg_number		= 171
GunsightUpDown.input			= {-1.0, 1.0} 
GunsightUpDown.output			= {-1.0, 1.0}
GunsightUpDown.parameter_name	= "GunsightUpDown"

GunsighVisible   		        = CreateGauge("parameter")
GunsighVisible.arg_number		= 172
GunsighVisible.input			= {0.0, 1.0} 
GunsighVisible.output			= {0.0, 1.0}
GunsighVisible.parameter_name	= "Gunsight_visible"


Compass_HDG = CreateGauge("parameter")
Compass_HDG.arg_number		= 106
Compass_HDG.input			= {0.0, 360.0} 
Compass_HDG.output			= {0.0, 1.0}
Compass_HDG.parameter_name	= "Compass_HDG"

Compass_Bank = CreateGauge("parameter")
Compass_Bank.arg_number		= 107
Compass_Bank.input			= {-15.0, 15.0} 
Compass_Bank.output			= {-1.0, 1.0}
Compass_Bank.parameter_name	= "Compass_Bank"

Compass_Pitch = CreateGauge("parameter")
Compass_Pitch.arg_number		= 108
Compass_Pitch.input			= {-15.0, 15.0} 
Compass_Pitch.output			= {-1.0, 1.0}
Compass_Pitch.parameter_name	= "Compass_Pitch"


Pend_Bank = CreateGauge("parameter")
Pend_Bank.arg_number		= 450
Pend_Bank.input			= {-90, 90.0} 
Pend_Bank.output			= {-1.0, 1.0}
Pend_Bank.parameter_name	= "Pend_Bank"

Pend_Pitch = CreateGauge("parameter")
Pend_Pitch.arg_number		= 451
Pend_Pitch.input			= {-90.0, 90.0} 
Pend_Pitch.output			= {-1.0, 1.0}
Pend_Pitch.parameter_name	= "Pend_Pitch"


Radio_Lights = CreateGauge("parameter")
Radio_Lights.arg_number		= 102
Radio_Lights.input			= {0.0, 1.0} 
Radio_Lights.output			= {0.0, 1.0}
Radio_Lights.parameter_name	= "Radio_Lights"

Mid_Panel_Lights = CreateGauge("parameter")
Mid_Panel_Lights.arg_number		= 103
Mid_Panel_Lights.input			= {0.0, 1.0} 
Mid_Panel_Lights.output			= {0.0, 1.0}
Mid_Panel_Lights.parameter_name	= "Mid_Panel_Lights"

Flight_Lights = CreateGauge("parameter")
Flight_Lights.arg_number		= 104
Flight_Lights.input			= {0.0, 1.0} 
Flight_Lights.output			= {0.0, 1.0}
Flight_Lights.parameter_name	= "Flight_Lights"

Engine_Lights = CreateGauge("parameter")
Engine_Lights.arg_number		= 105
Engine_Lights.input			= {0.0, 1.0} 
Engine_Lights.output			= {0.0, 1.0}
Engine_Lights.parameter_name	= "Engine_Lights"

Warning_Oil_Press = CreateGauge("parameter")
Warning_Oil_Press.arg_number		= 376
Warning_Oil_Press.input			= {0.0, 1.0} 
Warning_Oil_Press.output			= {0.0, 1.0}
Warning_Oil_Press.parameter_name	= "Warning_Oil_Press"

Warning_Oil_Temp = CreateGauge("parameter")
Warning_Oil_Temp.arg_number		= 377
Warning_Oil_Temp.input			= {0.0, 1.0} 
Warning_Oil_Temp.output			= {0.0, 1.0}
Warning_Oil_Temp.parameter_name	= "Warning_Oil_Temp"

Warning_Engine_Out = CreateGauge("parameter")
Warning_Engine_Out.arg_number		= 378
Warning_Engine_Out.input			= {0.0, 1.0} 
Warning_Engine_Out.output			= {0.0, 1.0}
Warning_Engine_Out.parameter_name	= "Warning_Engine_Out"


Warning_By_Pass_Air = CreateGauge("parameter")
Warning_By_Pass_Air.arg_number		= 379
Warning_By_Pass_Air.input			= {0.0, 1.0} 
Warning_By_Pass_Air.output			= {0.0, 1.0}
Warning_By_Pass_Air.parameter_name	= "Warning_By_Pass_Air"

Warning_Oil_Chips = CreateGauge("parameter")
Warning_Oil_Chips.arg_number		= 380
Warning_Oil_Chips.input			= {0.0, 1.0} 
Warning_Oil_Chips.output			= {0.0, 1.0}
Warning_Oil_Chips.parameter_name	= "Warning_Oil_Chips"

Warning_Fuel_Filter = CreateGauge("parameter")
Warning_Fuel_Filter.arg_number		= 381
Warning_Fuel_Filter.input			= {0.0, 1.0} 
Warning_Fuel_Filter.output			= {0.0, 1.0}
Warning_Fuel_Filter.parameter_name	= "Warning_Fuel_Filter"

Warning_Generator_Out = CreateGauge("parameter")
Warning_Generator_Out.arg_number		= 382
Warning_Generator_Out.input			= {0.0, 1.0} 
Warning_Generator_Out.output			= {0.0, 1.0}
Warning_Generator_Out.parameter_name	= "Warning_Generator_Out"

Warning_Fuel_Low = CreateGauge("parameter")
Warning_Fuel_Low.arg_number		= 383
Warning_Fuel_Low.input			= {0.0, 1.0} 
Warning_Fuel_Low.output			= {0.0, 1.0}
Warning_Fuel_Low.parameter_name	= "Warning_Fuel_Low"

Warning_Oil_Clr_Bypass = CreateGauge("parameter")
Warning_Oil_Clr_Bypass.arg_number		= 384
Warning_Oil_Clr_Bypass.input			= {0.0, 1.0} 
Warning_Oil_Clr_Bypass.output			= {0.0, 1.0}
Warning_Oil_Clr_Bypass.parameter_name	= "Warning_Oil_Clr_Bypass"

Warning_Gun_Not_Cleared = CreateGauge("parameter")
Warning_Gun_Not_Cleared.arg_number		= 385
Warning_Gun_Not_Cleared.input			= {0.0, 1.0} 
Warning_Gun_Not_Cleared.output			= {0.0, 1.0}
Warning_Gun_Not_Cleared.parameter_name	= "Warning_Gun_Not_Cleared"

Warning_Armed = CreateGauge("parameter")
Warning_Armed.arg_number		= 386
Warning_Armed.input			= {0.0, 1.0} 
Warning_Armed.output			= {0.0, 1.0}
Warning_Armed.parameter_name	= "Warning_Armed"

Warning_Low_Ammo = CreateGauge("parameter")
Warning_Low_Ammo.arg_number		= 387
Warning_Low_Ammo.input			= {0.0, 1.0} 
Warning_Low_Ammo.output			= {0.0, 1.0}
Warning_Low_Ammo.parameter_name	= "Warning_Low_Ammo"



ID_1351_ADF2 = CreateGauge("parameter")
ID_1351_ADF2.arg_number		= 296
ID_1351_ADF2.input			= {-5.0, 5.0} 
ID_1351_ADF2.output			= {-1.0, 1.0}
ID_1351_ADF2.parameter_name	= "ID_1351_ADF2"

ID_1351_ADF = CreateGauge("parameter")
ID_1351_ADF.arg_number		= 297
ID_1351_ADF.input			= {-180.0, 180.0} 
ID_1351_ADF.output			= {-1.0, 1.0}
ID_1351_ADF.parameter_name	= "ID_1351_ADF"

ID_1351_HDG = CreateGauge("parameter")
ID_1351_HDG.arg_number		= 298
ID_1351_HDG.input			= {0.0, 360.0} 
ID_1351_HDG.output			= {0.0, 1.0}
ID_1351_HDG.parameter_name	= "ID_1351_HDG"

ID_1351_OFF = CreateGauge("parameter")
ID_1351_OFF.arg_number		= 299
ID_1351_OFF.input			= {0.0, 1.0} 
ID_1351_OFF.output			= {0.0, 1.0}
ID_1351_OFF.parameter_name	= "ID_1351_OFF"

ALTITUDE_OFF = CreateGauge("parameter")
ALTITUDE_OFF.arg_number		= 294
ALTITUDE_OFF.input			= {0.0, 1.0} 
ALTITUDE_OFF.output			= {0.0, 1.0}
ALTITUDE_OFF.parameter_name	= "ALTITUDE_OFF"

ATTITUDE_OFF = CreateGauge("parameter")
ATTITUDE_OFF.arg_number		= 295
ATTITUDE_OFF.input			= {0.0, 1.0} 
ATTITUDE_OFF.output			= {0.0, 1.0}
ATTITUDE_OFF.parameter_name	= "ATTITUDE_OFF"


DOORS_OFF = CreateGauge("parameter")
DOORS_OFF.arg_number		= 509
DOORS_OFF.input			= {0.0, 1.0} 
DOORS_OFF.output			= {0.0, 1.0}
DOORS_OFF.parameter_name	= "DOORS_OFF"

DOOR_OFF_L = CreateGauge("parameter")
DOOR_OFF_L.arg_number		= 505
DOOR_OFF_L.input			= {0.0, 1.0} 
DOOR_OFF_L.output			= {0.0, 1.0}
DOOR_OFF_L.parameter_name	= "DOOR_OFF_L"

DOOR_OFF_R = CreateGauge("parameter")
DOOR_OFF_R.arg_number		= 506
DOOR_OFF_R.input			= {0.0, 1.0} 
DOOR_OFF_R.output			= {0.0, 1.0}
DOOR_OFF_R.parameter_name	= "DOOR_OFF_R"

DM470 = CreateGauge("parameter")
DM470.arg_number		= 470
DM470.input			= {0.0, 1.0} 
DM470.output			= {0.0, 1.0}
DM470.parameter_name	= "DM470"

DM471 = CreateGauge("parameter")
DM471.arg_number		= 471
DM471.input			= {0.0, 1.0} 
DM471.output			= {0.0, 1.0}
DM471.parameter_name	= "DM471"

DM472 = CreateGauge("parameter")
DM472.arg_number		= 472
DM472.input			= {0.0, 1.0} 
DM472.output			= {0.0, 1.0}
DM472.parameter_name	= "DM472"

DM473 = CreateGauge("parameter")
DM473.arg_number		= 473
DM473.input			= {0.0, 1.0} 
DM473.output			= {0.0, 1.0}
DM473.parameter_name	= "DM473"

DM474 = CreateGauge("parameter")
DM474.arg_number		= 474
DM474.input			= {0.0, 1.0} 
DM474.output			= {0.0, 1.0}
DM474.parameter_name	= "DM474"


DM474 = CreateGauge("parameter")
DM474.arg_number		= 35
DM474.input			= {0.0, 1.0} 
DM474.output			= {0.0, 1.0}
DM474.parameter_name	= "OPEN_DOORS"

DM474 = CreateGauge("parameter")
DM474.arg_number		= 338
DM474.input			= {0.0, 1.0} 
DM474.output			= {0.0, 1.0}
DM474.parameter_name	= "PPT_PILOT"

DM474 = CreateGauge("parameter")
DM474.arg_number		= 339
DM474.input			= {0.0, 1.0} 
DM474.output			= {0.0, 1.0}
DM474.parameter_name	= "PPT_COPILOT"


AIM_OFFSET = CreateGauge("parameter")
AIM_OFFSET.arg_number		= 120
AIM_OFFSET.input			= {-1.0, 1.0} 
AIM_OFFSET.output			= {-1.0, 1.0}
AIM_OFFSET.parameter_name	= "AIM_OFFSET"

AIM_MARK_VISIBLE = CreateGauge("parameter")
AIM_MARK_VISIBLE.arg_number		= 121
AIM_MARK_VISIBLE.input			= {0.0, 1.0} 
AIM_MARK_VISIBLE.output			= {0.0, 1.0}
AIM_MARK_VISIBLE.parameter_name	= "AIM_MARK_VISIBLE"

RWR_VISIBLE = CreateGauge("parameter")
RWR_VISIBLE.arg_number		= 73
RWR_VISIBLE.input			= {0.0, 1.0} 
RWR_VISIBLE.output			= {0.0, 1.0}
RWR_VISIBLE.parameter_name	= "RWR_VISIBLE"

FLARES_EQUIPPED = CreateGauge("parameter")
FLARES_EQUIPPED.arg_number		= 74
FLARES_EQUIPPED.input			= {0.0, 1.0} 
FLARES_EQUIPPED.output			= {0.0, 1.0}
FLARES_EQUIPPED.parameter_name	= "FLARES_EQUIPPED"


need_to_be_closed = true -- close lua state after initialization 
