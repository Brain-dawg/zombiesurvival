if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.Base				= "weapon_zs_base_dummy"

SWEP.HoldType = "slam"

if ( CLIENT ) then
	SWEP.PrintName = "Dangerous Gas Can"
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFlip = true

	
	killicon.AddFont( "weapon_zs_pickup_gascan", "HL2MPTypeDeath", "9", Color(255, 255, 255, 255 ) )
	
	SWEP.NoHUD = true
	
	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = false
	SWEP.IgnoreBonemerge = true
	
	SWEP.IgnoreThumbs = true

	
end

SWEP.Author = "NECROSSIN"

SWEP.ViewModel = "models/weapons/v_c4.mdl"
SWEP.WorldModel = "models/props_junk/metalgascan.mdl"



SWEP.Slot = 5
SWEP.SlotPos = 1 

-- SWEP.Info = ""

SWEP.Primary.ClipSize =1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 2.0

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 0.15

SWEP.WalkSpeed = 160

function SWEP:InitializeClientsideModels()
	
	self.ViewModelBoneMods = {
		["v_weapon.c4"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
	}

	self.VElements = {
		["gascan"] = { type = "Model", model = "models/props_junk/metalgascan.mdl", bone = "v_weapon.c4", rel = "", pos = Vector(-2.712, 0.075, 0), angle = Angle(-2.218, 91.569, 0), size = Vector(0.344, 0.344, 0.344), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	self.WElements = {
		["gascan"] = { type = "Model", model = "models/props_junk/metalgascan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.539, 6.181, -1.65), angle = Angle(139.694, 180, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
end

function SWEP:OnDeploy()

	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
end

function SWEP:PrimaryAttack()
	if self.Owner.KnockedDown or self.Owner.IsHolding and self.Owner:IsHolding() then return end
	
	if SERVER then		
		if self and self:IsValid() then
			DropWeapon(self.Owner)
		end
	end
end

	
function SWEP:Reload() 
	return false
end  
 
function SWEP:SecondaryAttack()
return false
end 


function SWEP:_OnDrop()
	if SERVER then
		if self and self:IsValid() then
			
			local can = ents.Create("pickup_gascan")
			local Force = 300
			
			local v = self.Owner:GetShootPos()
				v = v + self.Owner:GetForward() * 4
				v = v + self.Owner:GetRight() * 8
				v = v + self.Owner:GetUp() * -3
			can:SetPos(v)
			--can:SetAngles( self.Owner:GetAimVector():Angle() )
			can:Spawn()
			
			local Phys = can:GetPhysicsObject()
			Phys:SetVelocity((self.Owner:GetAimVector()+Vector(0,0,0.5)) * Force)
			
			self.UsedCan = true
			
			self:Remove()
		end
	end
end