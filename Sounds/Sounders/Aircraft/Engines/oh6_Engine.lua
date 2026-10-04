offsets = {
	core	= 0,
	fan		= 0,
	turb	= 0,
	jet		= 0,
	around	= 0,
}

engine = {number = 0}
local played_since_firstflame = false

function engine:new()
	o = {}
	setmetatable(o, self)
	self.__index = self
	o.number = 1
	return o
end

function engine:init(number_, host)
	self:initNames(number_)
	self:createSounds(number_, host)
end

function engine:initNames()
	--self.engine_name		= "Aircrafts/Engines/OH6/oh6_FrontEngine" 
	self.rotor_name		= "External/oh6_ExteriorRotor"
	self.blade_flap_name = "External/oh6_BladeSlap"
end

function engine:createSounds(number_, host)
	self.number = number_

	if self.number == 2 then
		if self.rotor_name ~= nil then
			self.sndRotor = ED_AudioAPI.createSource(host, self.rotor_name)
		end

		if self.blade_flap_name ~= nil then
			self.sndFlapping = ED_AudioAPI.createSource(host, self.blade_flap_name)
		end
	else
		if self.engine_name ~= nil then
			self.sndEngine = ED_AudioAPI.createSource(host, self.engine_name)
		end
	end
end

function engine:initCptNames()
	self.rotorCpt   = "Cockpit/oh6_InteriorRotor"
	self.bladeSlapCpt   = "Cockpit/oh6_Interior_BladeSlap"
	self.combustionCpt   = "Cockpit/oh6_InteriorEngineCombustion"
	self.starterContCpt   = "Cockpit/oh6_InteriorEngineStarterCont"
end

function engine:createSoundsCpt(hostCpt)
	if self.number == 1 then
		if self.combustionCpt ~= nil then
			self.sndCptCombustion = ED_AudioAPI.createSource(hostCpt, self.combustionCpt)
		end

		if self.starterContCpt ~= nil then
			self.sndCptStarterCont = ED_AudioAPI.createSource(hostCpt, self.starterContCpt)
		end

		if self.starterContCpt ~= nil then
			self.sndCptStarterCont = ED_AudioAPI.createSource(hostCpt, self.starterContCpt)
		end
	else
		if self.rotorCpt ~= nil then
			self.sndRotorCpt = ED_AudioAPI.createSource(hostCpt, self.rotorCpt)
		end

		if self.bladeSlapCpt ~= nil then
			self.sndCptBladeSlap = ED_AudioAPI.createSource(hostCpt, self.bladeSlapCpt)
		end
	end
end

function engine:destroySoundsCpt()
	if self.sndRotorCpt ~= nil then
		ED_AudioAPI.destroySource(self.sndRotorCpt)
		self.sndRotorCpt = nil
	end

	if self.starterContCpt ~= nil then
		ED_AudioAPI.destroySource(self.sndCptStarterCont)
		self.sndCptStarterCont = nil
	end

	if self.combustionCpt ~= nil then
		ED_AudioAPI.destroySource(self.sndCptCombustion)
		self.sndCptCombustion = nil
	end

	if self.bladeSlapCpt ~= nil then
		ED_AudioAPI.destroySource(self.sndCptBladeSlap)
		self.sndCptBladeSlap = nil
	end
	
end


function engine:DBGstop()
	stopSRC = function(src)
		if src ~= nil then
			if ED_AudioAPI.isSourcePlaying(src) then
				ED_AudioAPI.stopSource(src)
			end
		end
	end
	
	stopSRC(self.sndRotor)
	stopSRC(self.sndEngine)
	stopSRC(self.sndFlapping)
			
	stopSRC(self.sndRotorCpt)
	stopSRC(self.sndCptCombustion)
	stopSRC(self.sndCptStarterCont)
	stopSRC(self.sndCptBladeSlap)
end

function engine:controlSound(snd, pitch, gain, offsetKey)
	if gain < 0.01 then
		ED_AudioAPI.stopSource(snd)
	elseif gain >= 0.01 then

		ED_AudioAPI.setSourcePitch(snd, pitch)
		ED_AudioAPI.setSourceGain(snd, gain)
		
		if not ED_AudioAPI.isSourcePlaying(snd) then
			if offsetKey ~= nil then
				if offsets[offsetKey] ~= nil then
					ED_AudioAPI.playSourceLooped(snd, offsets[offsetKey])
					offsets[offsetKey] = offsets[offsetKey] + 0.5
				end
			else
				ED_AudioAPI.playSourceLooped(snd)
			end
		end
	end
end


function engine:controlStarterSound(n1_rpm)
	local gain_full = 0.08
	local rpm1=0.01
	local rpm2=0.7
	local b=(gain_full-1.0)/(rpm2-rpm1)
	local gain =  1.0-b*rpm1+b*n1_rpm
	if n1_rpm > rpm2 then 
		gain = gain_full
	end
	if n1_rpm < rpm1 then 
		gain = 1.0
	end
	gain = gain*gain
	if n1_rpm < 0.001 then 
		gain = 0
		n1_rpm =0.001
	end 
	ED_AudioAPI.setSourcePitch(self.sndCptStarterCont,n1_rpm)
	ED_AudioAPI.setSourceGain(self.sndCptStarterCont, 15.0*gain)
	if not ED_AudioAPI.isSourcePlaying(self.sndCptStarterCont) then
		ED_AudioAPI.playSourceLooped(self.sndCptStarterCont, 0)
	end
end

function engine:controlCombustionSound(flame, n1_rpm)
	
	if flame <0.5 then
		played_since_firstflame = false
	end
	
	gain =  0.5*(1.-n1_rpm/0.6)*(1.-n1_rpm/0.6)*(1.-n1_rpm/0.6)
	if n1_rpm >=0.6 then
		gain =0.0
	end
	
	
	ED_AudioAPI.setSourceGain(self.sndCptStarterCont, gain)
	if not ED_AudioAPI.isSourcePlaying(self.sndCptCombustion) then
		if flame >0 and not played_since_firstflame and n1_rpm < 0.2 then 
			played_since_firstflame = true
			ED_AudioAPI.playSourceOnce(self.sndCptCombustion, 0)
		end
	end
end


function engine:update(coreRPM, fanRPM, turbPower, thrust, flame, vTrue, params)

	local corePitch = coreRPM
	local coreGain = math.sqrt(coreRPM)
	
	if self.sndRotor ~= nil then
		self:controlSound(self.sndRotor, corePitch, coreGain, "core")
	end
	
	if self.sndEngine ~= nil then
		self:controlSound(self.sndEngine, corePitch, coreGain, "core")
	end
	
	
	if self.sndFlapping ~= nil then
		
		local flapGain = 3.0*fanRPM
		if flapGain>1.0 then
			flapGain=1.0
		end
		if flapGain<0.0 then 
			flapGain=0.0
		end
		if corePitch<0.01 then 
			corePitch=0.01
		end
		flapGain=flapGain * corePitch*3.0
		self:controlSound(self.sndFlapping, corePitch, flapGain, "core")
	end
	
	if 	self.sndCptBladeSlap ~= nil then
		local flapGain = 4.0 * fanRPM
		if flapGain>1.0 then
			flapGain=1.0
		end
		flapGain = flapGain * corePitch * 3.0

		if flapGain<0.0 then 
			flapGain=0.0
		end
		self:controlSound(self.sndCptBladeSlap, corePitch, flapGain, "core")
		--self:controlSound(self.sndCptBladeSlap, 1, 1, "core")
	end

	if self.sndRotorCpt ~= nil then
		if coreRPM<0.0 then coreRPM = 0.0 end
		local pitch = coreRPM
		local gain = 0.8 * math.sqrt(coreRPM)
		self:controlSound(self.sndRotorCpt, pitch, gain)
	end

	if self.sndCptCombustion ~= nil then
		self:controlCombustionSound(flame, fanRPM)
	end

	if self.sndCptStarterCont ~= nil then
		self:controlStarterSound(fanRPM)
	end

end
