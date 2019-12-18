local tracker = require "luaoutbreaktracker"

require "assets"
require "helpers"
require "ItemIcon"
require "Label"
require "PlayerCard"
require "SPlayerCard"
require "EnemyCard"
require "EnemyCard2"
require "EnemyCard3"
require "LobbyCard"
require "ItemCard"
require "ItemCard2"

local InitResult = false
local RetryTimer = 0
local scalex,scaley = 300, 740
local errorX, errorY = 0, 300
local PlayerSwtich=0
local TimeSwtich=1
local EnemyHPSwtich=1
local ItemSwtich=1
local Style=0
local HelpMenu=0
local ItemList=0
local RoomName=1

Slots = {}
Items = {}
Items2 = {}
Players = {}
SPlayers = {}
Enemies = {}
GameInfo = {}

LobbyCards = {}
ItemCards = {}
ItemCards2 = {}
ItemCards3 = {}
PlayerCards = {}
SPlayerCards = {}
EnemyCards = {}
EnemyCards2 = {}
EnemyCards3 = {}

function love.load(args)
	LoadAssets()
	InitResult = tracker.init()
	for i=1, 20 do
		LobbyCards[i] = LobbyCard:new(i)
	end
	for i=1, 1 do
		ItemCards[i] = ItemCard:new(i)
	end
	for i=1, 255 do
		ItemCards2[i] = ItemCard2:new(i)
	end
	for i=1, 255 do
		ItemCards3[i] = ItemCard3:new(i)
	end
	for i=1, 4 do
		PlayerCards[i] = PlayerCard:new(i)
	end
	for i=1, 4 do
		SPlayerCards[i] = SPlayerCard:new(i)
	end
	for i=1, 12 do
		EnemyCards[i] = EnemyCard:new(i)
	end
	for i=1, 12 do
		EnemyCards2[i] = EnemyCard2:new(i)
	end
	for i=1, 12 do
		EnemyCards3[i] = EnemyCard3:new(i)
	end
	--love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=400, minheight=300})
end

function love.draw()
	wx, wy, display = love.window.getMode()-- get window size
	love.graphics.scale(wx/scalex, wy/scaley)

	local p = GameInfo.playernum

	if InitResult == true and not(GameInfo.currentFile == 255) then
		love.graphics.setFont(TimeFont)
		if Style==0 then
			if not(GameInfo.scenario == "") then
				if EnemyHPSwtich==2 then
					if GameInfo.currentFile == 1 then
						love.graphics.printf(GameInfo.itemrandom%5+1, 0, (145*4+105), 12, "left")
					else
						love.graphics.printf(GameInfo.itemrandom+1, 0, (145*4+105), 12, "left")
					end
				else
					if GameInfo.currentFile == 1 then
						love.graphics.printf(GameInfo.itemrandom%5+1, 0, (145*p+105), 12, "left")
					else
						love.graphics.printf(GameInfo.itemrandom+1, 0, (145*p+105), 12, "left")
					end
				end
				if TimeSwtich==1 and EnemyHPSwtich<2 then
				love.graphics.printf(Time2string(GameInfo.frames/0.03), 0, (145*p), 300, "right")
				end
				--love.graphics.setFont(DefaultFont)
				--love.graphics.printf(GameInfo.scenario,0, 625,300, "right") --scenario
			end
			if (GameInfo.hoststatus >= 4 and GameInfo.hoststatus < 6 and GameInfo.scenario == "") then
				UIAtlas:draw(GameInfo.hostscenario, 0, 580, 0, 0.85)
				love.graphics.printf(Time2string2(GameInfo.hosttime), 15, 595, 300, "left")
				love.graphics.printf(GameInfo.hostplayer.."/"..GameInfo.hostmaxplayer+2, 15, 620, 300, "left")
				love.graphics.setFont(DefaultFont)
				love.graphics.printf(GameInfo.hostdifficulty, 0, 590, 200, "right")

				for i=1, 4 do
					if SPlayers[i].enabled then
						SPlayerCards[i]:draw(0, (i-1)*145)
					end
				end
			end

			if (GameInfo.frames>0) then
				if EnemyHPSwtich<2 then
					if (GameInfo.scenario == "wild things") then
						--UIAtlas:draw("wild things", 0, 576,0,0.6)
						ItemIcons:draw("2/14005", 0, (145*p)-3,0,0.5)
						love.graphics.printf(GameInfo.p1coins+GameInfo.p2coins+GameInfo.p3coins+GameInfo.p4coins, 26,(145*p), 300, "left")
					elseif (GameInfo.scenario == "desperate times") then
						if(GameInfo.fighttime2 == 0) then
							love.graphics.printf((GameInfo.killedzombies), 0, (145*p), 300, "left")
						end
						if(GameInfo.garagetime > 0)then
							love.graphics.printf(Time2string3(GameInfo.garagetime), 70, (145*p), 60, "center",0,1,1)
						end
						if(GameInfo.fighttime > 0) and (GameInfo.fighttime2 == 0xffff)then
							love.graphics.printf(Time2string3(GameInfo.fighttime), 0, (145*p), 60, "center",0,1,1)
						end
						if(GameInfo.fighttime2 > 0) and not (GameInfo.fighttime2 == 0xffff) then
							love.graphics.printf(Time2string3(GameInfo.fighttime2), 0, (145*p), 60, "center",0,1,1)
						end
						--ItemIcons:draw("2/11511", 0-4, (145*p-8),0,0.65)
						--love.graphics.printf(Time2string3(GameInfo.gastime), 70, (145*p), 60, "center",0,1,1)
						ItemIcons:draw("2/11511", 150-8, (145*p)+56,0,0.75)
						--love.graphics.printf((GameInfo.gasflag), 0, (145*p), 100, "center")
						--love.graphics.printf(IsOuNumber(GameInfo.gasrandom), 0, (145*p), 280, "center")
						love.graphics.printf(Time2string3(GameInfo.gastime), 150-8, (145*p)+90, 56, "center",0,0.65,0.65)
						love.graphics.setFont(VerySmallFont)
						if(GameInfo.gasflag == 1) and (GameInfo.gasrandom%2 == 0) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"Hallway\n1F lobby\nB1F West hall"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"Hallway\nB1F West hall"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 2) and (GameInfo.gasrandom%2 == 0) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"2F East hall\nNight-duty room\nAutopsy Room"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"2F East hall\nAutopsy Room"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 4) and (GameInfo.gasrandom%2 == 0) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"Waiting room\n1F East hall\nParking Garage"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"1F East hall\nParking Garage"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 8) and (GameInfo.gasrandom%2 == 0) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"2F East hall\nEast office\nInterrogation room"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"East office\nInterrogation room"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 16) and (GameInfo.gasrandom%2 == 0) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nB1F East hall\nNight-duty room"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"B1F East hall\nNight-duty room"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 32) and (GameInfo.gasrandom%2 == 0) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"East office\nSubstation room\nKennel"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"Substation room\nKennel"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 64) and (GameInfo.gasrandom%2 == 0) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nB1F East hall\nParking Garage"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nB1F East hall"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 128) and (GameInfo.gasrandom%2 == 0) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"Interrogation room\nB1F West hall\nKennel"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"B1F West hall\nKennel"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 256) and (GameInfo.gasrandom%2 == 0) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"Waiting room\nHallway\nB1F East hall"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"Hallway\nB1F East hall"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 512) and (GameInfo.gasrandom%2 == 0) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"East office\n1F East hall\nSubstation room"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"1F Lobby\n1F East hall"}, 180, (145*p)+60, 150, "left")
							end
						end
    
						if(GameInfo.gasflag == 1) and (GameInfo.gasrandom%2 == 1) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nNight-duty room\nSubstation room"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"Night-duty room\nSubstation room"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 2) and (GameInfo.gasrandom%2 == 1) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"Waiting room\n1F Lobby\nB1F West Hall"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"Waiting room\nB1F West Hall"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 4) and (GameInfo.gasrandom%2 == 1) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nHallway\nSubstation room"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nHallway"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 8)and (GameInfo.gasrandom%2 == 1) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"Interrogation room\n1F East hall\nParking garage"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"1F East hall\nParking garage"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 16) and (GameInfo.gasrandom%2 == 1) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"Night-duty room\nAutopsy room\nKennel"}, 180, (145*p)+60, 180,  "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"Autopsy room\nKennel"}, 180, (145*p)+60, 180,  "left")
							end
						elseif(GameInfo.gasflag == 32) and (GameInfo.gasrandom%2 == 1) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"East office\nInterrogation room\nSubstation room"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"East office\nInterrogation room"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 64) and (GameInfo.gasrandom%2 == 1) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"Waiting room\nEast office\nB1F East Hall"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"Waiting room\nB1F East Hall"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 128) and (GameInfo.gasrandom%2 == 1) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"2F East Hall\n1F Lobby\nHallway"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nHallway"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 256) and (GameInfo.gasrandom%2 == 1) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"Night-duty room\nAutopsy room\nParking garage"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"Autopsy room\nParking garage"}, 180, (145*p)+60, 150, "left")
							end
						elseif(GameInfo.gasflag == 512) and (GameInfo.gasrandom%2 == 1) then
							if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
								love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nInterrogation room\nKennel"}, 180, (145*p)+60, 150, "left")
							elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
								love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nInterrogation room"}, 180, (145*p)+60, 150, "left")
							end
						end
    
					elseif (GameInfo.scenario == "below freezing point") then
						love.graphics.setFont(DefaultFont)
						if(GameInfo.pass1 >= 0x0 and GameInfo.pass1 <= 0x1F or GameInfo.pass1 >= 0x80 and GameInfo.pass1 <= 0x9F) then
							love.graphics.printf("0634", 0, (145*p), 300, "left")
						elseif(GameInfo.pass1 >= 0x20 and GameInfo.pass1 <= 0x3F or GameInfo.pass1 >= 0xA0 and GameInfo.pass1 <= 0xBF) then
							love.graphics.printf("4509", 0, (145*p), 300, "left")
						elseif(GameInfo.pass1 >= 0x40 and GameInfo.pass1 <= 0x7F or GameInfo.pass1 >= 0xC0 and GameInfo.pass1 <= 0xFF) then
							love.graphics.printf("9741", 0, (145*p), 300, "left")
						end
						if(GameInfo.pass2 == 0x20) then
							love.graphics.printf("-A375-B482", 40, (145*p), 300, "left")
						elseif(GameInfo.pass2 == 0x40) then
							love.graphics.printf("-J126-D580", 40, (145*p), 300, "left")
						elseif(GameInfo.pass2 == 0x80) then
							love.graphics.printf("-C582-A194", 40, (145*p), 300, "left")
						end
					elseif (GameInfo.scenario == "the hive") then
						love.graphics.setFont(DefaultFont)
						if(GameInfo.pass1 >= 0x0 and GameInfo.pass1 <= 0x1F or
							GameInfo.pass1 >= 0x80 and GameInfo.pass1 <= 0x9F) then
							love.graphics.printf("3555-0930", 0, (145*p), 300, "left")
						elseif(GameInfo.pass1 >= 0x20 and GameInfo.pass1 <= 0x3F or
								GameInfo.pass1 >= 0x60 and GameInfo.pass1 <= 0x7F or
								GameInfo.pass1 >= 0xA0 and GameInfo.pass1 <= 0xBF or
								GameInfo.pass1 >= 0xE0 and GameInfo.pass1 <= 0xFF) then
								love.graphics.printf("5315-0930", 0, (145*p), 300, "left")
						elseif(GameInfo.pass1 >= 0x40 and GameInfo.pass1 <= 0x5F or
							GameInfo.pass1 >= 0xC0 and GameInfo.pass1 <= 0xDF) then
							love.graphics.printf("8211-0930", 0, (145*p), 300, "left")
						end
					elseif (GameInfo.scenario == "hellfire") then
						love.graphics.setFont(DefaultFont)
						if(GameInfo.pass3 >= 0x0 and GameInfo.pass3 <= 0x1) then
							love.graphics.printf("0721-DCH", 0, (145*p), 300, "left")
						elseif(GameInfo.pass3 >= 0x2 and GameInfo.pass3 <= 0x3) then
							love.graphics.printf("2287-JIA", 0, (145*p), 300, "left")
						elseif(GameInfo.pass3 >= 0x4 and GameInfo.pass3 <= 0x7) then
							love.graphics.printf("6354-BAE", 0, (145*p), 300, "left")
						elseif(GameInfo.pass3 >= 0x8 and GameInfo.pass3 <= 0xF) then
							love.graphics.printf("5128-GGF", 0, (145*p), 300, "left")
						end
						if(GameInfo.pass4 == 0x4000) then
							love.graphics.printf("-1234", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x4020) then
							love.graphics.printf("-234", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x4040) then
							love.graphics.printf("-134", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x4060) then
							love.graphics.printf("-34", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x4080) then
							love.graphics.printf("-124", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x40C0) then
							love.graphics.printf("-14", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x40E0) then
							love.graphics.printf("-4", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x4100) then
							love.graphics.printf("-123", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x4120) then
							love.graphics.printf("-23", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x4140) then
							love.graphics.printf("-13", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x4160) then
							love.graphics.printf("-3", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x4180) then
							love.graphics.printf("-12", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x41A0) then
							love.graphics.printf("-2", 85, (145*p), 300, "left")
						elseif(GameInfo.pass4 == 0x41C0) then
							love.graphics.printf("-1", 85, (145*p), 300, "left")
						end
					elseif (GameInfo.scenario == "decisions,decisions") then
						love.graphics.setFont(DefaultFont)
						if(GameInfo.pass3 == 0x40) then
							love.graphics.printf("4161", 0, (145*p), 300, "left")
						elseif(GameInfo.pass3 == 0x80) then
							love.graphics.printf("4032", 0, (145*p), 300, "left")
						elseif(GameInfo.pass3 == 0x00) and (GameInfo.pass6%2 == 0x1) then
								love.graphics.printf("4927", 0, (145*p), 300, "left")
						elseif(GameInfo.pass3 == 0x00) and (GameInfo.pass6%2 == 0x0) then
								love.graphics.printf("4284", 0, (145*p), 300, "left")
						end

						if(GameInfo.difficulty == "easy") then
							love.graphics.printf("-03:25", 40, (145*p), 300, "left")
						elseif(GameInfo.difficulty == "normal") then
							love.graphics.printf("-10:05", 40, (145*p), 300, "left")
						elseif(GameInfo.difficulty == "hard") then
							love.graphics.printf("-07:40", 40, (145*p), 300, "left")
						elseif(GameInfo.difficulty == "very hard") then
							love.graphics.printf("-02:50", 40, (145*p), 300, "left")
						end

					elseif (GameInfo.scenario == "underbelly") then
						if(GameInfo.escapetime == 0 or GameInfo.escapetime == 0xffff)then
							love.graphics.setFont(DefaultFont)
							if(GameInfo.passub1 >= 0x2) and (GameInfo.passub1 < 0x4) then
								love.graphics.printf("2916", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x4) and (GameInfo.passub1 < 0x8)then
								love.graphics.printf("3719", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x8) and (GameInfo.passub1 < 0x10)then
								love.graphics.printf("0154", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x10) and (GameInfo.passub1 < 0x20)then
								love.graphics.printf("6443", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x20) and (GameInfo.passub1 < 0x40)then
								love.graphics.printf("7688", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x40) and (GameInfo.passub1 < 0x80)then
								love.graphics.printf("1812", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x80) and (GameInfo.passub1 < 0x100)then
								love.graphics.printf("5551", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x100) and (GameInfo.passub1 < 0x200)then
								love.graphics.printf("6010", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x200) and (GameInfo.passub1 < 0x400)then
								love.graphics.printf("0652", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x400) and (GameInfo.passub1 < 0x800)then
								love.graphics.printf("6234", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x800) and (GameInfo.passub1 < 0x1000)then
								love.graphics.printf("0533", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x1000) and (GameInfo.passub1 < 0x2000)then
								love.graphics.printf("9439", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x2000) and (GameInfo.passub1 < 0x4000)then
								love.graphics.printf("1421", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x4000) and (GameInfo.passub1 < 0x8000)then
								love.graphics.printf("1127", 0, (145*p), 300, "left")
							elseif(GameInfo.passub1 >= 0x8000) and (GameInfo.passub1 < 0x10000)then
								love.graphics.printf("7840", 0, (145*p), 300, "left")
							elseif(GameInfo.passub2%2 == 0x1) then
									love.graphics.printf("6910", 0, (145*p), 300, "left")
							end
						else
							love.graphics.setFont(TimeFont)
							love.graphics.printf(Time2string3(GameInfo.escapetime), 0, (145*p), 60, "center",0,1,1)
						end

					elseif (GameInfo.scenario == "flashback") then
						if(GameInfo.escapetime > 0) and not (GameInfo.escapetime == 0xffff)then
							love.graphics.setFont(TimeFont)
							love.graphics.printf(Time2string3(GameInfo.escapetime), 0, (145*p), 60, "center",0,1,1)
						end

					elseif (GameInfo.scenario == "end of the road") then
						love.graphics.setFont(DefaultFont)
						love.graphics.printf(GameInfo.pass4, 0, (145*p), 300, "left")
					end
				end
			end

			if (GameInfo.hoststatus == 3 and GameInfo.scenario == "") then
				UIAtlas:draw("title bar", 0, 2, 0, 1)
				love.graphics.setFont(VerySmallFont)
				love.graphics.printf("No.",10, 8,20, "right")
				love.graphics.printf("Title & Scenario",40, 8,130, "left")
				love.graphics.printf("HEADS",240, 8,50, "left")
				for i=1, 20 do
					LobbyCards[i]:draw(0, (i-1)*32)		
				end
			end

			if PlayerSwtich==0 then
				for i=1, 4 do
					if Players[i].enabled then
						PlayerCards[i]:draw(0, (i-1)*145)
					end
				end
			end
			if PlayerSwtich==1 then
				for i=1, 1 do
					if Players[i].enabled then
						PlayerCards[i]:draw(0, (i-1)*145)
					end
				end
			end
			if PlayerSwtich==2 then
				for i=2, 2 do
					if Players[i].enabled then
						PlayerCards[i]:draw(0, (i-2)*145)
					end
				end
			end
			if PlayerSwtich==3 then
				for i=3, 3 do
					if Players[i].enabled then
						PlayerCards[i]:draw(0, (i-3)*145)
					end
				end
			end
			if PlayerSwtich==4 then
				for i=4, 4 do
					if Players[i].enabled then
						PlayerCards[i]:draw(0, (i-4)*145)
					end
				end
			end
			if EnemyHPSwtich==0 then
				for i=1, 6 do
					if Enemies[i].inGame then
						EnemyCards2[i]:draw(0,(i-1)*14+(145*p)+20)
					end
				end
				for i=7, 12 do
					if Enemies[i].inGame then
						EnemyCards2[i]:draw(152,(i-7)*14+(145*p)+20)
					end
				end
				for i=12, 12 do--for plant boss
					if Enemies[i].enabled then
						if not Enemies[i].inGame then
							EnemyCards2[i]:draw(152,(i-7)*14+(145*p)+20)
						end
					end
				end
			end
			if EnemyHPSwtich==1 then
				for i=1, 6 do
					if Enemies[i].inGame then
						EnemyCards[i]:draw(0,(i-1)*14+(145*p)+20)
					end
				end
				for i=7, 12 do
					if Enemies[i].inGame then
						EnemyCards[i]:draw(152,(i-7)*14+(145*p)+20)
					end
				end
				for i=12, 12 do--for plant boss
					if Enemies[i].enabled then
						if not Enemies[i].inGame then
							EnemyCards[i]:draw(152,(i-7)*14+(145*p)+20)
						end
					end
				end
			end
			if PlayerSwtich>0 and EnemyHPSwtich==2 then
				for i=1, 12 do
					if Enemies[i].inGame then
						EnemyCards3[i]:draw(0,(i-1)*40+(145*1))
					end
				end
				for i=12, 12 do--for plant boss
					if Enemies[i].enabled then
						if not Enemies[i].inGame then
							EnemyCards3[i]:draw(0,(i-1)*40+(145*1))
						end
					end
				end
			end
			if not(GameInfo.scenario == "") and (GameInfo.frames > 0) then
				if ItemSwtich ==1 then
					if EnemyHPSwtich==2 then
						for i=1, 1 do
							ItemCards[i]:draw(20, (145*4)*(1/0.6)+(100/0.6))
						end
					else
						for i=1, 1 do
							ItemCards[i]:draw(20, (145*p)*(1/0.6)+(100/0.6))
						end	
					end
				end
				if ItemList==1 then
					love.graphics.rectangle('line',2,2,296,30*20,3,3,1)
					love.graphics.setColor( 0, 0, 0, 1 )
					love.graphics.rectangle('fill',2,2,296,30*20,3,3,1)
					love.graphics.setColor( 1, 1, 1, 1 )
					for i=1, 10 do
						ItemCards2[i]:draw(45*(i-1), 0)
					end
					for i=11, 20 do
						ItemCards2[i]:draw(45*(i-11), 44*1)
					end
					for i=21, 30 do
						ItemCards2[i]:draw(45*(i-21), 44*2)
					end
					for i=31, 40 do
						ItemCards2[i]:draw(45*(i-31), 44*3)
					end
					for i=41, 50 do
						ItemCards2[i]:draw(45*(i-41), 44*4)
					end
					for i=51, 60 do
						ItemCards2[i]:draw(45*(i-51), 44*5)
					end
					for i=61, 70 do
						ItemCards2[i]:draw(45*(i-61), 44*6)
					end
					for i=71, 80 do
						ItemCards2[i]:draw(45*(i-71), 44*7)
					end
					for i=81, 90 do
						ItemCards2[i]:draw(45*(i-81), 44*8)
					end
					for i=91, 100 do
						ItemCards2[i]:draw(45*(i-91), 44*9)
					end
					for i=101, 110 do
						ItemCards2[i]:draw(45*(i-101), 44*10)
					end
					for i=111, 120 do
						ItemCards2[i]:draw(45*(i-111), 44*11)
					end
					for i=121, 130 do
						ItemCards2[i]:draw(45*(i-121), 44*12)
					end
					for i=131, 140 do
						ItemCards2[i]:draw(45*(i-131), 44*13)
					end
					for i=141, 150 do
						ItemCards2[i]:draw(45*(i-141), 44*14)
					end
					for i=151, 160 do
						ItemCards2[i]:draw(45*(i-151), 44*15)
					end
					for i=161, 170 do
						ItemCards2[i]:draw(45*(i-161), 44*16)
					end
					for i=171, 180 do
						ItemCards2[i]:draw(45*(i-171), 44*17)
					end
					for i=181, 190 do
						ItemCards2[i]:draw(45*(i-181), 44*18)
					end
					for i=191, 200 do
						ItemCards2[i]:draw(45*(i-191), 44*19)
					end
					for i=201, 210 do
						ItemCards2[i]:draw(45*(i-201), 44*20)
					end
				end	
				if ItemList==2 then
					love.graphics.rectangle('line',2,2,296,30*20,3,3,1)
					love.graphics.setColor( 0, 0, 0, 1 )
					love.graphics.rectangle('fill',2,2,296,30*20,3,3,1)
					love.graphics.setColor( 1, 1, 1, 1 )
					for i=1, 10 do
						ItemCards3[i]:draw(45*(i-1), 0)
					end
					for i=11, 20 do
						ItemCards3[i]:draw(45*(i-11), 44*1)
					end
					for i=21, 30 do
						ItemCards3[i]:draw(45*(i-21), 44*2)
					end
					for i=31, 40 do
						ItemCards3[i]:draw(45*(i-31), 44*3)
					end
					for i=41, 50 do
						ItemCards3[i]:draw(45*(i-41), 44*4)
					end
					for i=51, 60 do
						ItemCards3[i]:draw(45*(i-51), 44*5)
					end
					for i=61, 70 do
						ItemCards3[i]:draw(45*(i-61), 44*6)
					end
					for i=71, 80 do
						ItemCards3[i]:draw(45*(i-71), 44*7)
					end
					for i=81, 90 do
						ItemCards3[i]:draw(45*(i-81), 44*8)
					end
					for i=91, 100 do
						ItemCards3[i]:draw(45*(i-91), 44*9)
					end
					for i=101, 110 do
						ItemCards3[i]:draw(45*(i-101), 44*10)
					end
					for i=111, 120 do
						ItemCards3[i]:draw(45*(i-111), 44*11)
					end
					for i=121, 130 do
						ItemCards3[i]:draw(45*(i-121), 44*12)
					end
					for i=131, 140 do
						ItemCards3[i]:draw(45*(i-131), 44*13)
					end
					for i=141, 150 do
						ItemCards3[i]:draw(45*(i-141), 44*14)
					end
					for i=151, 160 do
						ItemCards3[i]:draw(45*(i-151), 44*15)
					end
					for i=161, 170 do
						ItemCards3[i]:draw(45*(i-161), 44*16)
					end
					for i=171, 180 do
						ItemCards3[i]:draw(45*(i-171), 44*17)
					end
					for i=181, 190 do
						ItemCards3[i]:draw(45*(i-181), 44*18)
					end
					for i=191, 200 do
						ItemCards3[i]:draw(45*(i-191), 44*19)
					end
					for i=201, 210 do
						ItemCards3[i]:draw(45*(i-201), 44*20)
					end
						love.graphics.rectangle('line',2,605,296,133,3,3,1)
						love.graphics.setColor( 0, 0, 0, 0.85 )
						love.graphics.rectangle('fill',2,605,296,133,3,3,1)
						love.graphics.setColor( 1, 1, 1, 1 )
						love.graphics.setFont(MiniFont)
					if RoomName == 1 then
						for i=1,13 do
						love.graphics.printf("1"*(i-1)*2+1,2, 605+10*(i-1),12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+1),16, 606+10*(i-1),140, "left")
						love.graphics.printf("1"*(i-1)*2+2,150, 605+10*(i-1),12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+2),166, 606+10*(i-1),150, "left")
						end
					elseif RoomName == 2 then
						for i=1,13 do
						love.graphics.printf("1"*(i-1)*2+27,2, 605+10*(i-1),12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+27),16, 606+10*(i-1),150, "left")
						love.graphics.printf("1"*(i-1)*2+28,150, 605+10*(i-1),12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+28),166, 606+10*(i-1),150, "left")
						end
					elseif RoomName == 3 then
						for i=1,13 do
						love.graphics.printf("1"*(i-1)*2+53,2, 605+10*(i-1),12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+53),16, 606+10*(i-1),150, "left")
						love.graphics.printf("1"*(i-1)*2+54,150, 605+10*(i-1),12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+54),166, 606+10*(i-1),150, "left")
						end
					elseif RoomName == 4 then
						for i=1,10 do
						love.graphics.printf("1"*(i-1)*2+79,2, 605+10*(i-1),12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+79),16, 606+10*(i-1),150, "left")
						love.graphics.printf("1"*(i-1)*2+80,150, 605+10*(i-1),12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+80),166, 606+10*(i-1),150, "left")
						end
					end
				end	
			end
		end

		if Style==1 then
			if (GameInfo.hoststatus >= 4 and GameInfo.hoststatus < 6 and GameInfo.scenario == "") then
				UIAtlas:draw(GameInfo.hostscenario, 0, 0, 0, 0.60)
				love.graphics.printf(Time2string2(GameInfo.hosttime), 2, 115, 300, "left")
				love.graphics.printf(GameInfo.hostplayer.."/"..GameInfo.hostmaxplayer+2, 2, 135, 300, "left")
				love.graphics.setFont(DefaultFont)
				love.graphics.printf(GameInfo.hostdifficulty, 2, 155, 200, "left")

				for i=1, 4 do
					if SPlayers[i].enabled then
						SPlayerCards[i]:draw((i-1)*300+150, 0)
					end
				end
			end

			if not(GameInfo.scenario == "") then
				if p==1 then
					love.graphics.printf(Time2string(GameInfo.frames/0.03), 300*1, 185, 300, "right")
				else
					love.graphics.printf(Time2string(GameInfo.frames/0.03), 300*1, 185, 300, "right")
				end
				if GameInfo.currentFile == 1 then
					love.graphics.printf(GameInfo.itemrandom%5+1, 2, 145+5, 12, "left")
				else
					love.graphics.printf(GameInfo.itemrandom+1, 2, 145+5, 12, "left")
				end
			end
			if (GameInfo.frames>0) then
				if (GameInfo.scenario == "wild things") then
					--UIAtlas:draw("wild things", 0, 576,0,0.6)
					ItemIcons:draw("2/14005", 300*p, 185-3,0,0.5)
					love.graphics.printf(GameInfo.p1coins+GameInfo.p2coins+GameInfo.p3coins+GameInfo.p4coins, 300*p+26,185, 300, "left")
				elseif (GameInfo.scenario == "desperate times") then
					if(GameInfo.fighttime2 == 0) then
						love.graphics.printf((GameInfo.killedzombies), 300*p, 185, 300, "left")
					end
					if(GameInfo.garagetime > 0)then
						love.graphics.printf(Time2string3(GameInfo.garagetime), 300*p+70, 185, 60, "center",0,1,1)
					end
					if(GameInfo.fighttime > 0) and (GameInfo.fighttime2 == 0xffff)then
						love.graphics.printf(Time2string3(GameInfo.fighttime), 300*p, 185, 60, "center",0,1,1)
					end
					if(GameInfo.fighttime2 > 0) and not (GameInfo.fighttime2 == 0xffff) then
						love.graphics.printf(Time2string3(GameInfo.fighttime2), 300*p, 185, 60, "center",0,1,1)
					end
					--ItemIcons:draw("2/11511", 0-4, (145*p-8),0,0.65)
					--love.graphics.printf(Time2string3(GameInfo.gastime), 70, (145*p), 60, "center",0,1,1)
					ItemIcons:draw("2/11511", 300*p-5, 145+14,0,0.60)
					--love.graphics.printf((GameInfo.gasflag), 0, (145*p), 100, "center")
					--love.graphics.printf(IsOuNumber(GameInfo.gasrandom), 0, (145*p), 280, "center")
					love.graphics.printf(Time2string3(GameInfo.gastime), 300*p+20, 145+20, 56, "center",0,1,1)
					love.graphics.setFont(VerySmallFont)
					if(GameInfo.gasflag == 1) and (GameInfo.gasrandom%2 == 0) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"Hallway\n1F lobby\nB1F West hall"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"Hallway\nB1F West hall"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 2) and (GameInfo.gasrandom%2 == 0) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"2F East hall\nNight-duty room\nAutopsy Room"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"2F East hall\nAutopsy Room"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 4) and (GameInfo.gasrandom%2 == 0) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"Waiting room\n1F East hall\nParking Garage"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"1F East hall\nParking Garage"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 8) and (GameInfo.gasrandom%2 == 0) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"2F East hall\nEast office\nInterrogation room"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"East office\nInterrogation room"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 16) and (GameInfo.gasrandom%2 == 0) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nB1F East hall\nNight-duty room"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"B1F East hall\nNight-duty room"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 32) and (GameInfo.gasrandom%2 == 0) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"East office\nSubstation room\nKennel"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"Substation room\nKennel"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 64) and (GameInfo.gasrandom%2 == 0) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nB1F East hall\nParking Garage"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nB1F East hall"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 128) and (GameInfo.gasrandom%2 == 0) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"Interrogation room\nB1F West hall\nKennel"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"B1F West hall\nKennel"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 256) and (GameInfo.gasrandom%2 == 0) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"Waiting room\nHallway\nB1F East hall"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"Hallway\nB1F East hall"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 512) and (GameInfo.gasrandom%2 == 0) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"East office\n1F East hall\nSubstation room"}, 300*p, 120, 150, "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"1F Lobby\n1F East hall"}, 300*p, 120, 150, "left")
						end
					end
        
					if(GameInfo.gasflag == 1) and (GameInfo.gasrandom%2 == 1) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nNight-duty room\nSubstation room"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"Night-duty room\nSubstation room"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 2) and (GameInfo.gasrandom%2 == 1) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"Waiting room\n1F Lobby\nB1F West Hall"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"Waiting room\nB1F West Hall"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 4) and (GameInfo.gasrandom%2 == 1) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nHallway\nSubstation room"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nHallway"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 8)and (GameInfo.gasrandom%2 == 1) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"Interrogation room\n1F East hall\nParking garage"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"1F East hall\nParking garage"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 16) and (GameInfo.gasrandom%2 == 1) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"Night-duty room\nAutopsy room\nKennel"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"Autopsy room\nKennel"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 32) and (GameInfo.gasrandom%2 == 1) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"East office\nInterrogation room\nSubstation room"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"East office\nInterrogation room"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 64) and (GameInfo.gasrandom%2 == 1) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"Waiting room\nEast office\nB1F East Hall"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"Waiting room\nB1F East Hall"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 128) and (GameInfo.gasrandom%2 == 1) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"2F East Hall\n1F Lobby\nHallway"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nHallway"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 256) and (GameInfo.gasrandom%2 == 1) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"Night-duty room\nAutopsy room\nParking garage"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"Autopsy room\nParking garage"}, 300*p, 120, 150, "left")
						end
					elseif(GameInfo.gasflag == 512) and (GameInfo.gasrandom%2 == 1) then
						if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nInterrogation room\nKennel"}, 300*p, 120, 150, "left")
						elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
							love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nInterrogation room"}, 300*p, 120, 150, "left")
						end
					end
        
				elseif (GameInfo.scenario == "below freezing point") then
						love.graphics.setFont(DefaultFont)
						if(GameInfo.pass1 >= 0x0 and GameInfo.pass1 <= 0x1F or GameInfo.pass1 >= 0x80 and GameInfo.pass1 <= 0x9F) then
							love.graphics.printf("0634", 300*p, 185, 300, "left")
						elseif(GameInfo.pass1 >= 0x20 and GameInfo.pass1 <= 0x3F or GameInfo.pass1 >= 0xA0 and GameInfo.pass1 <= 0xBF) then
							love.graphics.printf("4509", 300*p, 185, 300, "left")
						elseif(GameInfo.pass1 >= 0x40 and GameInfo.pass1 <= 0x7F or GameInfo.pass1 >= 0xC0 and GameInfo.pass1 <= 0xFF) then
							love.graphics.printf("9741", 300*p, 185, 300, "left")
						end
						if(GameInfo.pass2 == 0x20) then
							love.graphics.printf("-A375-B482", 300*p+40, 185, 300, "left")
						elseif(GameInfo.pass2 == 0x40) then
							love.graphics.printf("-J126-D580", 300*p+40, 185, 300, "left")
						elseif(GameInfo.pass2 == 0x80) then
							love.graphics.printf("-C582-A194", 300*p+40, 185, 300, "left")
						end
				elseif (GameInfo.scenario == "the hive") then
					love.graphics.setFont(DefaultFont)
					if(GameInfo.pass1 >= 0x0 and GameInfo.pass1 <= 0x1F or
						GameInfo.pass1 >= 0x80 and GameInfo.pass1 <= 0x9F) then
						love.graphics.printf("3555-0930", 300*p, 185, 300, "left")
					elseif(GameInfo.pass1 >= 0x20 and GameInfo.pass1 <= 0x3F or
							GameInfo.pass1 >= 0x60 and GameInfo.pass1 <= 0x7F or
							GameInfo.pass1 >= 0xA0 and GameInfo.pass1 <= 0xBF or
							GameInfo.pass1 >= 0xE0 and GameInfo.pass1 <= 0xFF) then
							love.graphics.printf("5315-0930", 300*p, 185, 300, "left")
					elseif(GameInfo.pass1 >= 0x40 and GameInfo.pass1 <= 0x5F or
						GameInfo.pass1 >= 0xC0 and GameInfo.pass1 <= 0xDF) then
						love.graphics.printf("8211-0930", 300*p, 185, 300, "left")
					end
				elseif (GameInfo.scenario == "hellfire") then
					love.graphics.setFont(DefaultFont)
					if(GameInfo.pass3 >= 0x0 and GameInfo.pass3 <= 0x1) then
						love.graphics.printf("0721-DCH", 300*p, 185, 300, "left")
					elseif(GameInfo.pass3 >= 0x2 and GameInfo.pass3 <= 0x3) then
						love.graphics.printf("2287-JIA", 300*p, 185, 300, "left")
					elseif(GameInfo.pass3 >= 0x4 and GameInfo.pass3 <= 0x7) then
						love.graphics.printf("6354-BAE", 300*p, 185, 300, "left")
					elseif(GameInfo.pass3 >= 0x8 and GameInfo.pass3 <= 0xF) then
						love.graphics.printf("5128-GGF", 300*p, 185, 300, "left")
					end
					if(GameInfo.pass4 == 0x4000) then
						love.graphics.printf("-1234", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x4020) then
						love.graphics.printf("-234", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x4040) then
						love.graphics.printf("-134", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x4060) then
						love.graphics.printf("-34", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x4080) then
						love.graphics.printf("-124", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x40C0) then
						love.graphics.printf("-14", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x40E0) then
						love.graphics.printf("-4", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x4100) then
						love.graphics.printf("-123", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x4120) then
						love.graphics.printf("-23", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x4140) then
						love.graphics.printf("-13", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x4160) then
						love.graphics.printf("-3", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x4180) then
						love.graphics.printf("-12", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x41A0) then
						love.graphics.printf("-2", 300*p+85, 185, 300, "left")
					elseif(GameInfo.pass4 == 0x41C0) then
						love.graphics.printf("-1", 300*p+85, 185, 300, "left")
					end
				elseif (GameInfo.scenario == "decisions,decisions") then
					love.graphics.setFont(DefaultFont)
					if(GameInfo.pass3 == 0x40) then
						love.graphics.printf("4161", 300*p, 185, 300, "left")
					elseif(GameInfo.pass3 == 0x80) then
						love.graphics.printf("4032", 300*p, 185, 300, "left")
					elseif(GameInfo.pass3 == 0x00) and (GameInfo.pass6%2 == 0x1) then
							love.graphics.printf("4927", 300*p, 185, 300, "left")
					elseif(GameInfo.pass3 == 0x00) and (GameInfo.pass6%2 == 0x0) then
							love.graphics.printf("4284", 300*p, 185, 300, "left")
					end
				
					if(GameInfo.difficulty == "easy") then
						love.graphics.printf("-03:25", 300*p+40, 185, 300, "left")
					elseif(GameInfo.difficulty == "normal") then
						love.graphics.printf("-10:05", 300*p+40, 185, 300, "left")
					elseif(GameInfo.difficulty == "hard") then
						love.graphics.printf("-07:40", 300*p+40, 185, 300, "left")
					elseif(GameInfo.difficulty == "very hard") then
						love.graphics.printf("-02:50", 300*p+40, 185, 300, "left")
					end

				elseif (GameInfo.scenario == "underbelly") then
					if(GameInfo.escapetime == 0 or GameInfo.escapetime == 0xffff)then
						love.graphics.setFont(DefaultFont)
						if(GameInfo.passub1 >= 0x2) and (GameInfo.passub1 < 0x4) then
							love.graphics.printf("2916", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x4) and (GameInfo.passub1 < 0x8)then
							love.graphics.printf("3719", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x8) and (GameInfo.passub1 < 0x10)then
							love.graphics.printf("0154", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x10) and (GameInfo.passub1 < 0x20)then
							love.graphics.printf("6443", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x20) and (GameInfo.passub1 < 0x40)then
							love.graphics.printf("7688", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x40) and (GameInfo.passub1 < 0x80)then
							love.graphics.printf("1812", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x80) and (GameInfo.passub1 < 0x100)then
							love.graphics.printf("5551", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x100) and (GameInfo.passub1 < 0x200)then
							love.graphics.printf("6010", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x200) and (GameInfo.passub1 < 0x400)then
							love.graphics.printf("0652", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x400) and (GameInfo.passub1 < 0x800)then
							love.graphics.printf("6234", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x800) and (GameInfo.passub1 < 0x1000)then
							love.graphics.printf("0533", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x1000) and (GameInfo.passub1 < 0x2000)then
							love.graphics.printf("9439", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x2000) and (GameInfo.passub1 < 0x4000)then
							love.graphics.printf("1421", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x4000) and (GameInfo.passub1 < 0x8000)then
							love.graphics.printf("1127", 300*p, 185, 300, "left")
						elseif(GameInfo.passub1 >= 0x8000) and (GameInfo.passub1 < 0x10000)then
							love.graphics.printf("7840", 300*p, 185, 300, "left")
						elseif(GameInfo.passub2%2 == 0x1) then
								love.graphics.printf("6910", 300*p, 185, 300, "left")
						end
					else
						love.graphics.setFont(TimeFont)
						love.graphics.printf(Time2string3(GameInfo.escapetime), 300*p, 185, 60, "center",0,1,1)
					end

				elseif (GameInfo.scenario == "flashback") then
					if(GameInfo.escapetime > 0) and not (GameInfo.escapetime == 0xffff)then
						love.graphics.setFont(TimeFont)
						love.graphics.printf(Time2string3(GameInfo.escapetime), 300*p, 185, 60, "center",0,1,1)
					end
				elseif (GameInfo.scenario == "end of the road") then
					love.graphics.setFont(DefaultFont)
					love.graphics.printf(GameInfo.pass4, 300*p, 185, 300, "left")
				end
			end
			if (GameInfo.hoststatus == 3 and GameInfo.scenario == "") then
				UIAtlas:draw("title bar", 0, 2, 0, 1)
				love.graphics.setFont(VerySmallFont)
				love.graphics.printf("No.",10, 8,20, "right")
				love.graphics.printf("Title & Scenario",40, 8,130, "left")
				love.graphics.printf("HEADS",240, 8,50, "left")
				for i=1, 5 do
					LobbyCards[i]:draw(0, (i-1)*32)		
				end
				for i=6, 10 do
					LobbyCards[i]:draw(300, (i-6)*32)		
				end
				for i=11, 15 do
					LobbyCards[i]:draw(600, (i-11)*32)		
				end
				for i=16, 20 do
					LobbyCards[i]:draw(900, (i-16)*32)		
				end
			end

			for i=1, 4 do
				if Players[i].enabled then
					PlayerCards[i]:draw((i-1)*300, 0)
				end
			end
			if EnemyHPSwtich==0 then
				for i=1, 12 do
					if Enemies[i].inGame then
						EnemyCards2[i]:draw(300*p,(i-1)*15+2)
					end
				end
				for i=12, 12 do--for plant boss
					if Enemies[i].enabled then
						if not Enemies[i].inGame then
							EnemyCards2[i]:draw(300*p,(i-1)*15+2)
						end
					end
				end
			end
			if EnemyHPSwtich==1 then
				for i=1, 12 do
					if Enemies[i].inGame then
						EnemyCards[i]:draw(300*p,(i-1)*15+2)
					end
				end
				for i=12, 12 do--for plant boss
					if Enemies[i].enabled then
						if not Enemies[i].inGame then
							EnemyCards[i]:draw(300*p,(i-1)*15+2)
						end
					end
				end
			end
			if not(GameInfo.scenario == "") and (GameInfo.frames > 0) then
				for i=1, 1 do
					ItemCards[i]:draw(20, 145+(60/0.6))
				end
				if ItemList==1 then
					love.graphics.rectangle('line',2,2,900,201,3,3,1)
					love.graphics.setColor( 0, 0, 0, 0.85 )
					love.graphics.rectangle('fill',2,2,900,201,3,3,1)
					love.graphics.setColor( 1, 1, 1, 1 )
					for i=1, 30 do
						ItemCards2[i]:draw(46*(i-1), 0)
					end
					for i=31, 60 do
						ItemCards2[i]:draw(46*(i-31), 44*1)
					end
					for i=61, 90 do
						ItemCards2[i]:draw(46*(i-61), 44*2)
					end
					for i=91, 120 do
						ItemCards2[i]:draw(46*(i-91), 44*3)
					end
					for i=121, 150 do
						ItemCards2[i]:draw(46*(i-121), 44*4)
					end
					for i=151, 180 do
						ItemCards2[i]:draw(46*(i-151), 44*5)
					end
					for i=181, 210 do
						ItemCards2[i]:draw(46*(i-181), 44*6)
					end
				end
				if ItemList==2 then
					love.graphics.rectangle('line',2,2,897,201,3,3,1)
					love.graphics.setColor( 0, 0, 0, 0.85 )
					love.graphics.rectangle('fill',2,2,897,201,3,3,1)
					love.graphics.setColor( 1, 1, 1, 1 )
					for i=1, 30 do
						ItemCards3[i]:draw(46*(i-1), 0)
					end
					for i=31, 60 do
						ItemCards3[i]:draw(46*(i-31), 44*1)
					end
					for i=61, 90 do
						ItemCards3[i]:draw(46*(i-61), 44*2)
					end
					for i=91, 120 do
						ItemCards3[i]:draw(46*(i-91), 44*3)
					end
					for i=121, 150 do
						ItemCards3[i]:draw(46*(i-121), 44*4)
					end
					for i=151, 180 do
						ItemCards3[i]:draw(46*(i-151), 44*5)
					end
					for i=181, 210 do
						ItemCards3[i]:draw(46*(i-181), 44*6)
					end
						love.graphics.rectangle('line',902,2,296,201,3,3,1)
						love.graphics.setColor( 0, 0, 0, 0.85 )
						love.graphics.rectangle('fill',902,2,296,201,3,3,1)
						love.graphics.setColor( 1, 1, 1, 1 )
						love.graphics.setFont(MiniFont)
					if RoomName == 1 then
						for i=1,20 do
						love.graphics.printf("1"*(i-1)*2+1,902, 10*(i-1)+2,12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+1),916, 10*(i-1)+2,140, "left")
						love.graphics.printf("1"*(i-1)*2+2,1050, 10*(i-1)+2,12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+2),1066, 10*(i-1)+2,150, "left")
						end
					elseif RoomName == 2 then
						for i=1,20 do
						love.graphics.printf("1"*(i-1)*2+41,902, 10*(i-1)+2,12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+41),916, 10*(i-1)+2,140, "left")
						love.graphics.printf("1"*(i-1)*2+42,1050, 10*(i-1)+2,12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+42),1066, 10*(i-1)+2,150, "left")
						end
					elseif RoomName == 3 then
						for i=1,9 do
						love.graphics.printf("1"*(i-1)*2+81,902, 10*(i-1)+2,12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+81),916, 10*(i-1)+2,140, "left")
						love.graphics.printf("1"*(i-1)*2+82,1050, 10*(i-1)+2,12, "right")
						love.graphics.printf(GetRoomName(GameInfo.scenario,(i-1)*2+82),1066, 10*(i-1)+2,150, "left")
						end
					end
				end
			end
		end
		if HelpMenu==1 then
			love.graphics.rectangle('line',2,2,296,201,3,3,1)
			love.graphics.setColor( 0, 0, 0, 0.85 )
			love.graphics.rectangle('fill',2,2,296,201,3,3,1)
			love.graphics.setFont(VerySmallFont)
			love.graphics.setColor( 1, 1, 1, 1 )
			love.graphics.printf("Hotkeys list:\n F1: Show/hide help menu.\n F2: Show/hide item list.\n F3: Switch room name list.\n F4: No border.\n 1/2/3/4: Change window size.\n Num0/1/2/3/4: Switch player&E.Healthy bar.\n E: Off/On Enemy hp number.\n S: Simple window.\n A: Auto size.\n D: Default.\n H/V: Change layout style.\n ESC: Exit.", 4, 4, 300, "left")
		end

	elseif InitResult == false then
		love.graphics.setFont(DefaultFont)
		love.graphics.printf("Unable to find PCSX2 process.\n Will try again in " .. tostring(math.floor(5-RetryTimer + 0.5)) .. ".", errorX, errorY, 300, "center")
		love.graphics.setFont(VerySmallFont)
		love.graphics.printf("Hotkeys list:\n F1: Show/hide help menu.\n F2: Show/hide item list.\n F3: Switch room name list.\n F4: No border.\n 1/2/3/4: Change window size.\n Num0/1/2/3/4: Switch player status and show\n big bar for enemy.\n E: Off/On Enemy hp number.\n S: Simple window.\n A: Auto size.\n D: Default.\n H/V: Change layout style.\n ESC: Exit.\nCredits\n    Program: Fothsid, killme\n    Thanks: morshi, alyssaprimp\nCode: github.com/phoe-nix/OutbreakTracker", 4, 4, 300, "left")
	elseif InitResult == true and GameInfo.currentFile == 255 then
		love.graphics.setFont(DefaultFont)
		love.graphics.printf("This is not Biohazard Outbreak game.\n Will try again in " .. tostring(math.floor(5-RetryTimer + 0.5)) .. ".", errorX, errorY, 300, "center")
		love.graphics.setFont(VerySmallFont)
		love.graphics.printf("Hotkeys list:\n F1: Show/hide help menu.\n F2: Show/hide item list.\n F3: Switch room name list.\n F4: No border.\n 1/2/3/4: Change window size.\n Num0/1/2/3/4: Switch player status and show\n big bar for enemy.\n E: Off/On Enemy hp number.\n S: Simple window.\n A: Auto size.\n D: Default.\n H/V: Change layout style.\n ESC: Exit.\nCredits\n    Program: Fothsid, killme\n    Thanks: morshi, alyssaprimp\nCode: github.com/phoe-nix/OutbreakTracker", 4, 4, 300, "left")
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
		tracker.updateSlotPlayer()
		tracker.updatePlayer()
		tracker.updateItem()
		--tracker.updateBoss()
		tracker.updateEnemy()
		GameInfo = tracker.getGameInfo()
		if GameInfo.currentFile > 0 then
			for i=1, 20 do
				Slots[i] = tracker.getLobby(i)
			end
			for i=1, 4 do
				SPlayers[i] = tracker.getSlotPlayer(i)
			end
			for i=1, 1 do
				Items[i] = tracker.getItem(i)
			end
			for i=1, 255 do
				Items2[i] = tracker.getItem2(i)
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
	if key == "escape" then
		love.event.quit()
	end
	if key == "f4" then love.window.setMode(wx, wy,{resizable=true, borderless=true}) love.window.setPosition(x, y)end
	if key == "f1" then
		if HelpMenu==0 then HelpMenu=1
		else HelpMenu=0
		end
	end	
	if key == "f2" then
		if ItemList==0 then ItemList=1
		elseif ItemList==1 then ItemList=2
		else ItemList=0
		end
	end
	if key == "f3" then
		if	ItemList==2 then
			if Style==0 then
				if RoomName==1 then RoomName=2
				elseif RoomName==2 then RoomName=3
				elseif RoomName==3 then RoomName=4
				else RoomName=1
				end
			else
				if RoomName==1 then RoomName=2
				elseif RoomName==2 then RoomName=3
				else RoomName=1
				end
			end
		end
	end
	if key == "d" then love.window.setMode(300, 160+(145*4),{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300, 160+(145*4) Style = 0 end
	if key == "h" then love.window.setMode(300*4+150, 145+60,{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300*4+150, 145+60 Style = 1 end
	if key == "v" then love.window.setMode(300, 160+(145*4),{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300, 160+(145*4) Style = 0 end
	if InitResult then
		if not(GameInfo.scenario == "") then
			if key =="kp0" then
				PlayerSwtich=0 EnemyHPSwtich=1
			end
			if key =="kp1" then
				PlayerSwtich=1 EnemyHPSwtich=2
			end
			if key =="kp2" then
				PlayerSwtich=2 EnemyHPSwtich=2
			end
			if key =="kp3" then
				PlayerSwtich=3 EnemyHPSwtich=2
			end
			if key =="kp4" then
				PlayerSwtich=4 EnemyHPSwtich=2
			end
			if key =="t" then
				if TimeSwtich == 0 then TimeSwtich=1
				elseif TimeSwtich==1 then TimeSwtich=0
				end
			end
			if key =="i" then
				if ItemSwtich == 0 then ItemSwtich=1
				elseif ItemSwtich==1 then ItemSwtich=0
				end
			end
			if key =="e" then
				if EnemyHPSwtich == 0 then EnemyHPSwtich=1
				elseif EnemyHPSwtich==1 then EnemyHPSwtich=0
				end
			end
			if key == "1" then love.window.setMode(300, (145*1),{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300, (145*1) end
			if key == "2" then love.window.setMode(300, (145*2),{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300, (145*2) end
			if key == "3" then love.window.setMode(300, (145*3),{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300, (145*3) end
			if key == "4" then love.window.setMode(300, (145*4),{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300, (145*4) end
			if key == "a" then
				if Style==0 then
					love.window.setMode(300, 160+(145*p),{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300, 160+(145*p)
				else
					love.window.setMode(300*p+150, 145+60,{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300*p+150, 145+60
				end
					end
			if key == "s" then love.window.setMode(110, (145*p),{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 110,(145*p) end
			--if key == "t" then love.window.setMode(300, 20+(145*p),{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300, 20+(145*p)end
			--if key == "e" then love.window.setMode(300, 105+(145*p)) love.window.setPosition(x, y)end
			--if key == "d" then love.window.setMode(300, 740) love.window.setPosition(x, y)end
			
			--if key == "h" then love.window.setMode(300*p+150, 145+60,{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300*p+150, 145+60 Style = 1 end
			
		end
	end
end