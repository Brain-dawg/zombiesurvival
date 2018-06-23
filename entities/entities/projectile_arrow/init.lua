-- � Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
	self.DieTime = CurTime() + 7

	local pl = self.Entity:GetOwner()
	local aimvec = pl:GetAimVector()
	pl:DeleteOnRemove(self.Entity)
	self.Entity.Team = pl:Team()
	self.Entity:SetPos(pl:GetShootPos() + pl:GetAimVector() * 3)
	self.Entity:SetAngles(pl:GetAimVector():Angle())
	self.Entity:SetModel("models/Items/CrossbowRounds.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self.Entity:SetTrigger(true)
	self.Entity:DrawShadow (false)
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableDrag(false)
		phys:Wake()
		phys:ApplyForceCenter(aimvec * 20000)
		phys:SetMass(4)
	end
	self.Touched = {}
	self.OriginalAngles = self.Entity:GetAngles()
	pl:EmitSound("weapons/crossbow/bolt_fly4.wav")
end

function ENT:Think()
	if CurTime() > self.DieTime then
		self.Entity:Remove()
	end
end

function ENT:PhysicsCollide(data, phys)
	local hitent = data.HitEntity
	if hitent.SendLua then return end
	phys:EnableMotion(false)
	self.Entity:EmitSound("physics/metal/sawblade_stick"..math.random(1,3)..".wav")
	self.DieTime = CurTime() + 8
	if hitent then
		local hitphys = hitent:GetPhysicsObject()
		if hitphys:IsValid() and hitphys:IsMoveable() then
			self.Entity:SetPos(data.HitPos)
			self.Entity:SetAngles(self.OriginalAngles)
			self.Entity:SetParent(hitent)
		end
	end
	function self:PhysicsCollide() end
	function self:Touch() end
end

function ENT:Touch(ent)
	if self.Touched[tostring(ent)] then return end
	if ent.TakeDamage then
		local owner = self.Entity:GetOwner()
		if not (owner:IsValid() and owner:IsPlayer()) then return end
		if owner:Team() ~= self.Entity.Team then return end
		if owner == ent then return end
		local dmg = math.random(229,330)
		if LASTHUMAN then
		dmg = dmg*2
		end
		ent:TakeDamage(dmg, owner, self.Entity)
		ent:EmitSound("weapons/crossbow/hitbod"..math.random(1,2)..".wav")
		self.Touched[tostring(ent)] = true
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end
