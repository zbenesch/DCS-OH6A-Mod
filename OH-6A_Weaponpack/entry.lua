declare_plugin("OH-6A Weapons",

{
displayName   	= _("OH-6A Weapons"),
shortName	  	=   "OH-6A Weapons",
installed 	 	= true, 
dirName	  	 	= current_mod_path,

encyclopedia_path = current_mod_path..'/Encyclopedia',
	
fileMenuName 	= _("OH-6A Weapons"),
version		 	= "1.2.0",		 
state		 	= "installed",
developerName	= "EightBall & Tobi",
info		 	= _("Supporting weapons for the OH-6A mod"),

})

dofile(current_mod_path .."/Weapons/OH-6_weapons.lua")
-- ------------------------------------------------------------------------------------------------------------------------


plugin_done()

