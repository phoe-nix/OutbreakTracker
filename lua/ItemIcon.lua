ItemIcon = {}
ItemIcon.__index = ItemIcon

function ItemIcon:new(x, y)
	local o = {}
	o.count = 0
	o.type = 0
	o.equipped = false
	o.w = 48
	o.h = 48
	o.x = x or 1
	o.y = y or 1
	return setmetatable(o, self)
end

function ItemIcon:draw(drawCount)
	local dc = (drawCount == nil) or (drawCount == true)
	oldfont = love.graphics.getFont()
	love.graphics.setFont(ItemCountFont)
	local name = tostring(GameInfo.currentFile) .. "/" .. tostring(self.type)
	ItemIcons:draw(name, self.x, self.y)
	if dc then
		love.graphics.printf(tostring(self.count), self.x, self.y+30, 46, "right")
	end
	if self.equipped then
		UIAtlas:draw("equip", self.x + 5, self.y + 2)
	end
	love.graphics.setFont(oldfont)
end

ItemIcon2 = {}
ItemIcon2.__index = ItemIcon2

function ItemIcon2:new(x, y)
	local o = {}
	o.roomid = 0
	o.count = 0
	o.type = 0
	o.equipped = false
	o.w = 48
	o.h = 48
	o.x = x or 1
	o.y = y or 1
	return setmetatable(o, self)
end

function ItemIcon2:draw(drawRoomID)
	local dc = (drawRoomID == nil) or (drawRoomID == true)
	oldfont = love.graphics.getFont()
	love.graphics.setFont(ItemCountFont)
	local name = tostring(GameInfo.currentFile) .. "/" .. tostring(self.type)
	ItemIcons:draw(name, self.x, self.y)
	if dc then
		--love.graphics.printf(tostring(self.count), self.x, self.y+30, 46, "right")
		love.graphics.setColor( 0, 1, 0, 1 )
		love.graphics.printf(tostring(self.roomid), self.x, self.y+30, 46, "right")
	end
	if self.equipped then
		UIAtlas:draw("equip", self.x + 5, self.y + 2)
	end
	love.graphics.setColor( 1, 1, 1, 1 )
	love.graphics.setFont(oldfont)
end