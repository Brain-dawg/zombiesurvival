-- � Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Pulse Rifle"
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55
	SWEP.IconLetter = "2"
	SWEP.SelectFont = "HL2MPTypeDeath"
	killicon.AddFont("weapon_zs_pulserifle", "HL2MPTypeDeath", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= Model ( "models/weapons/c_IRifle.mdl" )
SWEP.UseHands = true
SWEP.WorldModel			= Model ( "models/weapons/w_IRifle.mdl" )

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "ar2"

SWEP.Primary.Sound			= Sound("Airboat.FireGunHeavy")
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 16.5
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 45
SWEP.Primary.Delay			= 0.2
SWEP.Primary.DefaultClip	= 45
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Cone = 0.08
SWEP.ConeMoving = SWEP.Cone * 1.15
SWEP.ConeCrouching = SWEP.Cone * 0.8

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Tracer = "AR2Tracer"

SWEP.MaxBulletDistance = 2900 -- Uses pulse power, FTW!
SWEP.FirePower = ( SWEP.Primary.Damage * SWEP.Primary.ClipSize )
SWEP.WalkSpeed = 175
SWEP.fired = false
SWEP.lastfire = 0
SWEP.rechargetimer = 0
SWEP.rechargerate = 0.50
SWEP.startcharge = 1
SWEP.MaxClip = 45
SWEP.WalkSpeed = 180

SWEP.IronSightsPos = Vector(-5.88, -9.03, 2.191)
--SWEP.IronSightsPos = Vector(-5.88, -8.03, 2.191)
SWEP.IronSightsAng = Vector(0.625, -0.695, 0)

function SWEP:Think()
	self.BaseClass.Think(self)

	if CLIENT then
		return
	end
	
	-- Show reload animation when player stops firing. Looks cool.
	if self.Owner:KeyDown(IN_ATTACK) then	
		self.fired = true
		self.lastfire = CurTime()
	else
		if self.Owner:IsPlayer() and self.Owner:GetHumanClass() == 4 then
			self.MaxClip = self.Primary.DefaultClip + (self.Primary.DefaultClip * ((HumanClasses[4].Coef[2]*(self.Owner:GetTableScore ("engineer","level")+1)) / 100))
			self.startcharge = 0.4
		else 
			self.MaxClip = self.Primary.DefaultClip
			self.startcharge = 1
		end
			
		if self.lastfire < CurTime()- self.startcharge and self.rechargetimer < CurTime() then
			self.Weapon:SetClip1(math.min(self.MaxClip,self.Weapon:Clip1() + 1))
			if self.Owner:IsPlayer() and self.Owner:HasBought("lastmanstand") and self.Owner:GetHumanClass() == 4 and LASTHUMAN then
				self.rechargerate = 0.1
			else
				self.rechargerate = 0.2
			end
			self.rechargetimer = CurTime() + self.rechargerate 
		end
		if self.fired then 
			self.fired = false
			self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
		end
	end
end

function SWEP:Reload()
	return false
end