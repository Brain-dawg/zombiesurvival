-- � Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

--  Be sure to assign your custom animations at the bottom of this file.

--  Poison Zombie
local PoisonZombieATT = {}
PoisonZombieATT[PLAYER_IDLE] = ACT_IDLE_ON_FIRE
PoisonZombieATT[PLAYER_WALK] = ACT_WALK
PoisonZombieATT[PLAYER_JUMP] = ACT_WALK
PoisonZombieATT[PLAYER_ATTACK1] = ACT_MELEE_ATTACK1
PoisonZombieATT[PLAYER_SUPERJUMP] = ACT_RANGE_ATTACK2

local function PoisonZombieAnim(pl, anim)
	local act = ACT_IDLE

	if PoisonZombieATT[anim] ~= nil then
		act = PoisonZombieATT[anim]
	else
		if pl:GetVelocity():Length() > 0 then
			act = ACT_WALK
		end
	end

	if act == ACT_MELEE_ATTACK1 or anim == PLAYER_SUPERJUMP then
		pl:SetPlaybackRate(2)
		pl:RestartGesture(act)
		return true
	end

	local seq = pl:SelectWeightedSequence(act)

	if pl:GetSequence() == seq then return true end
	pl:ResetSequence(seq)
	pl:SetPlaybackRate(1.0)
	pl:SetCycle(0)
	return true
end

local function ChemZombieAnim(pl, anim)
	local act = ACT_IDLE

	if PoisonZombieATT[anim] ~= nil then
		act = PoisonZombieATT[anim]
	else
		if pl:GetVelocity():Length() > 0 then
			act = ACT_WALK
		end
	end

	if act == ACT_MELEE_ATTACK1 or anim == PLAYER_SUPERJUMP then
		pl:SetPlaybackRate(2)
		pl:RestartGesture(act)
		return true
	end

	local seq = pl:SelectWeightedSequence(act)
	if act == ACT_WALK then
		seq = 2
	end

	if pl:GetSequence() == seq then return true end
	pl:ResetSequence(seq)
	pl:SetPlaybackRate(1.0)
	pl:SetCycle(0)
	return true
end

local WraithATT = {}
WraithATT[PLAYER_IDLE] = ACT_IDLE
WraithATT[PLAYER_WALK] = ACT_WALK
WraithATT[PLAYER_JUMP] = ACT_WALK
 WraithATT[PLAYER_ATTACK1] = ACT_RANGE_ATTACK1

local function WraithAnim(pl, anim)
	local act = ACT_IDLE

	if WraithATT[anim] ~= nil then
		act = WraithATT[anim]
	else
		if pl:GetVelocity():Length() > 0 then
			act = ACT_WALK
		end
	end

	--[==[if act == ACT_RANGE_ATTACK1 then
		pl:SetPlaybackRate(2)
		pl:RestartGesture(act)
		return true
	end]==]
	
	if act == ACT_RANGE_ATTACK1 then
		pl:SetPlaybackRate(2)
		pl:RestartGesture(act)
		return true end

	local seq = pl:SelectWeightedSequence(act)
	if act == ACT_IDLE then
		seq = 1
	end

	pl:SetPlaybackRate(1.0)

	if pl:GetSequence() == seq then return true end
	pl:ResetSequence(seq)
	pl:SetCycle(0)
	return true
end

--  Fast Zombie
local FastZombieATT = {}
FastZombieATT[PLAYER_IDLE] = ACT_IDLE
FastZombieATT[PLAYER_WALK] = ACT_RUN
FastZombieATT[PLAYER_ATTACK1] = ACT_MELEE_ATTACK1
FastZombieATT[PLAYER_SUPERJUMP] = ACT_CLIMB_UP

local function FastZombieAnim(pl, anim)
	local act = ACT_IDLE
	local OnGround = pl:OnGround()

	if FastZombieATT[anim] then
		act = FastZombieATT[anim]
	else
		if pl:GetVelocity():Length() > 0 then
			act = ACT_RUN
		end
	end

	if act == ACT_MELEE_ATTACK1 or act == ACT_CLIMB_UP then
		pl:RestartGesture(act)
		return true
	end

	local seq = pl:SelectWeightedSequence(act)

	if not OnGround and act ~= ACT_CLIMB_UP then
		seq = 3
	end

	if pl:GetSequence() == seq then return true end
	pl:ResetSequence(seq)
	pl:SetPlaybackRate(1.0)
	pl:SetCycle(0)
	return true
end

--  Headcrab / Fast headcrab
local HeadcrabATT = {}
HeadcrabATT[PLAYER_IDLE] = ACT_IDLE
HeadcrabATT[PLAYER_WALK] = ACT_RUN
HeadcrabATT[PLAYER_ATTACK1] = ACT_RANGE_ATTACK1

local function HeadcrabAnim(pl, anim)
	local act = ACT_IDLE
	local OnGround = pl:OnGround()

	if HeadcrabATT[anim] then
		act = HeadcrabATT[anim]
	else
		if pl:GetVelocity():Length() > 0 then
			act = ACT_RUN
		end
	end

	if act == ACT_RANGE_ATTACK1 then
		pl:RestartGesture(act)
		return true
	end

	local seq = pl:SelectWeightedSequence(act)

	if not OnGround then
	    seq = "Drown"
	end

	if pl:GetSequence() == seq then return true end
	pl:ResetSequence(seq)
	if seq == 5 then
		pl:SetPlaybackRate(1.0)
	else
		pl:SetPlaybackRate(0.3)
	end
	pl:SetCycle(0)
	return true
end

--  Poison Headcrab
local PoisonHCATT = {}
PoisonHCATT[PLAYER_IDLE] = ACT_IDLE
PoisonHCATT[PLAYER_WALK] = ACT_RUN
PoisonHCATT[PLAYER_ATTACK1] = ACT_RANGE_ATTACK1
PoisonHCATT[PLAYER_SUPERJUMP] = "Spitattack"

local function PoisonHeadcrabAnim(pl, anim)
	local act = ACT_IDLE
	local OnGround = pl:OnGround()

	if PoisonHCATT[anim] then
		act = PoisonHCATT[anim]
	else
		if pl:GetVelocity():Length() > 0 then
			act = ACT_RUN
		end
	end

	if act == ACT_RANGE_ATTACK1 or act == "Spitattack" then
		pl:RestartGesture(act)
		return true
	end

	local seq = pl:SelectWeightedSequence(act)

	if not OnGround then
	    seq = "Drown"
	end

	if act == ACT_IDLE then
		seq = 4
	end

	if pl:GetSequence() == seq then return true end
	pl:ResetSequence(seq)
	if seq == 4 then
		pl:SetPlaybackRate(1.0)
	else
		pl:SetPlaybackRate(0.2)
	end
	pl:SetCycle(0)
	return true
end



--  Howler
local HowlerATT = {}
HowlerATT[PLAYER_IDLE] = ACT_IDLE
HowlerATT[PLAYER_WALK] = ACT_WALK
HowlerATT[PLAYER_JUMP] = ACT_WALK
HowlerATT[PLAYER_ATTACK1] = ACT_MELEE_ATTACK1
HowlerATT[PLAYER_SUPERJUMP] = ACT_IDLE_ON_FIRE

local function HowlerAnim(pl, anim)
	local act = ACT_IDLE

	if HowlerATT[anim] ~= nil then
		act = HowlerATT[anim]
	end

	if act == ACT_MELEE_ATTACK1 or anim == PLAYER_SUPERJUMP then
		pl:SetPlaybackRate(0.2)
		pl:RestartGesture(act)
		return true
	end

	if pl.IsScreaming then
		act = ACT_IDLE_ON_FIRE
	end
	
	local seq = pl:SelectWeightedSequence(act)
	if act == ACT_WALK then
		seq = pl.ZomAnim
	end
	
	if seq == pl.ZomAnim then
		pl:SetPlaybackRate(1.9)
	else
		pl:SetPlaybackRate(1.0)
	end
	if pl:GetSequence() == seq then return true end
	
	pl:ResetSequence(seq)
	pl:SetCycle(0)
	return true
end

--  Zombie Torso
local ZombieTorsoATT = {}
ZombieTorsoATT[PLAYER_IDLE] = ACT_IDLE
ZombieTorsoATT[PLAYER_WALK] = ACT_WALK
ZombieTorsoATT[PLAYER_JUMP] = ACT_WALK
ZombieTorsoATT[PLAYER_ATTACK1] = ACT_MELEE_ATTACK1

local function ZombieTorsoAnim(pl, anim)
	local act = ACT_IDLE

	if ZombieTorsoATT[anim] then
		act = ZombieTorsoATT[anim]
	else
		if pl:GetVelocity():Length() > 0 then
			act = ACT_WALK
			pl:SetPlaybackRate(1.0)
		end
	end

	if act == ACT_MELEE_ATTACK1 then
		pl:SetPlaybackRate(2)
		pl:RestartGesture(act)
		return true
	end

	local seq = pl:SelectWeightedSequence(act)
	if act == ACT_WALK then
		seq = 2
		pl:SetPlaybackRate(1.0)
	end

	if pl:GetSequence() == seq then return true end
	 
	pl:ResetSequence(seq)
	pl:SetPlaybackRate(1.0)
	pl:SetCycle(0)
	
	return true
end

local ATT = {}
ATT[PLAYER_RELOAD] = ACT_HL2MP_GESTURE_RELOAD
ATT[PLAYER_JUMP] = ACT_HL2MP_JUMP
ATT[PLAYER_ATTACK1] = ACT_HL2MP_GESTURE_RANGE_ATTACK

local function ZombineAnim ( pl, anim )
	local seqname = "Idle01"
	if pl.HoldingGrenade then seqname = "Idle_Grenade" end
	
	if( pl:KeyDown( IN_SPEED ) and pl:GetVelocity():Length() >= 1 ) then
		seqname = "Run_All"
		
		-- Player running with grenade
		if pl.HoldingGrenade then seqname = "Run_All_grenade" end
	elseif( pl:GetVelocity():Length() >= 1 ) then
		seqname = "walk_All"
		
		-- Walking with grenade
		if pl.HoldingGrenade then seqname = "walk_All_Grenade" end
	end

	-- Pulling out grenade
	if pl.IsGettingNade then
		seqname = "pullGrenade"
	end
	
	-- Attacking animation
	if pl.IsAttacking then seqname = pl.IsAttacking end
	
	if ( pl:GetSequence() == pl:LookupSequence( seqname ) ) then return true end

	pl:SetPlaybackRate( 1 )
	pl:ResetSequence( seqname )
	pl:SetCycle( 0 )
		
	return true
end

--  These index numbers are related to the class numbers in zs_options.lua

SpecialAnims = {}
SpecialAnims[1] = ZombieAnim
SpecialAnims[3] = FastZombieAnim
SpecialAnims[2] = PoisonZombieAnim
SpecialAnims[5] = WraithAnim
SpecialAnims[6] = HowlerAnim
SpecialAnims[7] = HeadcrabAnim
SpecialAnims[9] = PoisonHeadcrabAnim
SpecialAnims[8] = ZombineAnim
