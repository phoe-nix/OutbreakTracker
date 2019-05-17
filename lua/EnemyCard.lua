EnemyCard = {}
EnemyCard.__index = EnemyCard

function EnemyCard:new(id)
	local o = {}
	o.id = id or 1



	o.nameLabel 	   = Label:new(80, 0, "placeholder", EnemyFont, "left", "down", 110, 10, {0, 0, 0, 1})
	o.nameLabelShadow  = Label:new(81, 1, "placeholder", EnemyFont, "left", "down", 110, 10, {0, 0, 0, 1})
	o.healthLabel	   = Label:new(2,0, "placeholder", EnemyFont, "left", "down", 150, 10, {1, 1, 1, 1})
	o.healthLabelShadow= Label:new(3,1, "placeholder", EnemyFont, "left", "down", 150, 10, {0, 0, 0, 1})


	return setmetatable(o, self)
end

function EnemyCard:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local enemy = Enemies[self.id]

	--self.healthLabel.color=(GetConditionColor2(GetConditionName(Enemies[self.id].HP, Enemies[self.id].maxHP)))

	self.nameLabel.text = Enemies[self.id].name
	self.nameLabelShadow.text = Enemies[self.id].name
	self.nameLabelShadow:draw()
	self.nameLabel:draw()

	self.nameLabel.color = GetEnemyColor(self.id)
	self.healthLabel.text = GetEnemyHealthString(self.id)
	self.healthLabelShadow.text = GetEnemyHealthString(self.id)
	self.healthLabelShadow:draw()
	self.healthLabel:draw()

	love.graphics.pop()
end
