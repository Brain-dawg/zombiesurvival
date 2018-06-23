-- � Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

local texGradient = surface.GetTextureID("gui/center_gradient")

local function SortFunc(a, b)
	return a:GetScore() > b:GetScore()
end
local colBackground = Color(10, 10, 10, 220)

local function AddScoreboardItem(ply, list)
	MainLabel = MainLabel or {}

	if MainLabel[ply] then
		return
	end
	
	MainLabel[ply] = vgui.Create( "DLabel")
	MainLabel[ply].Player = ply
	
	MainLabel[ply]:SetSize(scoreboard_w,40)
	MainLabel[ply]:SetText("")
	
	MainLabel[ply].AvatarButton = MainLabel[ply]:Add( "DButton" )
	MainLabel[ply].AvatarButton:Dock( LEFT )
	MainLabel[ply].AvatarButton:DockMargin( 5, 4, 0, 4 )
	MainLabel[ply].AvatarButton:SetSize( 32, 32 )
	MainLabel[ply].AvatarButton:SetText("")
	MainLabel[ply].AvatarButton.DoClick = function()
		MainLabel[ply].Player:ShowProfile()
	end
	
	MainLabel[ply].Avatar = vgui.Create( "AvatarImage", MainLabel[ply].AvatarButton)
	MainLabel[ply].Avatar:SetSize(32, 32)
	MainLabel[ply].Avatar:SetMouseInputEnabled(false)	
	
	MainLabel[ply].Avatar:SetPlayer(ply)
	
	MainLabel[ply].Name	= MainLabel[ply]:Add("DLabel")
	MainLabel[ply].Name:Dock(FILL)
	MainLabel[ply].Name:SetText("")
	-- MainLabel[ply].Name:SetFont( "ArialBoldFive" )
	MainLabel[ply].Name:DockMargin(15, 0, 0, 0)
	MainLabel[ply].Name.Paint = function()		
		if not IsValid(ply) then
			return
		end
		
		local col = team.GetColor(ply:Team())
		draw.SimpleTextOutlined(ply:Nick() , "ArialBoldFive", 0,MainLabel[ply].Name:GetTall()/2, col, TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER,1,Color(0,0,0,255))
	end
	
	MainLabel[ply].Mute = MainLabel[ply]:Add( "DImageButton" )
	MainLabel[ply].Mute:SetSize( 32, 32 )
	MainLabel[ply].Mute:Dock( RIGHT )
	MainLabel[ply].Mute:DockMargin( 0, 4, 2, 4 )

	MainLabel[ply].Ping	= MainLabel[ply]:Add( "DLabel" )
	MainLabel[ply].Ping:Dock( RIGHT )
	MainLabel[ply].Ping:SetText("")
	MainLabel[ply].Ping:SetWidth( 50 )
	-- MainLabel[ply].Ping:SetFont( "ScoreboardDefault" )
	-- MainLabel[ply].Ping:SetTextColor( color_white )
	-- MainLabel[ply].Ping:SetContentAlignment( 5 )
	MainLabel[ply].Ping.Paint = function()
		if not IsValid(ply) then
			return
		end

		local col = team.GetColor(ply:Team())
		draw.SimpleTextOutlined(ply:Ping() , "ArialBoldFive", MainLabel[ply].Ping:GetWide()/2,MainLabel[ply].Ping:GetTall()/2, col, TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,255))
	end

	MainLabel[ply].Health = MainLabel[ply]:Add( "DLabel" )
	MainLabel[ply].Health:Dock( RIGHT )
	MainLabel[ply].Health:SetText("")
	MainLabel[ply].Health:SetWidth( 50 )
	-- MainLabel[ply].Deaths:SetFont( "ScoreboardDefault" )
	-- MainLabel[ply].Deaths:SetTextColor( color_white )
	-- MainLabel[ply].Deaths:SetContentAlignment( 5 )
	MainLabel[ply].Health.Paint = function()		
		if not IsValid(ply) then
			return
		end

		local col = team.GetColor( ply:Team() )
		local txt
		if ply:Health() <= 0 then
			txt = "DEAD"
		else
			txt = "+"..ply:Health()
		end
		
		draw.SimpleTextOutlined(txt, "ArialBoldFive", MainLabel[ply].Health:GetWide()/2,MainLabel[ply].Health:GetTall()/2, col, TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,255))
	end

	MainLabel[ply].Kills = MainLabel[ply]:Add( "DLabel" )
	MainLabel[ply].Kills:Dock(RIGHT)
	MainLabel[ply].Kills:SetText("")
	MainLabel[ply].Kills:SetWidth(60)
	-- MainLabel[ply].Kills:SetFont( "ScoreboardDefault" )
	-- MainLabel[ply].Kills:SetTextColor( color_white )
	-- MainLabel[ply].Kills:SetContentAlignment( 5 )
	MainLabel[ply].Kills.Paint = function()
		if not IsValid(ply) then
			return
		end
		
		local col = team.GetColor(ply:Team())
		draw.SimpleTextOutlined(ply:GetScore() , "ArialBoldFive", MainLabel[ply].Kills:GetWide()/2,MainLabel[ply].Kills:GetTall()/2, col, TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,255))
	end
	
	MainLabel[ply].Think = function()
		if not IsValid(ply) then
			return
		end
	
		local self = MainLabel[ply]
		if self.Muted == nil or self.Muted ~= self.Player:IsMuted() then
			self.Muted = self.Player:IsMuted()
			if ( self.Muted ) then
				self.Mute:SetImage( "icon32/muted.png" )
			else
				self.Mute:SetImage( "icon32/unmuted.png" )
			end

			self.Mute.DoClick = function() self.Player:SetMuted( not self.Muted ) end
		end
	end
	
	MainLabel[ply].Paint = function()
		if not IsValid(ply) then
			return
		end
		
		if ply == MySelf then
			surface.SetDrawColor( 255, 255, 255, 255)
			surface.DrawOutlinedRect( 0, 0, MainLabel[ply]:GetWide(), MainLabel[ply]:GetTall())
			surface.DrawOutlinedRect( 1, 1, MainLabel[ply]:GetWide()-2, MainLabel[ply]:GetTall()-2 )
		else
			surface.SetDrawColor( 30, 30, 30, 200 )
			surface.DrawOutlinedRect( 0, 0, MainLabel[ply]:GetWide(), MainLabel[ply]:GetTall())
			surface.SetDrawColor( 30, 30, 30, 255 )
			surface.DrawOutlinedRect( 1, 1, MainLabel[ply]:GetWide()-2, MainLabel[ply]:GetTall()-2 )
		end	
	end

	list:AddItem(MainLabel[ply])
end

local function SwitchScoreboardItem(ply,from,to)
	if not IsValid(ply) or not MainLabel or not MainLabel[ply] then
		return
	end

	from:RemoveItem(MainLabel[ply])
	MainLabel[ply] = nil
	AddScoreboardItem(ply,to)
end

local function RemoveScoreboardItem(ply,list)
	if not IsValid(ply) or not MainLabel or  not MainLabel[ply] then
		return
	end
	
	list:RemoveItem(MainLabel[ply])
	MainLabel[ply] = nil
end

function GM:CreateScoreboardVGUI()
	SCPanel = vgui.Create("DFrame")
	SCPanel:SetSize(w,h)
	SCPanel:SetPos(0,0)
	SCPanel:SetDraggable(false)
	SCPanel:SetTitle("")
	-- SCPanel:SetSkin("ZSMG")
	SCPanel:ShowCloseButton(false)
	SCPanel:SetBackgroundBlur(true)
	SCPanel.Paint = function() 
		--Override
		draw.SimpleText("MrGreenGaming.com", "HUDFontTiny", SCPanel:GetWide()/2,ScaleH(135), Color(59, 119, 59, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("ZOMBIE SURVIVAL", "NewZombieFont27", SCPanel:GetWide()/2,ScaleH(180), Color(255, 255, 255, 210), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)		
	end
	
	scoreboard_w,scoreboard_h = ScaleW(340), ScaleH(670)
	
	scoreboard_space = ScaleW(40)
	
	left_x,left_y = w/2 - scoreboard_space/2 - scoreboard_w, h/2 - scoreboard_h/2 + 25 +ScaleH(50)
	right_x,right_y = w/2 + scoreboard_space/2, h/2 - scoreboard_h/2 + 25+ScaleH(50)
	
	left_scoreboard = vgui.Create( "DPanelList",SCPanel )
	-- left_scoreboard:ParentToHUD()
	left_scoreboard:SetPos( left_x,left_y )
	left_scoreboard:SetSize( scoreboard_w,scoreboard_h )
	left_scoreboard:SetSkin("ZSMG")
	left_scoreboard:SetSpacing(0)
	left_scoreboard:SetPadding(0)
	left_scoreboard:EnableVerticalScrollbar( true )
	left_scoreboard.Paint = function ()
		DrawPanelBlackBox(0,0,scoreboard_w,scoreboard_h)
	end
	
	
	right_scoreboard = vgui.Create( "DPanelList",SCPanel )
	-- right_scoreboard:ParentToHUD()
	right_scoreboard:SetPos( right_x,right_y )
	right_scoreboard:SetSize( scoreboard_w,scoreboard_h )
	right_scoreboard:SetSkin("ZSMG")
	right_scoreboard:SetSpacing(0)
	right_scoreboard:SetPadding(0)
	right_scoreboard:EnableVerticalScrollbar( true )
	right_scoreboard.Paint = function ()
		DrawPanelBlackBox(0,0,scoreboard_w,scoreboard_h)
	end
	
	left_scoreboard.Think = function()
		local HumanPlayers = team.GetPlayers(TEAM_HUMAN)
		local UndeadPlayers = team.GetPlayers(TEAM_UNDEAD)
		table.sort(HumanPlayers, SortFunc)
	
		for i=1, #HumanPlayers do
			local pl = HumanPlayers[i]
			if not IsValid(pl) then
				continue
			end
		
			AddScoreboardItem(pl, left_scoreboard, right_scoreboard, TEAM_HUMAN)
		end		

		for i=1, #UndeadPlayers do
			local pl = UndeadPlayers[i]
			if not IsValid(pl) then
				continue
			end
			
			for k,v in pairs(left_scoreboard:GetItems()) do
				if pl == v.Player then
					SwitchScoreboardItem(pl,left_scoreboard,right_scoreboard)
					break
				end
			end
		end
		
		for k,v in pairs(left_scoreboard:GetItems()) do
			if not IsValid(v.Player) then
				left_scoreboard:RemoveItem(v)
				MainLabel[v.Player] = nil
			end
		end
		
	end

	right_scoreboard.Think = function()
		local HumanPlayers = team.GetPlayers(TEAM_HUMAN)
		local UndeadPlayers = team.GetPlayers(TEAM_UNDEAD)
	
		table.sort(UndeadPlayers, SortFunc)
	
		for i=1, #UndeadPlayers do
			local pl = UndeadPlayers[i]
			if not IsValid(pl) then
				continue
			end
			
			AddScoreboardItem(pl, right_scoreboard, left_scoreboard, TEAM_UNDEAD)	
		end
		
		-- right_scoreboard:Rebuild()
		for i=1, #HumanPlayers do
			local pl = HumanPlayers[i]
			if not IsValid(pl) then
				continue
			end
			
			for k,v in pairs(right_scoreboard:GetItems()) do
				if pl == v.Player then
					SwitchScoreboardItem(pl,right_scoreboard,left_scoreboard)
					break
				end
			end
		end
		
		for k,v in pairs(right_scoreboard:GetItems()) do
			if not IsValid(v.Player) then
				right_scoreboard:RemoveItem(v)
				MainLabel[v.Player] = nil
			end
		end
	end
end

function GM:RemoveScoreboardVGUI()
	if not SCPanel then
		return
	end
	
	SCPanel:Remove()
	SCPanel = nil
	MainLabel = nil
end