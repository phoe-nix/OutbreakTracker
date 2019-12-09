ItemCard2 = {}
ItemCard2.__index = ItemCard2
local x, y = 60, 48
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

function ItemCard2:new(id)
	local o = {}
	o.id = id or 1
	o.icons = {}
	for i=1, 1 do
		o.icons[i] = ItemIcon:new(unpack(IconPositions[i]))
	end

	return setmetatable(o, self)
end

function ItemCard2:draw(x, y)
	love.graphics.push()
	love.graphics.scale(0.65, 0.65)
	love.graphics.translate(x, y)

	local item = Items2[self.id]

		for i=1, 1 do
			if not(Items2[self.id].id == -1
			or Items2[self.id].number == 0
			or Items2[self.id].count == 0xffff
			or Items2[self.id].pick > 0
			or Items2[self.id].mix == 0x20) then
				self.icons[i].type = Items2[self.id].type
				self.icons[i].count = Items2[self.id].count
				self.icons[i]:draw()
			end
		end

	love.graphics.pop()
end
