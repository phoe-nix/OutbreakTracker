LobbyCard = {}
LobbyCard.__index = LobbyCard

function LobbyCard:new(id)
	local o = {}
	o.id = id or 1

	o.slotLabel	   = Label:new(10,31, "placeholder", VerySmallFont, "right", "up", 20, 20)
	o.scenarioLabel	   = Label:new(40,31, "placeholder", VerySmallFont, "left", "up", 130, 20)
	o.versionLabel	   = Label:new(170,31, "placeholder", VerySmallFont, "left", "up", 150, 12, {120/255, 180/255, 240/255, 1})
	o.playerLabel	   = Label:new(250,31, "placeholder", VerySmallFont, "left", "up", 50, 24)

	return setmetatable(o, self)
end

function LobbyCard:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local slot = Slots[self.id]

	UIAtlas:draw("slot bar", 0, 30, 0, 1)

	if Slots[self.id].pass ==1 then
	UIAtlas:draw("key", 8, 44, 0, 0.75)
	end
	self.slotLabel.text = GetSlotString(self.id)
	self.slotLabel:draw()

	self.versionLabel.text = GetVersionString(self.id)
	self.versionLabel:draw()
	self.scenarioLabel.text = GetScenarioIDString(self.id)
	self.scenarioLabel:draw()

	self.playerLabel.color = GetSlotsColor(self.id)
	self.playerLabel.text = GetPlayerString(self.id)
	self.playerLabel:draw()

	love.graphics.pop()
end
