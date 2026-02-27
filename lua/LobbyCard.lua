LobbyCard = {}
LobbyCard.__index = LobbyCard

function LobbyCard:new(id)
	local o = {}
	o.id = id or 1

	o.slotLabel				= Label:new(10,31, "placeholder", VerySmallFont, "right", "up", 20, 20)
	o.slotLabelShadow		= Label:new(11,32, "placeholder", VerySmallFont, "right", "up", 20, 20, {10/255, 10/255, 10/255, 1})
	o.scenarioLabel			= Label:new(40,31, "placeholder", VerySmallFont, "left", "up", 150, 20)
	o.scenarioLabelShadow	= Label:new(41,32, "placeholder", VerySmallFont, "left", "up", 150, 20, {10/255, 10/255, 10/255, 1})
	o.versionLabel			= Label:new(170,31, "placeholder", VerySmallFont, "left", "up", 150, 12, {120/255, 180/255, 240/255, 1})
	o.versionLabelShadow	= Label:new(171,32, "placeholder", VerySmallFont, "left", "up", 150, 12, {10/255, 10/255, 10/255, 1})
	o.playerLabel			= Label:new(250,31, "placeholder", VerySmallFont, "left", "up", 50, 24)
	o.playerLabelShadow		= Label:new(251,32, "placeholder", VerySmallFont, "left", "up", 50, 24, {10/255, 10/255, 10/255, 1})

	return setmetatable(o, self)
end

function LobbyCard:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local slot = Slots[self.id]

	--UIAtlas:draw("slot bar", 0, 30, 0, 1)
	love.graphics.setColor( 75/255, 100/255, 160/255, 1 )
	love.graphics.rectangle('line',4,30,292,32,4,4,1)
	love.graphics.setColor( 1, 1, 1, 1 )

	if Slots[self.id].pass ==1 then
	UIAtlas:draw("key", 8, 44, 0, 0.75)
	end
	self.slotLabel.text = GetSlotString(self.id)
	self.slotLabelShadow.text = GetSlotString(self.id)
	self.slotLabelShadow:draw()
	self.slotLabel:draw()

	self.versionLabel.text = GetVersionString(self.id)
	self.versionLabelShadow.text = GetVersionString(self.id)
	self.versionLabelShadow:draw()
	self.versionLabel:draw()

	self.scenarioLabel.text = GetScenarioIDString(self.id)
	self.scenarioLabelShadow.text = GetScenarioIDString(self.id)
	self.scenarioLabelShadow:draw()
	self.scenarioLabel:draw()

	self.playerLabel.color = GetSlotsColor(self.id)
	self.playerLabel.text = GetPlayerString(self.id)
	self.playerLabelShadow.text = GetPlayerString(self.id)
	self.playerLabelShadow:draw()
	self.playerLabel:draw()

	love.graphics.pop()
end
