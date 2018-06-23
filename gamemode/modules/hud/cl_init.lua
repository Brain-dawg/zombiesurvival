-- � Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

--Function table
hud = {}

include("cl_human.lua")
include("cl_human_friends.lua")
include("cl_zombie.lua")

local nextLevelKeySwitch, currentLevelKey = RealTime()+10, false

hud.HumanElementBackground = Material("mrgreen/hud/hudbackground.png")
hud.HumanTopBackground = Material("mrgreen/hud/hud_background_top_h.png")
hud.ZombieTopBackground = Material("mrgreen/hud/hud_background_top_z.png")
hud.HumanHudBackground = Material("mrgreen/hud/hudbackgroundnew.png")
hud.ZombieHudBackground = Material("mrgreen/hud/hudbackgroundnew_zombie.png")

local PlrData = {
	GreenCoins = 0,
	Rank = 1,
	NextRankPerc = 0
}
local NextPlrDataCache = 0
local function RecachePlayerData()
	--5 seconds till next cache
	NextPlrDataCache = RealTime() + 5

	local RequiredXP = MySelf:NextRankXP() - MySelf:CurRankXP()
	local CurrentXP = MySelf:GetXP() - MySelf:CurRankXP()

	PlrData = {
		GreenCoins = MySelf:GreenCoins(),
		Rank = MySelf:GetRank(),
		NextRankPerc = math.Round((CurrentXP / RequiredXP) * 100)
	}
end

--[==[----------------------------------------
	 Initialize fonts we need
-----------------------------------------]==]
function hud.InitFonts()
	-- Health indication font
	surface.CreateFontLegacy( "Arial", ScreenScale( 7.6 ), 600, true, true, "HUDBetaHealth" ) -- 14.6
	
	-- Level font
	surface.CreateFontLegacy( "Arial", ScreenScale( 7.6 ), 600, true, true, "HUDBetaLevel" ) -- 14.6
	
	-- Level font 4:3
	surface.CreateFontLegacy( "Arial", ScreenScale( 7.3 ), 600, true, true, "HUDBetaLevelNormal" ) -- 14.6
	
	-- Kills icon font
	surface.CreateFontLegacy( "Arial", ScreenScale( 21.6 ), 500, true, true, "HUDBetaKills" ) -- 44.6

	
	-- Ammo regen icon font
	surface.CreateFontLegacy( "csd", ScreenScale( 17.6 ), 500, true, true, "HUDBetaAmmo" ) -- 36/6
	
	-- Kills and regen text font
	surface.CreateFontLegacy( "Arial", ScreenScale( 11 ), 500, true, true, "HUDBetaStats" ) -- 16

	-- Small level showout
	surface.CreateFontLegacy( "Arial", ScreenScale( 7 ), 700, true, true, "HUDBetaCorner" ) -- 14
 -- ssNewAmmoFont13 ssNewAmmoFont5 HUDBetaZombieCount HUDBetaKills HUDBetaHeader
	-- How much to survive font
	surface.CreateFontLegacy( "Arial", ScreenScale( 15 ), 500, true, true, "HUDBetaHeader" )
	-- Zombie count
	surface.CreateFontLegacy( "Arial", ScreenScale( 25 ), 700, true, true, "HUDBetaZombieCount" )

	-- Infliction percentage font
	surface.CreateFontLegacy( "Arial", ScreenScale( 10 ), 700, true, true, "HUDBetaInfliction" )

	-- Right upper box text font
	surface.CreateFontLegacy( "Arial", ScreenScale( 9.6 ), 700, true, true, "HUDBetaRightBox" )

	surface.CreateFontLegacy( "Arial", ScreenScale( 7 ), 700, true, false, "ssNewAmmoFont5" )
	surface.CreateFontLegacy( "Arial", ScreenScale( 7.6 ), 700, true, false, "ssNewAmmoFont7" )
	surface.CreateFontLegacy( "Arial", ScreenScale( 7 ), 700, true, false, "ssNewAmmoFont6.5" )
	surface.CreateFontLegacy( "Arial", ScreenScale( 9 ), 700, true, false, "ssNewAmmoFont9" )
	surface.CreateFontLegacy( "Arial", ScreenScale( 16 ), 700, true, false, "ssNewAmmoFont13" )
	surface.CreateFontLegacy( "Arial", ScreenScale( 20 ), 700, true, false, "ssNewAmmoFont20" )	
	
	--Undead HUD font
	surface.CreateFontLegacy("Face Your Fears", ScreenScale(9), 400, true, true, "NewZombieFont7",false, true)
	surface.CreateFontLegacy("Face Your Fears", ScreenScale(10), 400, true, true, "NewZombieFont10",false, true)
	surface.CreateFontLegacy("Face Your Fears", ScreenScale(13), 400, true, true, "NewZombieFont13",false, true)
	surface.CreateFontLegacy("Face Your Fears", ScreenScale(14), 400, true, true, "NewZombieFont14",false, true)
	surface.CreateFontLegacy("Face Your Fears", ScreenScale(15), 400, true, true, "NewZombieFont15",false, true)
	surface.CreateFontLegacy("Face Your Fears", ScreenScale(17), 400, true, true, "NewZombieFont17",false, true)
	surface.CreateFontLegacy("Face Your Fears", ScreenScale(19), 400, true, true, "NewZombieFont19",false, true)
	surface.CreateFontLegacy("Face Your Fears", ScreenScale(23), 400, true, true, "NewZombieFont23",false, true)
	surface.CreateFontLegacy("Face Your Fears", ScreenScale(27), 400, true, true, "NewZombieFont27",false, true)
	surface.CreateFontLegacy("Face Your Fears", ScreenScale(35), 400, true, true, "NewZombieFont35",false, true)
end
hook.Add("Initialize", "hud.InitFonts", hud.InitFonts)

local matDangerSign = surface.GetTextureID ( "zombiesurvival/hud/danger_sign" )

hud.BossBackground = surface.GetTextureID ( "zombiesurvival/hud/splash_top" )
hud.texGradDown = surface.GetTextureID("VGUI/gradient_down")
function hud.DrawBossHealth()
	if not GAMEMODE:IsBossAlive() then
		return
	end

	local Boss = GAMEMODE:GetBossZombie()
	if not IsValid(Boss) then
		return
	end

	local BW,BH = ScaleW(440), ScaleW(440)
	local BX,BY = w/2-BW/2, 20
	
	local BarW,BarH = BW*0.75, ScaleH(36)
	local BarX,BarY = w/2-BarW/2, ScaleH(120)
	
	surface.SetDrawColor( 0, 0, 0, 150)
	surface.DrawRect(BarX,BarY,BarW,BarH)
	surface.DrawRect(BarX+5, BarY+5, BarW-10, BarH-10)
	
	surface.SetDrawColor(125,29,21,255)
	
	local health = Boss:Health() or 0
		
	local TX,TY = BarX+BarW/5,BarY
	local str = (ZombieClasses[Boss:GetZombieClass()].Name or Boss:Name())
	local EndTime = GAMEMODE:GetBossEndTime()
	if CurTime() <= EndTime then
		local timeLeft = EndTime - CurTime()
		str = str .." - ".. ToMinutesSeconds(timeLeft)
	end
	draw.SimpleText(str, "NewZombieFont27", ScrW()/2,TY, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		
	local dif = math.Clamp(health / Boss:GetMaximumHealth(),0,1)
		
	surface.SetTexture(hud.texGradDown)
	surface.DrawTexturedRect(BarX+5, BarY+5, (BarW-10)*dif, BarH-10 )
end

local function DrawRoundTime(DescriptionFont, ValueFont)
	--Initialize variables
	local startX, keyStartY, valueStartY = ScrW()/2, ScaleH(15), ScaleH(55)
	local timeLeft, valueColor = 0, Color(255,255,255,255)

	local keyText
	if MySelf:IsZombie() then
		keyText = "ROUND TIME"
	else
		keyText = "EVACUATION TIME"
	end

	--Preparation (warmup)
	if CurTime() <= WARMUPTIME then
		keyText = "PREPARATION TIME"
		if MySelf:IsHuman() then
			draw.SimpleText("Get close to the Undead spawn to be sacrificed", "ssNewAmmoFont9", startX, keyStartY+100, Color(255,90,90,210), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		timeLeft = math.max(0, WARMUPTIME - CurTime())

		if timeLeft < 10 then
			local glow = math.sin(CurTime() * 8) * 200 + 255

			valueColor.g, valueColor.b = glow, glow

			if lastwarntim ~= math.ceil(timeLeft) then
				lastwarntim = math.ceil(timeLeft)
				if 0 < lastwarntim then
					surface.PlaySound(Sound("mrgreen/ui/menu_countdown.wav"))
				end
			end
		end
	else
		timeLeft = math.max(0, ROUNDTIME - CurTime())
	end
	
	--Draw time
	draw.SimpleText(keyText, DescriptionFont, startX, keyStartY, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(ToMinutesSeconds(timeLeft + 1), ValueFont, startX, valueStartY, valueColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local NextTeamRefresh, CachedHumans, CachedZombies = 0, 0, 0
function hud.DrawStats()
	--Recache team counts
	if RealTime() > NextTeamRefresh then
		CachedHumans = team.NumPlayers(TEAM_HUMAN)
		CachedZombies = team.NumPlayers(TEAM_UNDEAD)
		NextTeamRefresh = RealTime() + 1
	end

	--Define vars depending on team
	local TeamColor, DescriptionFont, ValueFont, ValueBigFont
	if MySelf:IsZombie() then
		surface.SetMaterial(hud.ZombieTopBackground)
		surface.SetDrawColor(100, 0, 0, 260)
		TeamColor = Color(255, 0, 0, 170)
		DescriptionFont = "NewZombieFont15"
		ValueFont = "NewZombieFont23"
		ValueBigFont = "NewZombieFont35"
	else
		surface.SetMaterial(hud.HumanTopBackground)
		surface.SetDrawColor(255, 255, 255, 190)
		DescriptionFont = "ssNewAmmoFont5"
		ValueFont = "ssNewAmmoFont13"
		ValueBigFont = "HUDBetaZombieCount"
	end
	surface.DrawTexturedRect(ScaleW(200), ScaleH(-64), ScaleW(920), ScaleH(341))

	--Text drawing
	--surface.SetFont("ssNewAmmoFont6.5")

	--Define Y-axis positions of keys and values
	local keysStartY, valuesStartY = ScaleH(15), ScaleH(55)

	--Draw Survivor team count
	local startX = ScaleW(430)
	draw.SimpleText("SURVIVORS", DescriptionFont, startX, keysStartY, Color(255,255,255,180), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleTextOutlined(CachedHumans, ValueFont, startX, valuesStartY, Color(255,255,255,180), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, TeamColor or Color(29, 87, 135, 170))

	--Draw Undead team count
	local startX = ScaleW(530)	
	draw.SimpleText("ZOMBIES", DescriptionFont, startX, keysStartY, Color(255,255,255,180), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleTextOutlined(CachedZombies, ValueFont,startX, valuesStartY, Color(255,255,255,180), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, TeamColor or Color(137, 30, 30, 170))

	--Draw GreenCoins
	local startX = 20+ScaleW(780)
	draw.SimpleText("GREENCOINS", DescriptionFont, startX, keysStartY, Color(255,255,255,180), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleTextOutlined(PlrData.GreenCoins, ValueFont, startX, valuesStartY, Color(255,255,255,180), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, TeamColor or Color(29, 135, 49, 170))

	--Handle level key switching for current level and level completion percentage
	if nextLevelKeySwitch <= RealTime() then
		currentLevelKey = not currentLevelKey
		nextLevelKeySwitch = RealTime()+10
	end

	local TopText, ValueText
	if currentLevelKey then
		TopText = "LEVEL"
		ValueText = PlrData.Rank
	else
		TopText = "NEXT LEVEL"
		ValueText = PlrData.NextRankPerc .."%"
	end

	--Draw current level
	local startX = ScaleW(900)
	draw.SimpleText(TopText, DescriptionFont, startX, keysStartY, Color(255,255,255,180), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleTextOutlined(ValueText, ValueFont, startX, valuesStartY, Color(255,255,255,180), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, TeamColor or Color(29, 135, 49, 170))

	--Draw round time
	DrawRoundTime(DescriptionFont, ValueBigFont)
end

local function DrawHUD()
	if not IsValid(MySelf) or ENDROUND or not MySelf.ReadySQL or not MySelf:Alive() or IsClassesMenuOpen() or util.tobool(GetConVarNumber("zs_hidehud")) then
		return
	end

	--Cache
	if RealTime() >= NextPlrDataCache then
		RecachePlayerData()
	end

	--Pick HUD to display depending on team
	if MySelf:IsHuman() then
		hud.DrawStats()
		hud.DrawHumanHUD()
	elseif MySelf:IsZombie() then
		hud.DrawStats()
		hud.DrawZombieHUD()
	end

	hud.DrawBossHealth()
end
hook.Add("HUDPaint", "hud.DrawHUD", DrawHUD)