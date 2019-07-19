SPlayerCard = {}
SPlayerCard.__index = SPlayerCard

local IconPositions = {
--[[ x  | y  ]]--
	{8,   42},
	{56,  42},
	{8,   92},
	{56,  92},
	{117, 92},
	{105, 42},
	{154, 42},
	{105, 92},
	{154, 92},
}

function SPlayerCard:new(id)
	local o = {}
	o.id = id or 1
	o.icons = {}
	for i=1, 9 do
		o.icons[i] = ItemIcon:new(unpack(IconPositions[i]))
	end

	o.nameLabel 	  = Label:new(10 , 4, "placeholder", SmallFont)
	o.nameLabelShadow = Label:new(12 , 5, "placeholder", SmallFont, nil, nil, nil, nil, {0, 0, 0, 1})
	--o.roomLabel		  = Label:new(110, 0, "placeholder", SmallFont, "center", "center", 190, 40)
	--o.roomLabelShadow = Label:new(111, 1, "placeholder", SmallFont, "center", "center", 190, 40, {0, 0, 0, 1})
	--o.roomLabel_j		= Label:new(280, 2, "placeholder", SmallFont, "center", "up", 15, 145)
	--o.roomLabelShadow_j = Label:new(281, 3, "placeholder", SmallFont, "center", "up", 15, 145, {0, 0, 0, 1})
	--o.healthLabel	  = Label:new(8  ,21, "placeholder", VerySmallFont, "center", "up", 70, 10)


	return setmetatable(o, self)
end

function SPlayerCard:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local splayer = SPlayers[self.id]

	local sb = love.graphics.newSpriteBatch(UIAtlas.tex)
	local sb2 = love.graphics.newSpriteBatch(ItemIcons2.tex)
	local bustname = SPlayers[self.id].name
	local iconname = "icon" .. SPlayers[self.id].name

	ItemIcons2:addSB(sb2, bustname, 8, 42, 0, 1, 1)

	sb:setColor(20/255, 134/255, 10/255, 0.5)
	UIAtlas:addSB(sb, "healthmask", 9, 5);
	sb:setColor(1, 1, 1, 1)
	UIAtlas:addSB(sb, "statusbar", 1, 2);

	sb:setColor(1, 1, 1, 1)
	UIAtlas:addSB(sb, iconname, 85, 16, 0, 1, 1)

	sb:setColor(20/255, 48/255, 85/255, 0.8)
	UIAtlas:addSB(sb, "ispecialmask", 9, 42);

	sb:setColor(1, 1, 1, 1)
	UIAtlas:addSB(sb, "invSpecial", 1, 39);

	love.graphics.draw(sb)

	love.graphics.draw(sb2)

	self.nameLabel.text = SPlayers[self.id].name:upper()
	self.nameLabelShadow.text = SPlayers[self.id].name:upper()
	self.nameLabelShadow:draw()
	self.nameLabel:draw()

	love.graphics.pop()
end
