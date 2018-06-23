local meta = FindMetaTable( "Player" )

if (!meta) then return end

function meta:GetXP()
	return self.XP
end


function meta:CallHumanFunction(funcname, ...)
	if self:Team() == TEAM_HUMAN then
		local tab = self:GetHumanClassTable()
		if tab[funcname] then
			return tab[funcname](tab, self, ...)
		end
	end
end

function meta:GetHumanClassTable()
	return GAMEMODE.HumanClasses[self:GetClass()]
end

function meta:SetClass(class)
	self.CurrentClass = class
	
	for k,v in pairs(GAMEMODE.HumanClasses) do
		if (v.Name == class ) then
			
			self:SetMaxHealth(math.max(1, v.Health)) self:SetHealth(self:GetMaxHealth())
			self.HumanSpeedAdder = (self.HumanSpeedAdder or 0) + v.BonusSpeed
			
			self:CallHumanFunction("Loadout")

			self:ResetSpeed()
		end
	end
end

function meta:GetClass()
	return self.CurrentClass
end

function meta:GetScrap()
	return self.Scrap
end

--[[function meta:GiveScrap(amount)
	self.Resources["scrap"] = math.Clamp(self.Resources["scrap"] + amount,0,LIMIT_SCRAP)
	GAMEMODE:SaveData(self)
end]]



function meta:GiveXP( amount , class )
	local curClass = self:GetClass()
	if class != nil then
		curClass = class
	end
	
	if (curClass == class) then
		self.XP = math.Clamp(self.XP + amount,0,LIMIT_XP)
	end

	GAMEMODE:SaveData(self)
end

function meta:UnlockItem(item)
	self.Items[#self.Items + 1] = tostring(item)
	GAMEMODE:PlayerUnlockItem(self,item)
	GAMEMODE:SendPlayerData(self)
end

function meta:GetItems()
	return self.Items
end

function meta:CashOut()
	local giveXP = math.floor(self:GetPoints() / 20)
	self:GiveXP(giveXP)
	self:TakePoints(self:GetPoints())
	print("Cashed out for " .. giveXP .. "XP!")
end

function meta:GiveResource(resource, amount)
	if (amount != nil) then
		print("RECEIVED: " .. resource .. " AMOUNT " .. amount)
		self.Resources[ resource ] = self.Resources[ resource ] + amount
	else
		print("RECEIVED: " .. resource )
		self.Resources[ resource ] = self.Resources[ resource ] + 1	
	end
end

function meta:GetResource(resource)
	return self.Resources[resource]
end
