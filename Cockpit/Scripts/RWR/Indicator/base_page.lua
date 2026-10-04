dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(FOV)


MFCD_GREEN_SOFT		= MakeMaterial(nil,{25, 255, 25, 200})

local sc = 1/GetScale()

local contact_scale=0.020

local function rwr_vtx(x,y,z)	
	return { x*sc,y * sc,z * sc}
end

local num_points=32

local dphi = math.rad(360.0/(1.0*num_points))


local rwr_rad=0.03318
vertices={}
for i = 1, 32 do
	vertices[i]=rwr_vtx(rwr_rad*math.cos(i*dphi),rwr_rad*math.sin(i*dphi),0.0)
end

indices = {}
local j = 1
for i = 0, 29 do
	indices[j] = i + 1
	indices[j+1] = 0
	indices[j+2] = i + 2
	j = j + 3
end




rwr_base               	= CreateElement "ceSimple"
rwr_base.name			= "rwr_base"
rwr_base.init_pos		= {0,0,0}
rwr_base.element_params	= {"RWR_VISIBLE"}
rwr_base.controllers = {{"parameter_in_range",1,0.9,1.1}}
Add(rwr_base)





local radius=0.035*sc
local txtsize = 0.01

local strdefcross={txtsize, txtsize/4,-txtsize/8,0}

local txtsize = 0.007

local strdefsymbol={txtsize, txtsize/4,-txtsize/20,0}


font=MakeFont({used_DXUnicodeFontData = "font_dejavu_lgc_sans_22"},{0, 255, 20, 255})

posx =0
posy = 0
local txt_CP			= CreateElement "ceStringPoly"
txt_CP.name				= "txt_CP"
txt_CP.material			= font
txt_CP.init_pos			= {0,0,0.000}
txt_CP.init_rot			= {0, 0, 0}
txt_CP.alignment		= "CenterCenter"
txt_CP.stringdefs		= strdefcross
txt_CP.h_clip_relation	= h_clip_relations.COMPARE

txt_CP.use_mipfilter	= true
txt_CP.isdraw			= true	
txt_CP.additive_alpha	= true

txt_CP.value       	 	= "+"
txt_CP.element_params	= {"RWR_BRIGHTNESS","RWR_POWER"}
txt_CP.controllers		= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
txt_CP.parent_element	= "rwr_base"
Add(txt_CP)

radius = 0.038*sc
	local   RWR_grid_i 					= CreateElement "ceMeshPoly"
			RWR_grid_i.name 			= "RWR_grid_i"
			RWR_grid_i.primitivetype 	= "triangles"
			set_circle	(RWR_grid_i, radius + 0.005, radius - 0.005, 360, 32)
			RWR_grid_i.material 		= MFCD_GREEN_SOFT
			RWR_grid_i.h_clip_relation= h_clip_relations.COMPARE
			RWR_grid_i.isdraw		 	= true
			RWR_grid_i.use_mipfilter	= true
			RWR_grid_i.parent_element 	= "rwr_base"
			RWR_grid_i.element_params	= {"RWR_BRIGHTNESS","RWR_POWER"}
			RWR_grid_i.controllers 		= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
		Add(RWR_grid_i)


for ia = 1,20 do
	if ia  < 10 then
		i = "_0".. ia .."_"
	else
		i = "_".. ia .."_"
	end
		
			local	RWR_contact			   			= CreateElement "ceSimple"
					RWR_contact.name		   		= "RWR_contact" .. i .. "name"
					RWR_contact.primitivetype		= "triangles"
					RWR_contact.h_clip_relation 	= h_clip_relations.COMPARE
					--RWR_contact.level 				= RWR_DEFAULT_LEVEL
			
					RWR_contact.controllers     	= {
														{"rotate_using_parameter",0,1},
														{"move_up_down_using_parameter"	,2,contact_scale},
														{"parameter_in_range",1,0.1,1.09},
														{"parameter_in_range",4,0.9,1.1}
														
													  } 
					RWR_contact.element_params  	= {	
														"RWR_CONTACT"..i.."AZIMUTH",
														"RWR_CONTACT"..i.."POWER_SYM",
														"RWR_CONTACT"..i.."LOCK_SYM",
														"RWR_BRIGHTNESS",
														"RWR_POWER"
													  }
					RWR_contact.parent_element 		="rwr_base"
					RWR_contact.use_mipfilter	= true
				Add(RWR_contact)
			

			local 	RWR_type_Str	 				= CreateElement "ceStringPoly"
					RWR_type_Str.name			  	= "RWR_type" .. i .. "name"
					RWR_type_Str.material        	= font
					RWR_type_Str.stringdefs      	= strdefsymbol
					RWR_type_Str.alignment       	= "CenterCenter"
					RWR_type_Str.value				= ""
					RWR_type_Str.formats		  	= {"%s"}
					RWR_type_Str.UseBackground		= false
					RWR_type_Str.use_mipfilter 		= true
					RWR_type_Str.h_clip_relation 	= h_clip_relations.COMPARE
					RWR_type_Str.element_params  	= {	
													"RWR_CONTACT" .. i .. "UNIT_TYPE_SYM",
													"RWR_CONTACT" .. i .. "AZIMUTH",
													"RWR_CONTACT" .. i .. "UNIT_TYPE_IS_NUMERIC",
													"RWR_BRIGHTNESS",
												  }
					RWR_type_Str.controllers     	= {	
													{"text_using_parameter",0,0},
													{"rotate_using_parameter",1,-1},
													{"parameter_in_range",2,0.1,0.8},
													{"opacity_using_parameter",3},
												  }		
					RWR_type_Str.parent_element 	= "RWR_contact" .. i .. "name"
				Add(RWR_type_Str)	


			local 	RWR_type_Num	 				= CreateElement "ceStringPoly"
					RWR_type_Num.name			  	= "RWR_type" .. i .. "name_num"
					RWR_type_Num.material        	= font
					RWR_type_Num.stringdefs      	= strdefsymbol
					RWR_type_Num.alignment       	= "CenterCenter"
					RWR_type_Num.formats		  	= {"%.f"}
					RWR_type_Num.UseBackground		= false
					RWR_type_Num.use_mipfilter 		= true
					RWR_type_Num.h_clip_relation 	= h_clip_relations.COMPARE
					RWR_type_Num.element_params  	= {	
													"RWR_CONTACT" .. i .. "UNIT_TYPE_SYM_NUMERIC",
													"RWR_CONTACT" .. i .. "AZIMUTH",
													"RWR_CONTACT" .. i .. "UNIT_TYPE_IS_NUMERIC",
													"RWR_BRIGHTNESS",
												  }
					RWR_type_Num.controllers     	= {	
													{"text_using_parameter",0,0},
													{"rotate_using_parameter",1,-1},
													{"parameter_in_range",2,0.8,1.09},
													{"opacity_using_parameter",3},
												  }		
					RWR_type_Num.parent_element 	= "RWR_contact" .. i .. "name"
				Add(RWR_type_Num)	

				
				x_size 	= 0.13
				y_size  = x_size
				wmul = 0.9
				
				
				
			local 	RWR_lock	 				= CreateElement "ceStringPoly"
					RWR_lock.name			  	= "RWR"..i.."lock"
					RWR_lock.init_pos		  	= {0.0,0.0,0}
					RWR_lock.init_rot		  	= {0.0,0.0,0.0}
					RWR_lock.material    		= MFCD_GREEN_SOFT
					set_circle	(RWR_lock, x_size +0.01, x_size , 360, 32)
					
					RWR_lock.element_params  	= {	"RWR_CONTACT" .. i .. "LOCK_SYM",
													"RWR_CONTACT" .. i .. "AZIMUTH",
													"RWR_BRIGHTNESS",}
					RWR_lock.controllers     	= {	{"parameter_in_range",0,0.4,0.6},
													{"rotate_using_parameter",1,-1},
													{"opacity_using_parameter",2}} 
					RWR_lock.parent_element 	=  "RWR_contact" .. i .. "name"
					RWR_lock.use_mipfilter 		= true
					RWR_lock.h_clip_relation 	= h_clip_relations.COMPARE
					--RWR_lock.level 				= RWR_DEFAULT_LEVEL
				
				Add(RWR_lock)				
	

				
				x_size 	= 0.14
				y_size  = x_size
				wmul = 0.75
				
			local 	RWR_plane	 				= CreateElement "ceStringPoly"
					RWR_plane.name			  	= "RWR_"..i.."_plane"
					RWR_plane.init_pos		  	= {0.0,0.0,0}
					RWR_plane.init_rot		  	= {0.0,0.0,0.0}
					RWR_plane.material    		= MFCD_GREEN_SOFT
					RWR_plane.vertices	   		= {	{-x_size/2 		, y_size*0.7		},
													{0 				, y_size 		},
													{0				, y_size * wmul	},
													{-(x_size*wmul)/2, y_size*0.7		},	
													
													{ x_size/2 		, y_size*0.7		},
													{0 				, y_size 		},
													{0				, y_size * wmul	},
													{ (x_size*wmul)/2, y_size*0.7		},	
												 }		
					RWR_plane.indices	   		= 	{ 	0,1,2,	0,2,3,
														4,5,6,	4,6,7,}
					RWR_plane.element_params  	= {	"RWR_CONTACT" .. i .. "GENERAL_TYPE",
													"RWR_CONTACT" .. i .. "AZIMUTH",
													"RWR_BRIGHTNESS",}
					RWR_plane.controllers     	= {	{"parameter_in_range",0,0.9,1.1},
													{"rotate_using_parameter",1,-1},
													{"opacity_using_parameter",2},} 
					RWR_plane.parent_element 	=  "RWR_contact" .. i .. "name"
					RWR_plane.use_mipfilter 	= true
					RWR_plane.h_clip_relation 	= h_clip_relations.COMPARE
					
				Add(RWR_plane)				
end

--file:write("Done")

