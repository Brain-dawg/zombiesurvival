-- � Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Barreta"
	SWEP.Author = "Duby"
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	SWEP.ViewModelFOV = 70
	killicon.AddFont( "weapon_zs_elites", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ) )

	SWEP.IgnoreThumbs = true

	SWEP.ViewModelBoneMods = {
	["v_weapon.FIVESEVEN_PARENT"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}


	SWEP.VElements = {
	["Elite"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "", pos = Vector(-0.053, 2.496, -1.752), angle = Angle(-91.276, 0, -90.195), size = Vector(0.777, 0.777, 0.777), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
	
end


SWEP.Base = "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_elite_single.mdl"

SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.Weight				= 5

SWEP.HoldType = "pistol"

SWEP.Primary.Sound			= Sound( "Weapon_ELITE.Single" )
SWEP.Primary.Recoil			= 0.4
SWEP.Primary.Damage			= 35
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 10
SWEP.Primary.Delay			= 0.2
SWEP.Primary.DefaultClip	= 50
SWEP.MaxAmmo			    = 70
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "pistol"
SWEP.WalkSpeed = 190

--SWEP.Cone = 0.04
--SWEP.ConeMoving = SWEP.Cone *1.3
--SWEP.ConeCrouching = SWEP.Cone *0.75
--SWEP.ConeIron = SWEP.Cone *0.8
--SWEP.ConeIronCrouching = SWEP.ConeCrouching *0.80

SWEP.Cone = 0.041
SWEP.ConeMoving = SWEP.Cone *1.3
SWEP.ConeCrouching = SWEP.Cone *0.8
SWEP.ConeIron = SWEP.Cone *0.8
SWEP.ConeIronCrouching = SWEP.ConeCrouching *0.8


SWEP.IronSightsPos = Vector(-5.5,14,2)
SWEP.IronSightsAng = Vector( 0, 0, 0 )