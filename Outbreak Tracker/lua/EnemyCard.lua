EnemyCard = {}
EnemyCard.__index = EnemyCard

function EnemyCard:new(id)
	local o = {}
	o.id = id or 1
	o.nameLabel 	   = Label:new(80, 0, "placeholder", VerySmallFont, "left", "up", 150, 10, {1, 1, 1, 1})
	o.nameLabelShadow  = Label:new(81, 1, "placeholder", VerySmallFont, "left", "up", 150, 10, {0, 0, 0, 1})
	o.healthLabel	   = Label:new(2, 0, "placeholder", VerySmallFont, "center", "up", 75, 10, {1, 1, 1, 1})
	o.healthLabelShadow= Label:new(3, 1, "placeholder", VerySmallFont, "center", "up", 75, 10, {0, 0, 0, 1})

	return setmetatable(o, self)
end

function EnemyCard:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local enemy = Enemies[self.id]

	love.graphics.setColor( 109/255, 131/255, 227/255, 1 )
	love.graphics.rectangle('line',2,2,76,11,1,1,1)
	if Enemies[self.id].HP>= 0x8000
	or Enemies[self.id].HP == 0x0
	or Enemies[self.id].nameID == 11
	or Enemies[self.id].nameID == 12
	or Enemies[self.id].nameID == 14
	or Enemies[self.id].nameID == 26
	or Enemies[self.id].nameID == 34
	or Enemies[self.id].nameID == 56 then
		love.graphics.setColor(1,0,0,0.3)
		love.graphics.rectangle('fill',4,4,72,7,0,0,1)
		--love.graphics.rectangle('fill',4,4,(GetHealthbar(Enemies[self.id].HP, Enemies[self.id].maxHP))*72,7,0,0,1)
	else
		love.graphics.setColor(GetConditionColor2(GetConditionName2(Enemies[self.id].HP, Enemies[self.id].maxHP)))
		love.graphics.rectangle('fill',4,4,(Enemies[self.id].HP / Enemies[self.id].maxHP)*72,7,0,0,1)
	end

	--self.nameLabel.color=(GetConditionColor2(GetConditionName2(Enemies[self.id].HP, Enemies[self.id].maxHP)))

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
	love.graphics.setColor( 1, 1, 1, 1 )
end
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
	or Enemies[self.id].HP == 0x0
	or Enemies[self.id].nameID == 11
	or Enemies[self.id].nameID == 12
	or Enemies[self.id].nameID == 14
	or Enemies[self.id].nameID == 26
	or Enemies[self.id].nameID == 34
	or Enemies[self.id].nameID == 56 then
		love.graphics.setColor(1,0,0,0.3)
		love.graphics.rectangle('fill',4,4,72,7,0,0,1)
		--love.graphics.rectangle('fill',4,4,(GetHealthbar(Enemies[self.id].HP, Enemies[self.id].maxHP))*72,7,0,0,1)
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
EnemyCard3 = {}
EnemyCard3.__index = EnemyCard3

function EnemyCard3:new(id)
	local o = {}
	o.id = id or 1
	o.nameLabel 	   = Label:new(3, 0, "placeholder", VerySmallFont, "left", "top", 300, 20, {0, 0, 0, 1})
	o.nameLabelShadow  = Label:new(4, 1, "placeholder", VerySmallFont, "left", "top", 300, 20, {0, 0, 0, 1})
	o.healthLabel	   = Label:new(0, 18, "placeholder", SmallFont, "center", "center", 300, 20, {1, 1, 1, 1})
	o.healthLabelShadow= Label:new(1, 19, "placeholder", SmallFont, "center", "center", 300, 20, {0, 0, 0, 1})

	return setmetatable(o, self)
end

function EnemyCard3:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local sb = love.graphics.newSpriteBatch(UIAtlas.tex)
	local enemy = Enemies[self.id]

	love.graphics.setColor( 109/255, 131/255, 227/255, 1 )
	love.graphics.rectangle('line',4, 17,292,20,1,1,1)
	if Enemies[self.id].HP>= 0x8000
	or Enemies[self.id].HP == 0x0
	or Enemies[self.id].nameID == 11
	or Enemies[self.id].nameID == 12
	or Enemies[self.id].nameID == 14
	or Enemies[self.id].nameID == 26
	or Enemies[self.id].nameID == 34
	or Enemies[self.id].nameID == 56 then
		love.graphics.setColor(1,0,0,0.3)
		love.graphics.rectangle('fill',6, 19,288,16,0,0,1)
		--love.graphics.rectangle('fill',6, 19,(GetHealthbar(Enemies[self.id].HP, Enemies[self.id].maxHP))*290,14,0,0,1)
	else
		love.graphics.setColor(GetConditionColor2(GetConditionName2(Enemies[self.id].HP, Enemies[self.id].maxHP)))
		love.graphics.rectangle('fill',6, 19,(Enemies[self.id].HP / Enemies[self.id].maxHP)*288,16,0,0,1)
	end
	--self.nameLabel.color=(GetConditionColor2(GetConditionName2(Enemies[self.id].HP, Enemies[self.id].maxHP)))

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
	love.graphics.setColor( 1, 1, 1, 1 )
end
EnemyCard4 = {}
EnemyCard4.__index = EnemyCard4

function EnemyCard4:new(id)
	local o = {}
	o.id = id or 1
	o.nameLabel 	   = Label:new(4, 0, "placeholder", MiniFont, "left", "up", 300, 10, {1, 1, 1, 1})
	o.nameLabelShadow  = Label:new(5, 1, "placeholder", MiniFont, "left", "up", 300, 10, {0, 0, 0, 1})
	o.roomLabel		  = Label:new(14, 0, "placeholder", MiniFont, "center", "up", 300, 10, {1, 1, 1, 1})
	o.roomLabelShadow = Label:new(15, 1, "placeholder", MiniFont, "center", "up", 300, 10, {0, 0, 0, 1})
	o.healthLabel	   = Label:new(0, 1, "placeholder", MiniFont, "right", "up", 296, 10, {1, 1, 1, 1})
	o.healthLabelShadow= Label:new(1, 2, "placeholder", MiniFont, "right", "up", 296, 10, {0, 0, 0, 1})

	return setmetatable(o, self)
end

function EnemyCard4:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local enemy = Enemies[self.id]

	love.graphics.setColor( 109/255, 131/255, 227/255, 1 )
	--love.graphics.rectangle('line',2,2,76,11,1,1,1)
	--if Enemies2[self.id].HP>= 0x8000
	--or Enemies2[self.id].HP == 0x0
	--or Enemies2[self.id].nameID == 11
	--or Enemies2[self.id].nameID == 12
	--or Enemies2[self.id].nameID == 14
	--or Enemies2[self.id].nameID == 26
	--or Enemies2[self.id].nameID == 34
	--or Enemies2[self.id].nameID == 56 then
	--	love.graphics.setColor(1,0,0,0.3)
	--	love.graphics.rectangle('fill',4,15,294,1,0,0,1)
		--love.graphics.rectangle('fill',4,4,(GetHealthbar(Enemies2[self.id].HP, Enemies2[self.id].maxHP))*72,7,0,0,1)
	--else
		love.graphics.setColor(GetConditionColor3(GetConditionName2(Enemies2[self.id].HP, Enemies2[self.id].maxHP)))
		love.graphics.rectangle('fill',4,13,(Enemies2[self.id].HP / Enemies2[self.id].maxHP)*292,1,0,0,0)
	--end

	self.nameLabel.text = Enemies2[self.id].name
	--self.nameLabelShadow.text = Enemies2[self.id].name
	--self.nameLabelShadow:draw()
	self.nameLabel:draw()
	self.nameLabel.color = GetEnemyColor2(self.id)

	self.healthLabel.text = GetEnemiesHealthString2(self.id)
	--self.healthLabelShadow.text = GetEnemiesHealthString2(self.id)
	--self.healthLabelShadow:draw()
	self.healthLabel:draw()

	self.roomLabel.text = GetRoomName(GameInfo.scenario, Enemies2[self.id].roomID)
	--self.roomLabelShadow.text = GetRoomName(GameInfo.scenario, Enemies2[self.id].roomID)
	--self.roomLabelShadow:draw()
	self.roomLabel:draw()

	love.graphics.pop()
	love.graphics.setColor( 1, 1, 1, 1 )
end
BossCard = {}
BossCard.__index = BossCard

function BossCard:new(id)
	local o = {}
	o.id = id or 1
	o.nameLabel 	   = Label:new(4, 0, "placeholder", VerySmallFont, "left", "up", 300, 10, {1, 1, 1, 1})
	o.nameLabelShadow  = Label:new(5, 1, "placeholder", VerySmallFont, "left", "up", 300, 10, {0, 0, 0, 1})
	o.roomLabel		  = Label:new(14, 0, "placeholder", VerySmallFont, "center", "up", 300, 10, {1, 1, 1, 1})
	o.roomLabelShadow = Label:new(15, 1, "placeholder", VerySmallFont, "center", "up", 300, 10, {0, 0, 0, 1})
	o.healthLabel	   = Label:new(0, 1, "placeholder", VerySmallFont, "right", "up", 296, 10, {1, 1, 1, 1})
	o.healthLabelShadow= Label:new(1, 2, "placeholder", VerySmallFont, "right", "up", 296, 10, {0, 0, 0, 1})

	return setmetatable(o, self)
end

function BossCard:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local boss = Boss[self.id]

	love.graphics.setColor( 109/255, 131/255, 227/255, 1 )
	--love.graphics.rectangle('line',2,2,76,11,1,1,1)
	--if Bosses[self.id].HP>= 0x8000
	--or Bosses[self.id].HP == 0x0
	--or Bosses[self.id].nameID == 11
	--or Bosses[self.id].nameID == 12
	--or Bosses[self.id].nameID == 14
	--or Bosses[self.id].nameID == 26
	--or Bosses[self.id].nameID == 34
	--or Bosses[self.id].nameID == 56 then
	--	love.graphics.setColor(1,0,0,0.3)
	--	love.graphics.rectangle('fill',4,15,294,1,0,0,1)
		--love.graphics.rectangle('fill',4,4,(GetHealthbar(Bosses[self.id].HP, Bosses[self.id].maxHP))*72,7,0,0,1)
	--else
		love.graphics.setColor(GetConditionColor3(GetConditionName2(Boss[self.id].HP, Boss[self.id].maxHP)))
		love.graphics.rectangle('fill',4,16,(Boss[self.id].HP / Boss[self.id].maxHP)*292,1,0,0,0)
	--end

	self.nameLabel.text = Boss[self.id].name
	self.nameLabelShadow.text = Boss[self.id].name
	self.nameLabelShadow:draw()
	self.nameLabel:draw()
	self.nameLabel.color = GetBossColor(self.id)

	self.healthLabel.text = GetBossHealthString(self.id)
	self.healthLabelShadow.text = GetBossHealthString(self.id)
	self.healthLabelShadow:draw()
	self.healthLabel:draw()

	self.roomLabel.text = GetRoomName(GameInfo.scenario, Boss[self.id].roomID)
	self.roomLabelShadow.text = GetRoomName(GameInfo.scenario, Boss[self.id].roomID)
	self.roomLabelShadow:draw()
	self.roomLabel:draw()

	love.graphics.pop()
	love.graphics.setColor( 1, 1, 1, 1 )
end
