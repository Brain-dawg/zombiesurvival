-- � Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local norm = data:GetNormal()
	local mag = data:GetMagnitude()
	local ent = data:GetEntity()
	if IsValid(ent) and ent:IsPlayer() then
		pos = ent:GetAttachment(1) and ent:GetAttachment(1).Pos
	end

	if not pos then return end
	
	sound.Play("physics/flesh/flesh_bloody_break.wav", pos, 80, math.random(50, 100))

	local emitter = ParticleEmitter(pos)
		for i=1, 16 do
			local particle = emitter:Add("effects/blood_core", pos)
				particle:SetVelocity(norm * 32 + VectorRand() * 16)
				particle:SetDieTime(math.Rand(1.5, 2.5))
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(1)
				particle:SetStartSize(math.random(17, 20))
				particle:SetEndSize(math.random(20, 23))
				particle:SetRoll(180)
				particle:SetDieTime(3)
				particle:SetColor(255, 1, 1)
				particle:SetLighting(true)
		end
		local particle = emitter:Add("effects/blood_core", pos)
			particle:SetVelocity(norm * 32)
			particle:SetDieTime(math.Rand(2.25, 3))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(64)
			particle:SetStartSize(math.random(43, 72))
			particle:SetEndSize(math.random(27, 42))
			particle:SetRoll(180)
			particle:SetColor(255, 1, 1)
			particle:SetLighting(true)
			
			
		local particle = emitter:Add("effects/blood_core", pos)
			particle:SetVelocity(norm * 32)
			particle:SetDieTime(math.Rand(2.25, 3))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(64)
			particle:SetStartSize(math.random(43, 72))
			particle:SetEndSize(math.random(27, 42))
			particle:SetRoll(180)
			particle:SetColor(255, 1, 1)
			particle:SetLighting(true)
	emitter:Finish()

	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetMagnitude(math.random(3, 6))
	util.Effect("bloodstream", effectdata)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
