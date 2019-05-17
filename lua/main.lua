local tracker = require "luaoutbreaktracker"

require "assets"
require "helpers"
require "ItemIcon"
require "Label"
require "PlayerCard"
require "EnemyCard"
require "LobbyCard"
require "ItemCard"

local InitResult = false
local RetryTimer = 0

local errorX, errorY = 0, 300
Slots = {}
Items = {}
Players = {}
Enemies = {}
GameInfo = {}

LobbyCards = {}
ItemCards = {}
PlayerCards = {}
EnemyCards = {}

function love.load(args)
	LoadAssets()
	InitResult = tracker.init()
	for i=1, 20 do
		LobbyCards[i] = LobbyCard:new(i)
	end
	for i=1, 1 do
		ItemCards[i] = ItemCard:new(i)
	end
	for i=1, 4 do
		PlayerCards[i] = PlayerCard:new(i)
	end
	for i=1, 12 do
		EnemyCards[i] = EnemyCard:new(i)
	end
	--love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=400, minheight=300})
end

function love.draw()
	wx, wy, display = love.window.getMode()-- get window size
	love.graphics.scale(wx/300, wy/705)

	local p = GameInfo.playernum
	if InitResult == true and not(GameInfo.currentFile == 255) then
		love.graphics.setFont(TimeFont)
		if not(GameInfo.scenario == "") then
			love.graphics.printf(Time2string(GameInfo.frames/0.03), 0, (145*p), 270, "right")
			--love.graphics.setFont(DefaultFont)
			--love.graphics.printf(GameInfo.scenario,0, 625,300, "right") --scenario
		end
		if (GameInfo.hoststatus >= 4 and GameInfo.hoststatus < 6 and GameInfo.scenario == "") then
			love.graphics.printf(Time2string2(GameInfo.hosttime), 10, 190, 300, "left")
			love.graphics.printf(GameInfo.hostplayer.."/"..GameInfo.hostmaxplayer+2,0, 190,290, "right")
			UIAtlas:draw(GameInfo.hostscenario, 0, 0, 0, 1)
			love.graphics.setFont(DefaultFont)
			love.graphics.printf(GameInfo.difficulty, 0, 190, 300, "center")
		end
		if (GameInfo.scenario == "wild things") then
			--UIAtlas:draw("wild things", 0, 576,0,0.6)
			ItemIcons:draw("2/14005", 0, (145*p)-3,0,0.5)
			love.graphics.printf(GameInfo.p1coins+GameInfo.p2coins+GameInfo.p3coins+GameInfo.p4coins, 26,(145*p), 300, "left")
		elseif (GameInfo.scenario == "desperate times") then
				love.graphics.printf((GameInfo.killedzombies), 0, (145*p), 300, "left")
		end

		if (GameInfo.hoststatus == 3 and GameInfo.scenario == "") then
			UIAtlas:draw("title bar", 0, 2, 0, 1)
			love.graphics.setFont(VerySmallFont)
			love.graphics.printf("No.",10, 8,20, "right")
			love.graphics.printf("Title & Scenario",40, 8,130, "left")
			love.graphics.printf("HEADS",250, 8,50, "left")
			for i=1, 20 do
				LobbyCards[i]:draw(0, (i-1)*32)		
			end
		end

		for i=1, 1 do
			if not(GameInfo.scenario == "") then
			--if Players2[i].enabled then
				ItemCards[i]:draw(0, (145*p)*(1/0.45)+40)
			--end
			end
		end
		for i=1, 4 do
			if Players[i].enabled then
				PlayerCards[i]:draw(0, (i-1)*145)
			end
		end
		for i=1, 6 do
			if Enemies[i].inGame then
				EnemyCards[i]:draw(0,(i-1)*14+(145*p)+45)
			end
		end
		for i=7, 12 do
			if Enemies[i].inGame then
				EnemyCards[i]:draw(152,(i-7)*14+(145*p)+45)
			end
		end
		for i=12, 12 do--for plant boss
			if Enemies[i].enabled then
				EnemyCards[i]:draw(152,(i-7)*14+(145*p)+45)
			end
		end
	elseif InitResult == false then
		love.graphics.setFont(DefaultFont)
		love.graphics.printf("Unable to find PCSX2 process.\n Will try again in " .. tostring(math.floor(5-RetryTimer + 0.5)) .. ".", errorX, errorY, 300, "center")
	elseif InitResult == true and GameInfo.currentFile == 255 then
		love.graphics.setFont(DefaultFont)
		love.graphics.printf("This is not an Biohazard Outbreak game.\n Will try again in " .. tostring(math.floor(5-RetryTimer + 0.5)) .. ".", errorX, errorY, 300, "center")
	end
end

function love.update(dt)
	if not InitResult or GameInfo.currentFile == 255 then
		RetryTimer = RetryTimer + dt
		if RetryTimer >= 5 then
			RetryTimer = 0
			InitResult = tracker.init()
		end
	end
	if InitResult then
		tracker.updateLobby()
		tracker.updatePlayer()
		tracker.updateItem()
		--tracker.updateBoss()
		tracker.updateEnemy()
		GameInfo = tracker.getGameInfo()
		if GameInfo.currentFile > 0 then
			for i=1, 20 do
				Slots[i] = tracker.getLobby(i)
			end
			for i=1, 1 do
				Items[i] = tracker.getItem(i)
			end
			for i=1, 4 do
				Players[i] = tracker.getPlayer(i)
			end
			for i=1, 12 do
				Enemies[i] = tracker.getEnemy(i)
			end
		end
	end
end

function love.keypressed(key)
	x, y, display = love.window.getPosition()
	wx, wy, display = love.window.getMode()
	local p = GameInfo.playernum
	if not(GameInfo.scenario == "") then
    if key == "s" then love.window.setMode(110, (145*p)) love.window.setPosition( x, y ) end
    if key == "t" then love.window.setMode(300, 20+(145*p)) love.window.setPosition( x, y )end
    if key == "e" then love.window.setMode(300, 105+(145*p)) love.window.setPosition( x, y )end
    if key == "d" then love.window.setMode(300, 705) love.window.setPosition( x, y )end
	if key == "f4" then love.window.setMode(wx, wy,{resizable=true, vsync=false, borderless=true}) love.window.setPosition( x, y )end
	end
end