DoorCard = {}
DoorCard.__index = DoorCard

function DoorCard:new(id)
	local o = {}
	o.id = id or 1
	--o.nameLabel 	   = Label:new(80, 0, "placeholder", VerySmallFont, "left", "up", 150, 10, {1, 1, 1, 1})
	--o.nameLabelShadow  = Label:new(81, 1, "placeholder", VerySmallFont, "left", "up", 150, 10, {0, 0, 0, 1})
	o.hpLabel	   = Label:new(0, 1, "placeholder", VerySmallFont, "center", "up", 36, 10, {1, 1, 1, 1})
	o.hpLabelShadow= Label:new(1, 2, "placeholder", VerySmallFont, "center", "up", 36, 10, {0, 0, 0, 1})

	return setmetatable(o, self)
end

function DoorCard:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local door = Doors[self.id]
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

	love.graphics.pop()
	love.graphics.setColor( 1, 1, 1, 1 )
end
