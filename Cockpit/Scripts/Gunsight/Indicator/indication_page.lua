dofile(LockOn_Options.script_path.."Gunsight/Indicator/definitions.lua")
dofile(LockOn_Options.common_script_path .."elements_defs.lua")
--dofile(LockOn_Options.script_path.."definitions.lua")


function AddGunSight(parent_base_name)
    local optical_sight_colour = {251.0, 114.0, 0.0, 200.0 } -- {255.0, 139.0, 50.0, 150.0}
    local optical_sight_material = MakeMaterial(nil, optical_sight_colour)


    -- 30 mil inner circle
    local inner_ring			    = CreateElement "ceCircle"
    inner_ring.name				= create_guid_string()
    inner_ring.init_pos	        = {0.0, 0.0, 0.0}
    inner_ring.parent_element		= parent_base_name
    inner_ring.radius			    = {29.0*MIL_TO_MRAD, 31.0*MIL_TO_MRAD}
    inner_ring.arc				= {0, math.pi * 2}
    inner_ring.segment			= math.pi * 4 / 64
    inner_ring.gap				= math.pi * 4 / 64
    inner_ring.segment_detail	    = 4
    inner_ring.dashed		        = false
    inner_ring.additive_alpha        = true
    inner_ring.element_params 		= {"GUNSIGHT_OPACITY",}
    inner_ring.controllers    		= {{"opacity_using_parameter",0}}
    inner_ring.material           = optical_sight_material
    AddHudElement(inner_ring)

    -- 60 mil outer circle
    local outer_ring			= CreateElement "ceCircle"
    outer_ring.name				= create_guid_string()
    outer_ring.init_pos	        = {0.0, 0.0, 0.0}
    outer_ring.parent_element	= parent_base_name
    outer_ring.radius		= {59.0*MIL_TO_MRAD, 61.0*MIL_TO_MRAD}
    outer_ring.arc              = {0, math.pi * 2}
    outer_ring.segment	        = math.pi * 4 / 16 --64
    outer_ring.gap              = math.pi * 4 / 16 --64
    outer_ring.segment_detail	= 4
    outer_ring.dashed		= false
    outer_ring.additive_alpha        = true
    outer_ring.element_params 		= {"GUNSIGHT_OPACITY",}
    outer_ring.controllers    		= {{"opacity_using_parameter",0}}
    outer_ring.material = optical_sight_material
    AddHudElement(outer_ring)

    local INDEX_SIZE = 1.0*MIL_TO_MRAD

    local INDEX_HEIGHT = 2.0 * INDEX_SIZE
    local INDEX_WIDTH = 200.0 * INDEX_SIZE

    
    local horline		= CreateElement "ceMeshPoly"
    horline.name		= create_guid_string()
    horline.init_pos	        = {0.0, 0.0, 0.0}
    horline.parent_element	= parent_base_name
    horline.primitivetype	= "triangles"
    horline.vertices			= {
            {  -0.5 * INDEX_WIDTH,  0.5 * INDEX_HEIGHT}, 
            {  -0.5 * INDEX_WIDTH, -0.5 * INDEX_HEIGHT}, 
            {   0.5 * INDEX_WIDTH, -0.5 * INDEX_HEIGHT}, 
            {   0.5 * INDEX_WIDTH,  0.5 * INDEX_HEIGHT},}
    horline.indices			= {0,1,3,  1,2,3}
    horline.additive_alpha        = true
    horline.element_params 		= {"GUNSIGHT_OPACITY",}
    horline.controllers    		= {{"opacity_using_parameter",0}}
    horline.material = optical_sight_material
    AddHudElement(horline)

    local INDEX_HEIGHT = 200.0 * INDEX_SIZE
    local INDEX_WIDTH = 2.0 * INDEX_SIZE

    local vertline		= CreateElement "ceMeshPoly"
    vertline.name		= create_guid_string()
    vertline.init_pos	        = {0.0, 0.0, 0.0}
    vertline.parent_element	= parent_base_name
    vertline.primitivetype	= "triangles"
    vertline.vertices			= {
            {  -0.5 * INDEX_WIDTH,  0.5 * INDEX_HEIGHT}, 
            {  -0.5 * INDEX_WIDTH, -0.5 * INDEX_HEIGHT}, 
            {   0.5 * INDEX_WIDTH, -0.5 * INDEX_HEIGHT}, 
            {   0.5 * INDEX_WIDTH,  0.5 * INDEX_HEIGHT},}
    vertline.indices			= {0,1,3,  1,2,3}
    vertline.additive_alpha        = true
    vertline.element_params 		= {"GUNSIGHT_OPACITY",}
    vertline.controllers    		= {{"opacity_using_parameter",0}}
    vertline.material = optical_sight_material
    AddHudElement(vertline)
end


function AddFixedSight(parent_base_name)
    local optical_sight_colour = {251.0, 114.0, 0.0, 200.0 } -- {255.0, 139.0, 50.0, 150.0}
    local optical_sight_material = MakeMaterial(nil, optical_sight_colour)


    -- 30 mil inner circle
    local inner_ring			    = CreateElement "ceCircle"
    inner_ring.name				= create_guid_string()
    inner_ring.init_pos	        = {0.0, 0.0, 0.0}
    inner_ring.parent_element		= parent_base_name
    inner_ring.radius			    = {4.5*MIL_TO_MRAD, 5.5*MIL_TO_MRAD}
    inner_ring.arc				= {0, math.pi * 2}
    inner_ring.segment			= math.pi * 4 / 64
    inner_ring.gap				= math.pi * 4 / 64
    inner_ring.segment_detail	    = 4
    inner_ring.dashed		        = false
    inner_ring.additive_alpha        = true
    inner_ring.element_params 		= {"GUNSIGHT_OPACITY",}
    inner_ring.controllers    		= {{"opacity_using_parameter",0}}
    inner_ring.material           = optical_sight_material
    AddHudElement(inner_ring)
end