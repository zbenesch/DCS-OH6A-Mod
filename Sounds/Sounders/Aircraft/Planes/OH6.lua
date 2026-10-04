dofile("Aircraft/oh6_Plane.lua")

OH6 = plane:new()

dofile("Aircraft/Engines/oh6_Engine.lua")


function OH6:createEngines()

	for i = 1,2 do
		self.engines[i] = engine:new()
		self.engines[i]:init(i, host)
		self.engines[i]:initCptNames()
	end

end

OH6:createEngines()

function onUpdate(params)
	OH6:onUpdate(params)
end