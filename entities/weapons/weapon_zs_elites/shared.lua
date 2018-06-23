AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Dual Elites"			
	SWEP.Author	= "ClavusElite"
	SWEP.Slot = 1
	SWEP.SlotPos = 6
	SWEP.IconLetter = "s"
	killicon.AddFont("weapon_zs_elites", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = false
end

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= Model("models/weapons/cstrike/c_pist_elite.mdl")
SWEP.UseHands = true
SWEP.WorldModel			= Model("models/weapons/w_pist_elite.mdl")

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType = "duel"
SWEP.IronSightsHoldType = "duel"
SWEP.Primary.Sound			= Sound("Weapon_ELITE.Single")
SWEP.Primary.Recoil			= 2
SWEP.Primary.Damage			= 14
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.14
SWEP.Primary.DefaultClip	= 98
SWEP.MaxAmmo			    = 100
SWEP.Primary.Automatic		= true  
SWEP.Primary.Ammo			= "pistol"

SWEP.Cone = 0.051
SWEP.ConeMoving = SWEP.Cone *1.3
SWEP.ConeCrouching = SWEP.Cone *0.8
SWEP.ConeIron = SWEP.Cone *0.8
SWEP.ConeIronCrouching = SWEP.ConeCrouching *0.8
--SWEP.ConeIronMoving = SWEP.Moving *0.8

SWEP.WalkSpeed = 205
--SWEP.IronSightsPos = Vector(0,0,0)
--SWEP.IronSightsAng = Vector(0,0,0)
--SWEP.IronSightsPos = Vector(0, -0.094, 1.205)
--SWEP.IronSightsAng = Vector(0, 0, 0)

--SWEP.IronSightsPos = Vector(0, 1.118, 2.131)
--SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightsPos = Vector(-0, 1.213, 1.019)
SWEP.IronSightsAng = Vector(0, 0, 0)

if CHRISTMAS then
	SWEP.VElements = {
		["xms_lights+"] = { type = "Model", model = "models/player/items/scout/xms_scattergun.mdl", bone = "v_weapon.elite_right", rel = "", pos = Vector(0, -4.803, -3.602), angle = Angle(90, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["xms_lights"] = { type = "Model", model = "models/player/items/scout/xms_scattergun.mdl", bone = "v_weapon.elite_left", rel = "", pos = Vector(0, -5.04, -3.01), angle = Angle(90, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.WElements = {
	["elite1"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "ValveBiped.Bip01_R_Hand", pos = Vector(3.763, 1.161, 2.691), angle = Angle(-0.32, -2.125, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["elite2"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "ValveBiped.Bip01_L_Hand", pos = Vector(3.94, 1.294, -2.597), angle = Angle(0, -19.07, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
	



function SWEP:SendWeaponAnimation()
	self:SendWeaponAnim(self:Clip1() % 2 == 0 and ACT_VM_PRIMARYATTACK or ACT_VM_SECONDARYATTACK)
end

-- KF style Ironsights :D
if CLIENT then
local vec = 1
function SWEP:Think()
	if self:GetIronsights() == true then 
		--[[vec = math.Approach(vec, 1.631, FrameTime())
		self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].scale = Vector(vec,vec,vec)
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].scale = Vector(vec,vec,vec)]]
		self.ViewModelBoneMods = {
["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-4.817, 2.815, 4.35), angle = Angle(0, 0, 0) },
["v_weapon.elite_right"] = { scale = Vector(1, 1, 1), pos = Vector(-4.224, 3.921, 4.008), angle = Angle(0, 0, 0) },
["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-5.11, 2.927, -3.945), angle = Angle(0, 0, 0) },
["v_weapon.elite_left"] = { scale = Vector(1, 1, 1), pos = Vector(-3.757, -4, 3.895), angle = Angle(0, 0, 0) }
}
	elseif self:GetIronsights() == false or self.Weapon:Clip1() <= 1 then
		--[[vec = math.Approach(vec,1, FrameTime())
		self.ViewModelBoneMods["ValveBiped.Bip01_L_UpperArm"].scale = Vector(vec,vec,vec)
		self.ViewModelBoneMods["ValveBiped.Bip01_R_UpperArm"].scale = Vector(vec,vec,vec)]]
		self.ViewModelBoneMods = {}
	end
end
end
--[==[
function SWEP:OnDeploy()
	
	self.Owner:StopAllLuaAnimations()
	self.Owner:SetLuaAnimation("ElitesHoldtype")

	if CLIENT then
		MakeNewArms(self)
	end
	
end

function SWEP:Holster()
	self:SetIronsights( false ) 
	self.Owner:StopLuaAnimation("ElitesHoldtype") 
	
	
	return true
end

function SWEP:OnRemove()

    self.Owner:StopLuaAnimation("ElitesHoldtype")     

    if CLIENT then
        self:RemoveModels()
		
		RemoveNewArms(self)
    end
end
]==]
--Register the animation------------

RegisterLuaAnimation('ElitesHoldtype', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 39,
					RR = 360,
					RF = 55
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = 5
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RF = 5
				},
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -10,
					RR = -31,
					RF = 10
				}
			},
			FrameRate = 1
		}
	},
	Type = TYPE_POSTURE
})
