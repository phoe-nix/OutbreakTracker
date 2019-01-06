local tracker = require "luaoutbreaktracker"

require "assets"
require "helpers"
require "ItemIcon"
require "Label"
require "PlayerCard"

local InitResult = false
local RetryTimer = 0

local errorX, errorY = 0, 300

Players = {}
GameInfo = {}

PlayerCards = {}

function love.load(args)
	LoadAssets()
	InitResult = tracker.init()
	for i=1, 4 do
		PlayerCards[i] = PlayerCard:new(i)
	end
end

function love.draw()
	if InitResult == true and not(GameInfo.currentFile == 255) then
		for i=1, 4 do
			if Players[i].enabled then
				PlayerCards[i]:draw(0, (i-1)*150)
			end
		end
		love.graphics.setFont(TimeFont)
		if not(GameInfo.scenario == "") then
			love.graphics.printf(Time2string(GameInfo.frames / 0.03), 0, 605, 300, "center")
		end
		love.graphics.setFont(DefaultFont)
	elseif InitResult == false then
		love.graphics.setFont(DefaultFont)
		love.graphics.printf("Unable to find PCSX2 process.\n Will try again in " .. tostring(math.floor(5-RetryTimer + 0.5)) .. ".", errorX, errorY, 300, "center")
	elseif InitResult == true and GameInfo.currentFile == 255 then
		love.graphics.setFont(DefaultFont)
		love.graphics.printf("This is not an Biohazard Outbreak game.", errorX, errorY, 300, "center")
	end
end

function love.update(dt)
	if not InitResult then
		RetryTimer = RetryTimer + dt
		if RetryTimer >= 5 then
			RetryTimer = 0
			InitResult = tracker.init()
		end
	end 
	if InitResult then
		tracker.update()
		GameInfo = tracker.getGameInfo()
		if GameInfo.currentFile > 0 then
			for i=1, 4 do
				Players[i] = tracker.getPlayer(i)
			end
		end
	end
end

