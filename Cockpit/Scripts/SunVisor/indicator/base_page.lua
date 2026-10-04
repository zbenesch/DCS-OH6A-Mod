dofile(LockOn_Options.common_script_path.."elements_defs.lua")

local sunVisorMaterial = MakeMaterial(nil,{0,0,0,150})

SetCustomScale(2.0)
local sX = 1.6
local sY = 1.0

local sunVisor			 = CreateElement "ceTexPoly"
sunVisor.primitivetype	 = "triangles"
sunVisor.material		 = sunVisorMaterial
sunVisor.vertices		 = {{-sX, -sY}, {-sX, sY}, { sX, sY}, { sX, -sY}}
sunVisor.indices		 = default_box_indices
sunVisor.init_pos		 = {0,0}
sunVisor.h_clip_relation = h_clip_relations.REWRITE_LEVEL
sunVisor.level			 = DEFAULT_LEVEL
sunVisor.additive_alpha  = false
sunVisor.use_mipfilter	 = false
sunVisor.tex_coords 	 = {{0,0.995},{0,0},{2,0},{2,0.995}}
sunVisor.element_params  = {"SUNVISOR_PWR"}
sunVisor.controllers     = {{"parameter_in_range",0,0.9,1.1}}
--sunVisor.controllers     = {{"parameter_in_range",0,0.9,1.1}, {"move_up_down_using_parameter",1,.005}}
Add(sunVisor)
