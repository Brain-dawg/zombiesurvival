-- � Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

local matBeam = Material("effects/spark")

function EFFECT:Init(data)

	self.StartPos 	= data:GetStart()	
	self.EndPos 	= data:GetOrigin()
	self.Dir 		= self.EndPos - self.StartPos
	self.Entity:SetRenderBoundsWS(self.StartPos, self.EndPos)
	
	self.TracerTime = 0.1

	self.DieTime = CurTime() + self.TracerTime

	sound.Play("weapons/fx/rics/ric4.wav", self.StartPos, 70, math.random(110, 180))
end

function EFFECT:Think()
	return CurTime() < self.DieTime
end

function EFFECT:Render()
	local fDelta = (self.DieTime - CurTime()) / self.TracerTime
	fDelta = math.Clamp( fDelta, 0, 1 )

	render.SetMaterial(matBeam)
	
	local sinWave = math.sin( fDelta * math.pi )
	
	render.DrawBeam(self.EndPos - self.Dir * (fDelta - sinWave * 0.3 ), self.EndPos - self.Dir * (fDelta + sinWave * 0.3 ), 2 + sinWave * 8, 1, 0, color_white)
end
