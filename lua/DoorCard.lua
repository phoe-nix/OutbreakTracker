DoorCard = {}
DoorCard.__index = DoorCard

function DoorCard:new(id)
	local o = {}
	o.id = id or 1
	--o.nameLabel 	   = Label:new(80, 0, "placeholder", VerySmallFont, "left", "up", 150, 10, {1, 1, 1, 1})
	--o.nameLabelShadow  = Label:new(81, 1, "placeholder", VerySmallFont, "left", "up", 150, 10, {0, 0, 0, 1})
	o.hpLabel	   = Label:new(0, 1, "placeholder", HPFont, "center", "up", 36, 10, {1, 1, 1, 1})
	o.hpLabelShadow= Label:new(1, 2, "placeholder", HPFont, "center", "up", 36, 10, {10/255, 10/255, 10/255, 1})
	--o.flagLabel	   = Label:new(0, 1+12, "placeholder", HPFont, "center", "up", 36, 10, {1, 1, 1, 1})
	--o.flagLabelShadow= Label:new(1, 2+12, "placeholder", HPFont, "center", "up", 36, 10, {0, 0, 0, 1})

	return setmetatable(o, self)
end

function DoorCard:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local s = GameInfo.scenario
	local door = Doors[self.id]
	if (s == "wild things") then
		if Doors[5].flag%8==1 then Doors[5].flag=0 end
		Doors[6].flag=Doors[6].flag%2
		Doors[7].flag=Doors[7].flag%2
		--if Doors[8].flag%4==1 then Doors[8].flag=0 end
		if Doors[3].flag%16<8 then Doors[3].flag=0 end
		if Doors[4].flag%8<4 then Doors[4].flag=0 end
	end
	if (s == "underbelly") then
		Doors[11].flag=Doors[11].flag%2
		if Doors[12].flag%8==1 then Doors[12].flag=0 end
	end
	if (Doors[self.id].HP== 500
	or Doors[self.id].HP== 0
	or Doors[self.id].flag==0
	or Doors[self.id].flag==0x0A
	or Doors[self.id].flag==0x0C
	or Doors[self.id].flag==0x2C
	or Doors[self.id].flag==0x82) then
		if (Doors[self.id].HP> 9999) then
		love.graphics.setColor( 1, 1, 1, 1 )
		love.graphics.rectangle('line',1,3,34,11,0,0,0)
		love.graphics.setColor(0,0,1,0.3)
		love.graphics.rectangle('fill',0,2,36,13,0,0,0)
		else
		love.graphics.setColor( 1, 1, 1, 1 )
		love.graphics.rectangle('line',5,3,27,11,0,0,0)
		love.graphics.setColor(0,0,1,0.3)
		love.graphics.rectangle('fill',4,2,29,13,0,0,0)
		end
	else
		if (Doors[self.id].HP> 9999) then
		love.graphics.setColor( 1, 1, 1, 0.1 )
		love.graphics.rectangle('line',1,3,34,11,0,0,0)
		love.graphics.setColor( 1, 0, 0, 0.35 )
		love.graphics.rectangle('fill',0,2,36,13,0,0,0)
		else
		love.graphics.setColor( 1, 1, 1, 0.1 )
		love.graphics.rectangle('line',5,3,27,11,0,0,0)
		love.graphics.setColor( 1, 0, 0, 0.35 )
		love.graphics.rectangle('fill',4,2,29,13,0,0,0)
		end
	end
	--self.nameLabel.color=(GetConditionColor2(GetConditionName2(Doors[self.id].HP, Doors[self.id].maxHP)))

	self.hpLabel.text = Doors[self.id].HP
	self.hpLabelShadow.text = Doors[self.id].HP
	self.hpLabelShadow:draw()
	self.hpLabel:draw()

	--self.flagLabel.text = Doors[self.id].flag
	--self.flagLabelShadow.text = Doors[self.id].flag
	--self.flagLabelShadow:draw()
	--self.flagLabel:draw()

	love.graphics.pop()
	love.graphics.setColor( 1, 1, 1, 1 )
end