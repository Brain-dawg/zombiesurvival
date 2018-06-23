hook.Add( 'Initialize', 'noSQL', function()
	util.AddNetworkString( "sendplayerdata" )
	
	if ( !file.IsDir("noSQL","DATA") ) then
		file.CreateDir("noSQL")
	end 
end )

function GM:PlayerUnlockItem(pl,item)
	GAMEMODE:SaveData(pl)
	GAMEMODE:SendPlayerData(pl)
end

function GM:SendPlayerData(pl)
	net.Start( "sendplayerdata" )
		net.WriteTable(pl.Items)
		net.WriteTable(pl.Resources)
		net.WriteTable(pl.XP)
	net.Send(pl)
end

function GM:GetBlankStats( pl )
	local data = {
		[ 'playername' ] = pl:Nick(),
		[ 'steamid' ] = pl:SteamID(),
		[ 'playtime' ] = 0,
		[ 'items' ] = {},
		[ 'xp' ] = 0,

	}
	pl.XP = 0

	return data

end

function GM:WriteBlank( pl )

	local path = "noSQL/player_"..string.Replace( string.sub( pl:SteamID(), 1 ), ":", "-" )..".txt"
	local data = util.TableToJSON( self:GetBlankStats( pl ) )

	file.Write( path, data )

end

function ReadData( pl )
	local path = "noSQL/player_"..string.Replace( string.sub( pl:SteamID(), 1 ), ":", "-" )..".txt"
	if ( !file.Exists( path , "DATA") ) then
		GAMEMODE:WriteBlank( pl )
		for _, v in pairs( player.GetAll() ) do 
			if IsValid( v ) then
				v:ChatPrint( "Welcome "..pl:Nick().." as they have joined for the first time!" )
			end
		end
	end

	fileData = util.JSONToTable( file.Read( path ) )
	pl.DataTable = table.Copy( fileData )
	pl.Resources = {}
	for k, v in pairs( pl.DataTable ) do
		if( k == 'items' ) then
			pl.Items = v
		end
		if ( k == 'playtime' ) then
			pl.PlayTime = v
		end
		if ( k == 'xp' ) then
			pl.XP = v
		end
		--if ( k == 'points' ) then
		--	pl:SetPoints(v)
		--end		
	end
	
	GAMEMODE:SendPlayerData(pl)
end

hook.Add( 'PlayerInitialSpawn', 'noSQL Read Data', function( pl )
	GAMEMODE:ReadData( pl )
end )

function GM:SaveData( pl )
	local path = "noSQL/player_"..string.Replace( string.sub( pl:SteamID(), 1 ), ":", "-" )..".txt"
		local data = {
			[ 'playername' ] = pl:Nick(),
			[ 'steamid' ] = pl:SteamID(),
			[ 'playtime' ] = 0,
			[ 'items' ] = pl:GetItems(),
			[ 'xp' ] = pl:GetXP(),
			[ 'points' ] = pl:GetPoints()			
		}
	local newData =  util.TableToJSON( data )
	file.Write( path, newData )
end

function GM:GetTableLength( dbTable )
	local count = 0
		for k, v in pairs( dbTable ) do
			count = count + 1
		end
	if ( count > 1 ) then
		return true
	end
	return false
end

concommand.Add( 'testDB', function( pl, cmd, args )
	for k, v in pairs( player.GetAll() ) do
		if ( !IsValid( v ) ) then continue end
		if ( v:Nick() == args[ 1 ] ) then
			local path = "noSQL/player_"..string.Replace( string.sub( pl:SteamID(), 1 ), ":", "-" )..".txt"
				PrintTable( util.JSONToTable( file.Read( path ) ) )
			break;
		end
	end

end )