mainWheelRadius = 1.5311
tailWheelRadius = 1.5311


wheel_mass = 50


--MAINGEAR2
main_amortizer_min_length                 = 0.00
main_amortizer_max_length                 = 0.2 --0.7
main_amortizer_basic_length               = 0.2 --0.7
main_amortizer_reduce_length              = 0.2

front_length_factor = 1.1

main_amortizer_spring_force_factor        = 150000
front_amortizer_spring_force_factor       = 0.5 * main_amortizer_spring_force_factor
main_amortizer_spring_force_factor_rate   = 1.5

--A static force that is there for countering gravity.
main_amortizer_static_force               = 300.0 * 9.81 * 1.0
nose_amortizer_static_force               = 300.0 * 9.81 * 1.0

main_damper_force                         = 1750.0
main_amortizer_direct_damper_force_factor = main_damper_force * 1.0  --Damping force in the compress direction.
main_amortizer_back_damper_force_factor   = main_damper_force        --Damping force in the extend direction

main_damper_coeff                         = 1.0

main_wheel_moment_of_inertia              = 2.65


wheel_static_friction_factor_COMMON       = 0.25
wheel_side_friction_factor_COMMON         = 0.7
wheel_roll_friction_factor_COMMON         = 0.17
wheel_glide_friction_factor_COMMON        = 0.16

brake_moment_main                         = 5e1

wheel_radius_factor                       = 100


main_wheel_kz_factor                      = 0.052
main_noise_k                              = 0.001





suspension =
{
	--front L
	{
		anti_skid_installed = false,

		mass                = wheel_mass,
		damage_element      = 84,
		self_attitude       = false,
		damper_coeff        = main_damper_coeff,


		amortizer_min_length                 = main_amortizer_min_length,
		amortizer_max_length                 = main_amortizer_max_length*front_length_factor,
		amortizer_basic_length               = main_amortizer_basic_length*front_length_factor,
		amortizer_spring_force_factor        = front_amortizer_spring_force_factor,
		amortizer_spring_force_factor_rate   = main_amortizer_spring_force_factor_rate,
		amortizer_static_force               = nose_amortizer_static_force,
		amortizer_reduce_length              = main_amortizer_reduce_length,
		allowable_hard_contact_length        = main_amortizer_max_length,
		amortizer_direct_damper_force_factor = main_amortizer_direct_damper_force_factor,
		amortizer_back_damper_force_factor   = main_amortizer_back_damper_force_factor,

		wheel_radius                         = tailWheelRadius,
		wheel_static_friction_factor         = wheel_static_friction_factor_COMMON,
		wheel_side_friction_factor           = wheel_side_friction_factor_COMMON, --affects the abillity to slide in turns - decrease for better turning
		wheel_roll_friction_factor           = wheel_roll_friction_factor_COMMON,
		wheel_glide_friction_factor          = wheel_glide_friction_factor_COMMON,
		wheel_kz_factor                      = main_wheel_kz_factor,
		noise_k                              = main_noise_k,
		wheel_damage_speed                   = 200.0,
		wheel_damage_force_factor            = 250.0,
		collision_shell_name                 = "AIR_BRAKE_L",
		arg_amortizer                        = 202,
	},



	--front R
	{
		anti_skid_installed = false,

		mass                = wheel_mass,
		damage_element      = 85,
		self_attitude       = false,
		damper_coeff        = main_damper_coeff,


		amortizer_min_length                 = main_amortizer_min_length,
		amortizer_max_length                 = main_amortizer_max_length*front_length_factor,
		amortizer_basic_length               = main_amortizer_basic_length*front_length_factor,
		amortizer_spring_force_factor        = front_amortizer_spring_force_factor,
		amortizer_spring_force_factor_rate   = main_amortizer_spring_force_factor_rate,
		amortizer_static_force               = nose_amortizer_static_force,
		amortizer_reduce_length              = main_amortizer_reduce_length,
		allowable_hard_contact_length        = main_amortizer_max_length,
		amortizer_direct_damper_force_factor = main_amortizer_direct_damper_force_factor,
		amortizer_back_damper_force_factor   = main_amortizer_back_damper_force_factor,

		wheel_radius                         = tailWheelRadius,
		wheel_static_friction_factor         = wheel_static_friction_factor_COMMON,
		wheel_side_friction_factor           = wheel_side_friction_factor_COMMON, --affects the abillity to slide in turns - decrease for better turning
		wheel_roll_friction_factor           = wheel_roll_friction_factor_COMMON,
		wheel_glide_friction_factor          = wheel_glide_friction_factor_COMMON,
		wheel_kz_factor                      = main_wheel_kz_factor,
		noise_k                              = main_noise_k,
		wheel_damage_speed                   = 200.0,
		wheel_damage_force_factor            = 250.0, --/N/ 250 Su-25, damage to tires
		
		collision_shell_name                 = "AIR_BRAKE_R",
		arg_amortizer                        = 204,
	},

	--Back L
	{
		anti_skid_installed = false,

		mass                = wheel_mass,
		damage_element      = 84,
		self_attitude       = false,
		--		yaw_limit 								= math.rad(90.0), --so apparently this	must be set to half the animation angle for some reason
		damper_coeff        = main_damper_coeff,


		amortizer_min_length                 = main_amortizer_min_length,
		amortizer_max_length                 = main_amortizer_max_length,
		amortizer_basic_length               = main_amortizer_basic_length,
		amortizer_spring_force_factor        = main_amortizer_spring_force_factor,
		amortizer_spring_force_factor_rate   = main_amortizer_spring_force_factor_rate,
		amortizer_static_force               = main_amortizer_static_force,
		amortizer_reduce_length              = main_amortizer_reduce_length,
		allowable_hard_contact_length        = main_amortizer_max_length,
		amortizer_direct_damper_force_factor = main_amortizer_direct_damper_force_factor,
		amortizer_back_damper_force_factor   = main_amortizer_back_damper_force_factor,

		wheel_radius                         = tailWheelRadius,
		wheel_static_friction_factor         = wheel_static_friction_factor_COMMON,
		wheel_side_friction_factor           = wheel_side_friction_factor_COMMON, --affects the abillity to slide in turns - decrease for better turning
		wheel_roll_friction_factor           = wheel_roll_friction_factor_COMMON,
		wheel_glide_friction_factor          = wheel_glide_friction_factor_COMMON,
		wheel_kz_factor                      = main_wheel_kz_factor,
		noise_k                              = main_noise_k,
		
		wheel_damage_speed                   = 200.0,
		wheel_damage_force_factor            = 250.0, --/N/ 250 Su-25, damage to tires

		collision_shell_name                 = "Line_STABIL_L",
		arg_amortizer                        = 201,
	},

	--Back R
	{
		anti_skid_installed = false,

		mass                = wheel_mass,
		damage_element      = 85,
		self_attitude       = false,
		--		yaw_limit 								= math.rad(90.0), --so apparently this	must be set to half the animation angle for some reason
		damper_coeff        = main_damper_coeff,


		amortizer_min_length                 = main_amortizer_min_length,
		amortizer_max_length                 = main_amortizer_max_length,
		amortizer_basic_length               = main_amortizer_basic_length,
		amortizer_spring_force_factor        = main_amortizer_spring_force_factor,
		amortizer_spring_force_factor_rate   = main_amortizer_spring_force_factor_rate,
		amortizer_static_force               = main_amortizer_static_force,
		amortizer_reduce_length              = main_amortizer_reduce_length,
		allowable_hard_contact_length        = main_amortizer_max_length,
		amortizer_direct_damper_force_factor = main_amortizer_direct_damper_force_factor,
		amortizer_back_damper_force_factor   = main_amortizer_back_damper_force_factor,

		wheel_radius                         = tailWheelRadius,
		wheel_static_friction_factor         = wheel_static_friction_factor_COMMON,
		wheel_side_friction_factor           = wheel_side_friction_factor_COMMON, --affects the abillity to slide in turns - decrease for better turning
		wheel_roll_friction_factor           = wheel_roll_friction_factor_COMMON,
		wheel_glide_friction_factor          = wheel_glide_friction_factor_COMMON,
		wheel_kz_factor                      = main_wheel_kz_factor,
		noise_k                              = main_noise_k,
		
		wheel_damage_speed                   = 200.0,
		wheel_damage_force_factor            = 250.0, --/N/ 250 Su-25, damage to tires
	
		collision_shell_name                 = "Line_STABIL_R",
		arg_amortizer                        = 203,
	},



}
