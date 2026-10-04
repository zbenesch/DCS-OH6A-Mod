-- Class/type of objects added; They will appear as "Cargos" inside "Static Objects" in ME

local function add_cargo(f)
	if(f) then
		f.shape_table_data = 
		{
			{
				file  	    = f.ShapeName,
				life		= f.Life,
				username    = f.Name,
				desrt       = f.ShapeNameDestr,
			}
		}
		if f.ShapeNameDestr then
			f.shape_table_data[#f.shape_table_data + 1] = 
			{
				name  = f.ShapeName,
				file  = f.ShapeNameDestr,	
			}
		end
		
		
		f.mapclasskey 	= "P0091000352";
		f.attribute 		= {"Cargos"}; 
		f.category 		= 'Cargo';
		
		add_surface_unit(f)
		GT = nil;
	else
		error("Can't add cargo")
	end;
end


--Cargo Object List
----------------------------------------------


add_cargo({
Name 		 	=  "cargo_oh6_mre", 
DisplayName  	=  _("(OH6A)MRE"), 
ShapeName	 	=   "cargo_oh6_mre",
ShapeNameDestr = "ab-212_cargo_dam",
Life		 	 	=  100,
Rate		 	=  1,
canExplode		= false,
mass			= 190,
minMass		= 100,
maxMass		= 300,
couldCargo		= true,
topdown_view 	=  topdown_view,
})

add_cargo({
Name 		 	=  "cargo_oh6_ammo", 
DisplayName  	=  _("(OH6A)Ammo"), 
ShapeName	 	=   "cargo_oh6_ammo",
ShapeNameDestr = "ab-212_cargo_dam",
Life		 	 	=  100,
Rate		 	=  1,
canExplode		= true,
mass			= 290,
minMass		= 100,
maxMass		= 390,
couldCargo		= true,
topdown_view 	=  topdown_view,
})

add_cargo({
Name 		 	=  "cargo_oh6_mixed", 
DisplayName  	=  _("(OH6A)Mixed Cargo"), 
ShapeName	 	=   "cargo_oh6_mixed",
ShapeNameDestr = "ab-212_cargo_dam",
Life		 	 	=  100,
Rate		 	=  1,
canExplode		= false,
mass			= 150,
minMass		= 70,
maxMass		= 200,
couldCargo		= true,
topdown_view 	=  topdown_view,
})



add_cargo({
Name 		 	=  "cargo_oh6_animals", 
DisplayName  	=  _("(OH6A)Animals"), 
ShapeName	 	=   "cargo_oh6_animals",
ShapeNameDestr = "ab-212_cargo_dam",
Life		 	 	=  100,
Rate		 	=  1,
canExplode		= false,
mass			= 150,
minMass		= 100,
maxMass		= 300,
couldCargo		= true,
topdown_view 	=  topdown_view,
})

add_cargo({
Name 		 	=  "cargo_oh6_fuel", 
DisplayName  	=  _("(OH6A)Fuel"), 
ShapeName	 	=   "cargo_oh6_fuel",
ShapeNameDestr = "ab-212_cargo_dam",
Life		 	 	=  100,
Rate		 	=  1,
canExplode		= true,
mass			= 150,
minMass		= 100,
maxMass		= 300,
couldCargo		= true,
topdown_view 	=  topdown_view,
})

add_cargo({
Name 		 	=  "cargo_oh6_fbi", 
DisplayName  	=  _("(OH6A)Agents"), 
ShapeName	 	=   "cargo_oh6_fbi",
ShapeNameDestr = "ab-212_cargo_dam",
Life		 	 	=  100,
Rate		 	=  1,
canExplode		= false,
mass			= 250,
minMass		= 200,
maxMass		= 300,
couldCargo		= true,
topdown_view 	=  topdown_view,
})

add_cargo({
Name 		 	=  "cargo_oh6_pax", 
DisplayName  	=  _("(OH6A)Passengers"), 
ShapeName	 	=   "cargo_oh6_pax",
ShapeNameDestr = "ab-212_cargo_dam",
Life		 	 	=  100,
Rate		 	=  1,
canExplode		= false,
mass			= 250,
minMass		= 200,
maxMass		= 300,
couldCargo		= true,
topdown_view 	=  topdown_view,
})