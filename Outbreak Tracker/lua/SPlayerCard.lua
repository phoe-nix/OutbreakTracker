SPlayerCard = {}
SPlayerCard.__index = SPlayerCard

function SPlayerCard:new(id)
	local o = {}
	o.id = id or 1

	o.nameLabel 	  = Label:new(10, 4, "placeholder", SmallFont)
	o.nameLabelShadow = Label:new(12, 5, "placeholder", SmallFont, nil, nil, nil, nil, {0, 0, 0, 1})
	--o.roomLabel		  = Label:new(110, 0, "placeholder", SmallFont, "center", "center", 190, 40)
	--o.roomLabelShadow = Label:new(111, 1, "placeholder", SmallFont, "center", "center", 190, 40, {0, 0, 0, 1})
	--o.roomLabel_j		= Label:new(280, 2, "placeholder", SmallFont, "center", "up", 15, 145)
	--o.roomLabelShadow_j = Label:new(281, 3, "placeholder", SmallFont, "center", "up", 15, 145, {0, 0, 0, 1})
	o.healthLabel	  = Label:new(8, 21, "placeholder", VerySmallFont, "center", "up", 70, 10)
	o.powerLabel	  = Label:new(172, 126, "placeholder", VirusFont, "right", "up", 48, 15,{25/255, 255/255, 255/255, 1})
	o.powertextLabel  = Label:new(136, 125, "placeholder", SmallFont, "right", "up", 48, 15,{255/255, 255/255, 255/255, 1})
	o.powertextShadow = Label:new(138, 127, "placeholder", SmallFont, "right", "up", 48, 15,{0, 0, 0, 1})


	return setmetatable(o, self)
end

function SPlayerCard:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local splayer = SPlayers[self.id]

	local sb = love.graphics.newSpriteBatch(UIAtlas.tex)
	local bustname = "bust" .. SPlayers[self.id].name
	local bx, by, bw, bh = UIAtlas.quads[bustname]:getViewport()
	local scale = 140 / bh;
	local sb2 = love.graphics.newSpriteBatch(ItemIcons2.tex)
	local startitem = SPlayers[self.id].name
	local hp = SPlayers[self.id].hp
	local power = SPlayers[self.id].power

	ItemIcons2:addSB(sb2, startitem, 8, 42, 0, 1, 1)

	if (SPlayers[self.id].name =="Mr.RED"
	or SPlayers[self.id].name =="BOB"
	or SPlayers[self.id].name =="TONY"
	or SPlayers[self.id].name =="ANDY"
	or SPlayers[self.id].name =="DEREK"
	or SPlayers[self.id].name =="KURT:B"
	or SPlayers[self.id].name =="FRANK"
	or SPlayers[self.id].name =="GARY:B"
	or SPlayers[self.id].name =="HARSH"
	or SPlayers[self.id].name =="Mr.BLACK"
	or SPlayers[self.id].name =="Ms.PEACH"
	or SPlayers[self.id].name =="REGAN:B") then
		sb:setColor(253/255, 25/255, 25/255, 0.5)
	else
		sb:setColor(20/255, 134/255, 10/255, 0.5)
	end
	UIAtlas:addSB(sb, "healthmask", 9, 5);
	sb:setColor(1, 1, 1, 1)
	UIAtlas:addSB(sb, "statusbar", 1, 2);
	
	UIAtlas:addSB(sb, bustname, 220 - bw * scale, 145 - bh * scale, 0, scale, scale)

	sb:setColor(20/255, 48/255, 85/255, 0.8)
	UIAtlas:addSB(sb, "inventorymask", 8, 42);
	UIAtlas:addSB(sb, "ispecialmask", 9, 42);

	sb:setColor(1, 1, 1, 1)
	UIAtlas:addSB(sb, "invSingle", 0, 37);
	UIAtlas:addSB(sb, "invSpecial", 1, 39);

	love.graphics.draw(sb)

	love.graphics.draw(sb2)

	self.nameLabel.text = SPlayers[self.id].name:upper()
	self.nameLabelShadow.text = SPlayers[self.id].name:upper()
	self.nameLabelShadow:draw()
	self.nameLabel:draw()

	self.healthLabel.text = hp
	self.healthLabel:draw()

	self.powerLabel.text = power
	self.powerLabel:draw()

	self.powertextLabel.text = "Power"
	self.powertextShadow.text = "Power"
	self.powertextShadow:draw()
	self.powertextLabel:draw()

	love.graphics.pop()
end
