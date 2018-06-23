
AddCSLuaFile()

ENT.Type			= "anim"
ENT.RenderGroup		= RENDERGROUP_OTHER


function ENT:Initialize()
	if not DBUG_PROFILER then
		--hook.Add( "OnViewModelChanged", "UnifiedHandsVMChange".. tostring(self:EntIndex()), self.ViewModelChanged )
		hook.Add( "OnViewModelChanged", self, self.ViewModelChanged )
	end

	self:SetNotSolid( true )
	self:DrawShadow( false )
	self:SetTransmitWithParent( true ) -- Transmit only when the viewmodel does!
	
end

function ENT:OnRemove()
	hook.Remove(self)
end

function ENT:DoSetup( ply )

	-- Set these hands to the player
	ply:SetHands( self )
	self:SetOwner( ply )

	-- Which hands should we use?
	--local info = player_manager.RunClass( ply, "GetHandsModel" )
	local info = ply:GetHandsModel()
	if ( info ) then
		self:SetModel( info.model )
		self:SetSkin( info.skin )
		self:SetBodyGroups( info.body )
	end

	-- Attach them to the viewmodel
	local vm = ply:GetViewModel( 0 )
	self:AttachToViewmodel( vm )

	vm:DeleteOnRemove( self )
	ply:DeleteOnRemove( self )

end

function ENT:GetPlayerColor()
	
	--
	-- Make sure there's an owner and they have this function
	-- before trying to call it!
	--
	local owner = self:GetOwner()
	if ( !IsValid( owner ) ) then return end
	if ( !owner.GetPlayerColor ) then return end
	
	return owner:GetPlayerColor()

end

function ENT:ViewModelChanged( vm, old, new )

	-- Ignore other peoples viewmodel changes!
	if ( vm:GetOwner() != self:GetOwner() ) then return end

	self:AttachToViewmodel( vm )

end

function ENT:AttachToViewmodel( vm )
	
	self:AddEffects( EF_BONEMERGE )
	self:SetParent( vm )
	self:SetMoveType( MOVETYPE_NONE )

	self:SetPos( Vector( 0, 0, 0 ) )
	self:SetAngles( Angle( 0, 0, 0 ) )

end
