ItemCard2 = {}
ItemCard2.__index = ItemCard2
local x, y = 60, 48

function ItemCard2:new(id)
	local o = {}
	o.id = id or 1
	o.icons = {}
	for i=1, 1 do
		o.icons[i] = ItemIcon:new(i)
	end

	return setmetatable(o, self)
end

function ItemCard2:draw(x, y)
	love.graphics.push()
	love.graphics.scale(0.65, 0.65)
	love.graphics.translate(x, y)

	local item = Items2[self.id]

		for i=1, 1 do
			if not(Items2[self.id].number == 0) then
				if (Items2[self.id].id == -1
				or Items2[self.id].count == 0xffff
				or Items2[self.id].pick > 0
				or Items2[self.id].mix == 0x20) then
					self.icons[i].type = Items2[self.id].type
					self.icons[i].count = Items2[self.id].count
					love.graphics.setColor( 1, 1, 1, 0.25 )
					self.icons[i]:draw()
				else
					self.icons[i].type = Items2[self.id].type
					self.icons[i].count = Items2[self.id].count
					self.icons[i]:draw()
					love.graphics.setColor( 1, 1, 1, 1 )
				end
			end
		end

	love.graphics.pop()
end

ItemCard3 = {}
ItemCard3.__index = ItemCard3
local x, y = 60, 48

function ItemCard3:new(id)
	local o = {}
	o.id = id or 1
	o.icons = {}
	for i=1, 1 do
		o.icons[i] = ItemIcon2:new(i)
	end

	return setmetatable(o, self)
end

function ItemCard3:draw(x, y)
	love.graphics.push()
	love.graphics.scale(0.65, 0.65)
	love.graphics.translate(x, y)

	local item = Items2[self.id]

		for i=1, 1 do
			if not(Items2[self.id].number == 0) then
				if (Items2[self.id].id == -1
				or Items2[self.id].count == 0xffff
				or Items2[self.id].pick > 0
				or Items2[self.id].mix == 0x20) then
					self.icons[i].type = Items2[self.id].type
					self.icons[i].roomid = Items2[self.id].roomid
					love.graphics.setColor( 1, 1, 1, 0.25 )
					self.icons[i]:draw()
				else
					self.icons[i].type = Items2[self.id].type
					self.icons[i].roomid = Items2[self.id].roomid
					self.icons[i]:draw()
					love.graphics.setColor( 1, 1, 1, 1 )
				end
			end
		end

	love.graphics.pop()
end
