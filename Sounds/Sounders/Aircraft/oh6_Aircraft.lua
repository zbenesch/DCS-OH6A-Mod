
function updateHost(host, params)
	ED_AudioAPI.setHostPosition(host, params.posx, params.posy, params.posz)
	ED_AudioAPI.setHostOrientation(host, params.orienta, params.orientb, params.orientc, params.orientd)
	ED_AudioAPI.setHostVelocity(host, params.velx, params.vely, params.velz)
	ED_AudioAPI.setHostTimestamp(host, params.timestamp)
end

host = ED_AudioAPI.createHost(ED_AudioAPI.ContextWorld, "Aircraft")
ED_AudioAPI.setHostSonicBoom(host, ED_AudioAPI.SonicBoomAircraft, 1.0)

aircraft = {engines = {}, cockpit = {}}
aircraft.cockpit.initialized = false
aircraft.cockpit.hostPosition = {-0.7, -0.5, 0}

function aircraft:new()
	o = {}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- stub for now
function aircraft:createEngines()
	
end


function aircraft:createEnginesCpt(hostCpt)
	for k, v in pairs(self.engines) do
		v:createSoundsCpt(hostCpt)
	end
end

function aircraft:destroyEnginesCpt()
	for k, v in pairs(self.engines) do
		v:destroySoundsCpt()
	end
end

function aircraft:createCockpit()
	self.cockpit.host           = ED_AudioAPI.createHost(ED_AudioAPI.ContextCockpit, "cockpitMain")
	ED_AudioAPI.setHostPosition(self.cockpit.host, self.cockpit.hostPosition[1], self.cockpit.hostPosition[2], self.cockpit.hostPosition[3])
	self.cockpit.hostHeadphones = ED_AudioAPI.createHost(ED_AudioAPI.ContextHeadphones, "cockpitHeadphones")
	self.cockpit.hostCpt2D      = ED_AudioAPI.createHost(ED_AudioAPI.ContextCockpit2D, "cockpit2D")
	
	self.cockpit.initialized = true
	
	self:createEnginesCpt(self.cockpit.host)
	
end

function aircraft:releaseCockpit()
	self:destroyEnginesCpt()
	
	ED_AudioAPI.destroyHost(self.cockpit.host)
	ED_AudioAPI.destroyHost(self.cockpit.hostHeadphones)
	ED_AudioAPI.destroyHost(self.cockpit.hostCpt2D)

	self.cockpit.initialized = false
end

local gBreathActive = false


function aircraft:onInit(params)
	params.pilotGforceFiltered = 1
end

function aircraft:onUpdate(params)
	updateHost(host, params)

	for k, v in pairs(self.engines) do
		if params.DBG_playEngines == 0 then
			v:DBGstop()
		else
			v:update(params["coreRPM_"..k], params["fanRPM_"..k], params["turbPower_"..k], params["thrust_"..k], params["flame_"..k], params["vTrue"])
		end
	end
	
--	if self.cockpit.initialized then

--	end
end

function onEvent_cockpitCreate()
	aircraft:createCockpit()
end

function onEvent_cockpitDestroy()
	aircraft:releaseCockpit()
end

function onUpdate(params)
	aircraft:onUpdate(params)
end
