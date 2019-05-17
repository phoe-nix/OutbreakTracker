PlayerCard = {}
PlayerCard.__index = PlayerCard

local IconPositions = {
--[[ x  | y  ]]--
	{8,   47},
	{56,  47},
	{8,   97},
	{56,  97},
	{117, 97},
	{105, 47},
	{154, 47},
	{105, 97},
	{154, 97},
}

function PlayerCard:new(id)
	local o = {}
	o.id = id or 1
	o.icons = {}
	for i=1, 9 do
		o.icons[i] = ItemIcon:new(unpack(IconPositions[i]))
	end

	o.nameLabel 	  = Label:new(10 , 9, "placeholder", SmallFont)
	o.nameLabelShadow = Label:new(12 ,11, "placeholder", SmallFont, nil, nil, nil, nil, {0, 0, 0, 1})
	o.roomLabel		  = Label:new(110, 0, "placeholder", DefaultFont, "center", "center", 190, 45)
	o.healthLabel	  = Label:new(5  ,25, "placeholder", VerySmallFont, "center", "up", 70, 10)


	return setmetatable(o, self)
end

function PlayerCard:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local player = Players[self.id]
	local sb = love.graphics.newSpriteBatch(UIAtlas.tex)
	local bustname = "bust" .. Players[self.id].type
	local bx, by, bw, bh = UIAtlas.quads[bustname]:getViewport()
	local scale = 150 / bh;

	if Players[self.id].inGame == false then
		sb:setColor(1, 1, 1, 0.5)
	else
		sb:setColor(1, 1, 1, 1)
	end
	UIAtlas:addSB(sb, bustname, 300 - bw * scale + 5, 150 - bh * scale + 5, 0, scale, scale)
	sb:setColor(1, 1, 1, 1)
	if not(Players[self.id].status == "Dead" or Players[self.id].status == "Down" or Players[self.id].status == "Zombie") then
		sb:setColor(unpack(GetConditionColor(GetConditionName(Players[self.id].HP, Players[self.id].maxHP))))
	else
		sb:setColor(unpack(GetConditionColor(GetConditionName(0, 2))))
	end
	UIAtlas:addSB(sb, "healthmask", 8, 8);
	sb:setColor(1, 1, 1, 1)
	UIAtlas:addSB(sb, "statusbar", 0, 5);
	UIAtlas:addSB(sb, GetVirusState(Players[self.id].virus), 86, 21)
	if not(Players[self.id].type == "Yoko" or Players[self.id].type == "David")
		and not(Players[self.id].status == "Dead" or Players[self.id].status == "Zombie") then
		sb:setColor(20/255, 48/255, 85/255, 0.8)
		UIAtlas:addSB(sb, "inventorymask", 8, 47);
		UIAtlas:addSB(sb, "ispecialmask", 118, 97);
		sb:setColor(1, 1, 1, 1)
		UIAtlas:addSB(sb, "invSingle", 0, 42);
		UIAtlas:addSB(sb, "invSpecial", 110, 94);
	else
		sb:setColor(20/255, 48/255, 85/255, 0.8)
		UIAtlas:addSB(sb, "inventorymask", 8, 47);
		if not(Players[self.id].status == "Dead" or Players[self.id].status == "Zombie") then
			sb:setColor(50/255, 120/255, 70/255, 0.8)
		end
		UIAtlas:addSB(sb, "inventorymask", 106, 47);
		sb:setColor(1, 1, 1, 1)
		UIAtlas:addSB(sb, "invDouble", 0, 42);
	end

	love.graphics.draw(sb)

	for i=1, 4 do
		if not(Players[self.id].inventory[i].id == -1) then
			self.icons[i].type = Players[self.id].inventory[i].type
			self.icons[i].count = Players[self.id].inventory[i].count
			local equip = Players[self.id].equipped
			if equip == 0 then
				self.icons[i].equipped = false
			else
				self.icons[i].equipped = (equip == Players[self.id].inventory[i].id)
			end
			self.icons[i]:draw()
		end
	end
	if not(Players[self.id].type == "Yoko" or  Players[self.id].type == "David") and not(Players[self.id].specialItem.id == -1)
		and not(Players[self.id].status == "Dead" or Players[self.id].status == "Zombie") then
		self.icons[5].type = Players[self.id].specialItem.type
		self.icons[5].count = Players[self.id].specialItem.count
		local equip = Players[self.id].equipped
		if equip <= 0 then
			self.icons[5].equipped = false
		else
			self.icons[5].equipped = (equip == Players[self.id].specialItem.id)
		end
		if Players[self.id].specialItem.type == 403 then
			self.icons[5]:draw(false)
		else
			self.icons[5]:draw(true)
		end
	else
		for i=6, 9 do
			if not(Players[self.id].specialInventory[i-5].id == -1) then
				self.icons[i].type = Players[self.id].specialInventory[i-5].type
				self.icons[i].count = Players[self.id].specialInventory[i-5].count
				local equip = Players[self.id].equipped
				if equip <= 0 then
					self.icons[i].equipped = false
				else
					self.icons[i].equipped = (equip == Players[self.id].specialInventory[i-5].id)
				end
				self.icons[i]:draw()
			end
		end
	end

	self.nameLabel.text = Players[self.id].name:upper()
	self.nameLabelShadow.text = Players[self.id].name:upper()
	self.nameLabelShadow:draw()
	self.nameLabel:draw()

	self.healthLabel.color = GetStatusColor(self.id)
	self.healthLabel.text = GetPlayerHealthString(self.id)
	self.healthLabel:draw()

	self.roomLabel.text = GetRoomName(GameInfo.scenario, Players[self.id].roomID)
	self.roomLabel:draw()

	love.graphics.setFont(VirusFont)
	if Players[self.id].specialItem.type == 403 then
		love.graphics.printf(tostring(Players[self.id].critBonus) .. "%", 118, 128, 46, "right")
	end
	-- Here goes some weird magic
	local tx, ty = 150, 120
	local val1 = math.floor(Players[self.id].virus)
	local val2 = math.floor(math.floor(Players[self.id].virus*100+0.5) - val1 * 100)
	love.graphics.printf(tostring(val1), tx, ty, 60, "right", 0, 1.75, 1.75)
	love.graphics.printf("." .. string.format("%02d", val2) .. "%", tx+103, ty+7, 60, "left", 0, 1.25, 1.25)
	-- weird magic ends here

	love.graphics.pop()
end