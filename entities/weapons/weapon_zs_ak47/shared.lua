-- � Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "AK47 Rifle"
	SWEP.Author	= "Ywa"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.ViewModelFlip = false
	SWEP.ShowViewModel = true
	
	SWEP.IconLetter = "b"
	killicon.AddFont( "weapon_zs_ak47", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ) )
end

if CHRISTMAS then
	SWEP.VElements = {
		["xms_lights"] = { type = "Model", model = "models/player/items/scout/xms_scattergun.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.073, -8.16, 3.904), angle = Angle(-90, 0, 90), size = Vector(0.55, 0.55, 1.036), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["lights"] = { type = "Model", model = "models/player/items/engineer/xms_wrench.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19.517, 0.296, -3.316), angle = Angle(91.203, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = math.random(0,1), bodygroup = {} }
	}
end

SWEP.MenuSlot 			= 0

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= Model ( "models/weapons/cstrike/c_rif_ak47.mdl" )
SWEP.UseHands = true
SWEP.WorldModel			= Model ( "models/weapons/w_rif_ak47.mdl" )

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.PrintName			= "AK-47"

SWEP.HoldType = "ar2"

SWEP.Primary.Sound			= Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil			= 2.7
SWEP.Primary.Damage			= 19
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 25
SWEP.storeclipsize			= 25
SWEP.Primary.Delay			= 0.12
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= true
--SWEP.Primary.Ammo			= "ar2"
SWEP.Primary.Ammo			= "buckshot"
SWEP.MaxBulletDistance 		= 3500
SWEP.FirePower = ( SWEP.Primary.Damage * SWEP.Primary.ClipSize )

SWEP.Cone = 0.06
SWEP.ConeMoving = SWEP.Cone *1.3
SWEP.ConeCrouching = SWEP.Cone *0.80
SWEP.ConeIron = SWEP.Cone *0.7
SWEP.ConeIronCrouching = SWEP.ConeCrouching *0.7
--SWEP.ConeIronMoving = SWEP.Moving *0.7


SWEP.MaxAmmo			    = 9999


SWEP.WalkSpeed = 195

SWEP.IronSightsPos = Vector(-2, -4, 1.5)
SWEP.IronSightsAng = Vector(0,0,0)
