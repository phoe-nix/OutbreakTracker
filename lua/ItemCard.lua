ItemCard = {}
ItemCard.__index = ItemCard
local x, y = 50, 40
local IconPositions = {
--[[ x  | y  ]]--
	{0*x, 1*y-y},--1
	{1*x, 1*y-y},--2
	{2*x, 1*y-y},--3
	{3*x, 1*y-y},--4
	{4*x, 1*y-y},--5
	{5*x, 1*y-y},--6
	{6*x, 1*y-y},--7
	{7*x, 1*y-y},--8
	{0*x, 2*y-y},--9
	{1*x, 2*y-y},--10
	{2*x, 2*y-y},--11
	{3*x, 2*y-y},--12
	{4*x, 2*y-y},--13
	{5*x, 2*y-y},--14
	{6*x, 2*y-y},--15
	{7*x, 2*y-y},--16
	{0*x, 1*y-y},--1
	{1*x, 1*y-y},--2
	{2*x, 1*y-y},--3
	{3*x, 1*y-y},--4
	{4*x, 1*y-y},--5
	{5*x, 1*y-y},--6
	{6*x, 1*y-y},--7
	{7*x, 1*y-y},--8
	{0*x, 2*y-y},--9
	{1*x, 2*y-y},--10
	{2*x, 2*y-y},--11
	{3*x, 2*y-y},--12
	{4*x, 2*y-y},--13
	{5*x, 2*y-y},--14
	{6*x, 2*y-y},--15
	{7*x, 2*y-y},--16
}

function ItemCard:new(id)
	local o = {}
	o.id = id or 1
	o.icons = {}
	for i=1, 32 do
		o.icons[i] = ItemIcon:new(unpack(IconPositions[i]))
	end

	return setmetatable(o, self)
end

function ItemCard:draw(x, y)
	love.graphics.push()
	love.graphics.scale(0.5, 0.5)
	love.graphics.translate(x, y)

	local item = Items[self.id]
	local p = GameInfo.playernum

	if p == 1 then
		for i=1, 32 do
			--if(Items[self.id].roomitem[i].pick < 5) and (Items[self.id].roomitem[i].type > 0) and(Items[self.id].roomitem[i].count > 0) then
			if not(Items[self.id].roomitem[i].id == -1) then
				if not(Items[self.id].roomitem[i].mix == 0x20
				or (Items[self.id].roomitem[i].pick > 0) and (Items[self.id].roomitem[i].present == 0)) then
				self.icons[i].type = Items[self.id].roomitem[i].type
				self.icons[i].count = Items[self.id].roomitem[i].count
				love.graphics.setColor( 1, 1, 1, 1 )
				self.icons[i]:draw()
				end
			end
		end
	else
		for i=1, 32 do
			--if(Items[self.id].roomitem[i].pick < 5) and (Items[self.id].roomitem[i].type > 0) and(Items[self.id].roomitem[i].count > 0) then
			if not(Items[self.id].roomitem[i].id == -1) then
				if (Items[self.id].roomitem[i].mix == 0x20
				or (Items[self.id].roomitem[i].pick > 0) and (Items[self.id].roomitem[i].present == 0)) then
				self.icons[i].type = Items[self.id].roomitem[i].type
				self.icons[i].count = Items[self.id].roomitem[i].count
				self.icons[i].pick = Items[self.id].roomitem[i].pick
				love.graphics.setColor( 1, 1, 1, 0.25 )
				self.icons[i]:draw()
				else
				self.icons[i].type = Items[self.id].roomitem[i].type
				self.icons[i].count = Items[self.id].roomitem[i].count
				self.icons[i].pick = Items[self.id].roomitem[i].pick
				love.graphics.setColor( 1, 1, 1, 1 )
				self.icons[i]:draw()
				end
			end
		end
	end

	love.graphics.pop()
end

ItemCard1 = {}
ItemCard1.__index = ItemCard1
local x, y = 45, 45
local IconPositions = {
--[[ x  | y  ]]--
	{0*x, 1*y-y},--1
	{1*x, 1*y-y},--2
	{2*x, 1*y-y},--3
	{3*x, 1*y-y},--4
	{4*x, 1*y-y},--5
	{5*x, 1*y-y},--6
	{6*x, 1*y-y},--7
	{7*x, 1*y-y},--8
	{8*x, 1*y-y},--9
	{9*x, 1*y-y},--10
	{10*x, 1*y-y},--11
	{11*x, 1*y-y},--12
	{12*x, 1*y-y},--13
	{13*x, 1*y-y},--14
	{14*x, 1*y-y},--15
	{15*x, 1*y-y},--16
	{0*x, 1*y-y},--17
	{1*x, 1*y-y},--18
	{2*x, 1*y-y},--19
	{3*x, 1*y-y},--20
	{4*x, 1*y-y},--21
	{5*x, 1*y-y},--22
	{6*x, 1*y-y},--23
	{7*x, 1*y-y},--24
	{8*x, 1*y-y},--25
	{9*x, 1*y-y},--26
	{10*x, 1*y-y},--27
	{11*x, 1*y-y},--28
	{12*x, 1*y-y},--29
	{13*x, 1*y-y},--30
	{14*x, 1*y-y},--31
	{15*x, 1*y-y},--32
}

function ItemCard1:new(id)
	local o = {}
	o.id = id or 1
	o.icons = {}
	for i=1, 32 do
		o.icons[i] = ItemIcon:new(unpack(IconPositions[i]))
	end

	return setmetatable(o, self)
end

function ItemCard1:draw(x, y)
	love.graphics.push()
	love.graphics.scale(0.6, 0.6)
	love.graphics.translate(x, y)

	local item = Items[self.id]
	local p = GameInfo.playernum

	if p == 1 then
		for i=1, 32 do
			--if(Items[self.id].roomitem[i].pick < 5) and (Items[self.id].roomitem[i].type > 0) and(Items[self.id].roomitem[i].count > 0) then
			if not(Items[self.id].roomitem[i].id == -1) then
				if not(Items[self.id].roomitem[i].mix == 0x20
				or (Items[self.id].roomitem[i].pick > 0) and (Items[self.id].roomitem[i].present == 0)) then
				self.icons[i].type = Items[self.id].roomitem[i].type
				self.icons[i].count = Items[self.id].roomitem[i].count
				love.graphics.setColor( 1, 1, 1, 1 )
				self.icons[i]:draw()
				end
			end
		end
	else
		for i=1, 32 do
			--if(Items[self.id].roomitem[i].pick < 5) and (Items[self.id].roomitem[i].type > 0) and(Items[self.id].roomitem[i].count > 0) then
			if not(Items[self.id].roomitem[i].id == -1) then
				if (Items[self.id].roomitem[i].mix == 0x20
				or (Items[self.id].roomitem[i].pick > 0) and (Items[self.id].roomitem[i].present == 0)) then
				self.icons[i].type = Items[self.id].roomitem[i].type
				self.icons[i].count = Items[self.id].roomitem[i].count
				self.icons[i].pick = Items[self.id].roomitem[i].pick
				love.graphics.setColor( 1, 1, 1, 0.25 )
				self.icons[i]:draw()
				else
				self.icons[i].type = Items[self.id].roomitem[i].type
				self.icons[i].count = Items[self.id].roomitem[i].count
				self.icons[i].pick = Items[self.id].roomitem[i].pick
				love.graphics.setColor( 1, 1, 1, 1 )
				self.icons[i]:draw()
				end
			end
		end
	end

	love.graphics.pop()
end

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
			--if(Items2[self.id].pick < 5) and (Items2[self.id].type > 0) and(Items2[self.id].count > 0) then
			if (Items2[self.id].number > 0) then
				if (Items2[self.id].id == -1
				or Items2[self.id].count == 0xffff
				or Items2[self.id].mix == 0x20
				or (Items2[self.id].pick > 0) and (Items2[self.id].present == 0)) then
					self.icons[i].type = Items2[self.id].type
					self.icons[i].count = Items2[self.id].count
					self.icons[i].pick = Items2[self.id].pick
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
			--if(Items2[self.id].pick < 5) and (Items2[self.id].type > 0) and(Items2[self.id].count > 0) then
			if (Items2[self.id].number > 0) then
				if (Items2[self.id].id == -1
				or Items2[self.id].count == 0xffff
				or Items2[self.id].mix == 0x20
				or (Items2[self.id].pick > 0) and (Items2[self.id].present == 0)) then
					self.icons[i].type = Items2[self.id].type
					self.icons[i].roomid = Items2[self.id].roomid
					--self.icons[i].pick = Items2[self.id].pick
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
