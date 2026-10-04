local self_ID = "OH-6A"

declare_plugin(self_ID,
	{
		dirName       = current_mod_path,
		displayName   = _("OH-6A Cayuse"),
		fileMenuName  = _("OH-6A"),
		version 		= "1.7",
		state         = "installed",
		info          = _("The Hughes OH-6A Cayuse is a single-engine light helicopter. Its formal name is derived from the Cayuse people, while its 'Loach' nickname comes from the acronym for the Light Observation Helicopter (LOH) program under which it was procured. During 1966, the OH-6 began service with the U.S. Army, and promptly entered active combat in the Vietnam War."),
		encyclopedia_path = current_mod_path..'/Encyclopedia',
		binaries      =
		{
			'OH6',
		},
		Skins         =
		{
			{
				name	= "OH-6A Cayuse",
				dir		= "Theme"
			}
			
		},
		LogBook       =
		{
			{
				name = _("OH-6A Cayuse"),
				type = "OH-6A",
			},
		},
		InputProfiles =
		{
			["OH-6A"] = current_mod_path .. '/Input',
		},
		Missions =
		{
			{
				name		= _("OH-6A Cayuse"),
				dir			= "Missions",
				},
		},
		Options       =
		{
			{
				name   = _("OH-6A Cayuse"),
				nameId = "OH-6A",
				dir    = "Options",
				CLSID  = "{OH-6A options}"
			},
		},
	})
-------------------------------------------------------------------------------
mount_vfs_model_path(current_mod_path .. "/Shapes")
mount_vfs_model_path(current_mod_path .. "/Shapes/cargo_oh6")
mount_vfs_liveries_path(current_mod_path .. "/Liveries")
--------------------------------------------------------------------------------
mount_vfs_texture_path(current_mod_path .. "/Shapes/textures")
mount_vfs_texture_path(current_mod_path .. "/Shapes/textures/cockpit")
mount_vfs_texture_path(current_mod_path .. "/Shapes/textures/extra")
mount_vfs_texture_path(current_mod_path .. "/Shapes/textures/gunner")
mount_vfs_texture_path(current_mod_path .. "/Shapes/textures/weapons")
mount_vfs_texture_path(current_mod_path .. "/Shapes/textures/weapons/grenades")
mount_vfs_texture_path(current_mod_path .. "/Shapes/textures/pilot")

--------------------------------------------------------------------------------
mount_vfs_texture_path(current_mod_path .. "/ImagesGui")
mount_vfs_texture_path(current_mod_path ..  "/Theme/ME")
mount_vfs_texture_path(current_mod_path .. "/Skins/1/ME")


--dofile(current_mod_path .. '/Weapons/OH-6_weapons.lua')
dofile(current_mod_path .. '/UnitPayloads/OH-6A.lua')
dofile(current_mod_path .. "/Views.lua")
dofile(current_mod_path .. "/Suspension.lua")
dofile(current_mod_path .. '/OH6.lua')
dofile(current_mod_path .. '/cargo_oh6.lua')


make_view_settings('OH-6A', ViewSettings, SnapViews)

local FM =
{
	[1] = self_ID,
	[2] = "OH6",                              -- name of dll
	center_of_mass = { cog_x, cog_y, cog_z }, -- center of mass position relative to object 3d model center
	
	moment_of_inertia = { 246,1009,979, 128 }, -- moment of inertia of empty 
	suspension = suspension,
}

make_flyable('OH-6A', current_mod_path .. '/Cockpit/Scripts/', FM, current_mod_path .. '/comm.lua')

plugin_done()
