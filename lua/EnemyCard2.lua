EnemyCard2 = {}
EnemyCard2.__index = EnemyCard2

function EnemyCard2:new(id)
	local o = {}
	o.id = id or 1
	o.nameLabel 	   = Label:new(80, 5, "placeholder", VerySmallFont, "left", "down", 110, 10, {0, 0, 0, 1})
	o.nameLabelShadow  = Label:new(81, 6, "placeholder", VerySmallFont, "left", "down", 110, 10, {0, 0, 0, 1})

	return setmetatable(o, self)
end

function EnemyCard2:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local enemy = Enemies[self.id]

	love.graphics.setColor( 109/255, 131/255, 227/255, 1 )
	love.graphics.rectangle('line',2,2,76,11,1,1,1)
	if Enemies[self.id].HP>= 0x8000
	or Enemies[self.id].HP == 0xffff
	or Enemies[self.id].nameID == 11
	or Enemies[self.id].nameID == 12
	or Enemies[self.id].nameID == 14
	or Enemies[self.id].nameID == 26 then
		love.graphics.setColor(0,0,0,0.5)
		love.graphics.rectangle('fill',4,4,(GetHealthbar(Enemies[self.id].HP, Enemies[self.id].maxHP))*72,7,0,0,1)
	else
		love.graphics.setColor(GetConditionColor2(GetConditionName2(Enemies[self.id].HP, Enemies[self.id].maxHP)))
		love.graphics.rectangle('fill',4,4,(Enemies[self.id].HP / Enemies[self.id].maxHP)*72,7,0,0,1)
	end

	self.nameLabel.text = Enemies[self.id].name
	self.nameLabelShadow.text = Enemies[self.id].name
	self.nameLabelShadow:draw()
	self.nameLabel:draw()
	self.nameLabel.color = GetEnemyColor(self.id)

	love.graphics.pop()
	love.graphics.setColor( 1, 1, 1, 1 )
end
