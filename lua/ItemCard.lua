ItemCard = {}
ItemCard.__index = ItemCard
local x, y = 41, 0
local IconPositions = {
--[[ x  | y  ]]--
	{0*x, 0*y},--1
	{1*x, 1*y},--2
	{2*x, 2*y},--3
	{3*x, 3*y},--4
	{4*x, 4*y},--5
	{5*x, 5*y},--6
	{6*x, 6*y},--7
	{7*x, 7*y},--8
	{8*x, 8*y},--9
	{9*x, 9*y},--10
	{10*x,10*y},--11
	{11*x,11*y},--12
	{12*x,12*y},--13
	{13*x,13*y},--14
	{14*x,14*y},--15
	{15*x,15*y},--16
}

function ItemCard:new(id)
	local o = {}
	o.id = id or 1
	o.icons = {}
	for i=1, 16 do
		o.icons[i] = ItemIcon:new(unpack(IconPositions[i]))
	end

	return setmetatable(o, self)
end

function ItemCard:draw(x, y)
	love.graphics.push()
	love.graphics.scale(0.45, 0.45)
	love.graphics.translate(x, y)

	local item = Items[self.id]

		for i=1, 16 do
			if not(Items[self.id].roomitem[i].id == -1) then
				self.icons[i].type = Items[self.id].roomitem[i].type
				self.icons[i].count = Items[self.id].roomitem[i].count
				self.icons[i]:draw()
			end
		end


	love.graphics.pop()
end
