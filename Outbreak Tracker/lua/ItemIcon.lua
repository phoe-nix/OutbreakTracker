ItemIcon = {}
ItemIcon.__index = ItemIcon

function ItemIcon:new(x, y)
	local o = {}
	o.count = 0
	o.type = 0
	o.pick = 0
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
		if self.type==15 then
		love.graphics.setColor( 20/255, 200/255, 255/255, 1 )
		love.graphics.printf(tostring(self.count), self.x, self.y+30, 46, "right")
		elseif self.type==16 then
		love.graphics.setColor( 255/255, 0/255, 0/255, 1 )
		love.graphics.printf(tostring(self.count), self.x, self.y+30, 46, "right")
		elseif self.type==17 then
		love.graphics.setColor( 0/255, 255/255, 0/255, 1 )
		love.graphics.printf(tostring(self.count), self.x, self.y+30, 46, "right")
		elseif self.type==18 then
		love.graphics.setColor( 255/255, 255/255, 255/255, 1 )
		love.graphics.printf(tostring(self.count), self.x, self.y+30, 46, "right")
		else
		love.graphics.setColor( 253/255, 253/255, 168/255, 1 )
		love.graphics.printf(tostring(self.count), self.x, self.y+30, 46, "right")
		end
		if self.pick>0 then
		love.graphics.setFont(DefaultFont)
		love.graphics.setColor( 1, 1, 0, 1 )
		love.graphics.printf(tostring"P"..(self.pick), self.x, self.y+0, 46, "right")
		end
	end
	if self.equipped then
		love.graphics.setColor( 1, 1, 1, 1 )
		UIAtlas:draw("equip", self.x + 5, self.y + 2)
	end
	love.graphics.setColor( 1, 1, 1, 1 )
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
		if self.roomid>0 then
		--love.graphics.printf(tostring(self.count), self.x, self.y+30, 46, "right")
		love.graphics.setFont(DefaultFont)
		love.graphics.setColor( 1, 1, 1, 1 )
		love.graphics.printf(tostring(self.roomid), self.x, self.y+28, 46, "right")
		end
	end
	if self.equipped then
		UIAtlas:draw("equip", self.x + 5, self.y + 2)
	end
	love.graphics.setColor( 1, 1, 1, 1 )
	love.graphics.setFont(oldfont)
end
ItemIcon3 = {}
ItemIcon3.__index = ItemIcon3

function ItemIcon3:new(x, y)
	local o = {}
	o.count = 0
	o.type = 0
	o.pick = 0
	o.equipped = false
	o.w = 48
	o.h = 48
	o.x = x or 1
	o.y = y or 1
	return setmetatable(o, self)
end
