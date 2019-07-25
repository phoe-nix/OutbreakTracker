local tracker = require "luaoutbreaktracker"

require "assets"
require "helpers"
require "ItemIcon"
require "Label"
require "PlayerCard"
require "SPlayerCard"
require "EnemyCard"
require "LobbyCard"
require "ItemCard"

local InitResult = false
local RetryTimer = 0

local errorX, errorY = 0, 300
Slots = {}
Items = {}
Players = {}
SPlayers = {}
Enemies = {}
GameInfo = {}

LobbyCards = {}
ItemCards = {}
PlayerCards = {}
SPlayerCards = {}
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
	for i=1, 4 do
		SPlayerCards[i] = SPlayerCard:new(i)
	end
	for i=1, 12 do
		EnemyCards[i] = EnemyCard:new(i)
	end
	--love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=400, minheight=300})
end

function love.draw()
	wx, wy, display = love.window.getMode()-- get window size
	love.graphics.scale(wx/300, wy/740)

	local p = GameInfo.playernum
	if InitResult == true and not(GameInfo.currentFile == 255) then
		love.graphics.setFont(TimeFont)
		if not(GameInfo.scenario == "") then
			love.graphics.printf(Time2string(GameInfo.frames/0.03), 0, (145*p), 300, "right")
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
			if (GameInfo.scenario == "wild things") then
				--UIAtlas:draw("wild things", 0, 576,0,0.6)
				ItemIcons:draw("2/14005", 0, (145*p)-3,0,0.5)
				love.graphics.printf(GameInfo.p1coins+GameInfo.p2coins+GameInfo.p3coins+GameInfo.p4coins, 26,(145*p), 300, "left")
			elseif (GameInfo.scenario == "desperate times") then
				love.graphics.printf((GameInfo.killedzombies), 0, (145*p), 300, "left")
				ItemIcons:draw("2/11511", 150-8, (145*p)+56,0,0.75)
				love.graphics.printf((GameInfo.gasflag), 0, (145*p), 100, "center")
				love.graphics.printf(Time2string3(GameInfo.gastime), 150-8, (145*p)+90, 56, "center",0,0.65,0.65)
				love.graphics.printf(IsOuNumber(GameInfo.gasrandom), 0, (145*p), 280, "center")
				love.graphics.setFont(EnemyFont)
				if(GameInfo.gasflag == 1) and (GameInfo.gasrandom%2 == 0) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"Hallway\n1F lobby\nB1F West hall"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"Hallway\nB1F West hall"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 2) and (GameInfo.gasrandom%2 == 0) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"2F East hall\nNight-duty room\nAutopsy Room"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"2F East hall\nAutopsy Room"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 4) and (GameInfo.gasrandom%2 == 0) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"Waiting room\n1F East hall\nParking Garage"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"1F East hall\nParking Garage"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 8) and (GameInfo.gasrandom%2 == 0) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"2F East hall\nEast office\nInterrogation room"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"East office\nInterrogation room"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 16) and (GameInfo.gasrandom%2 == 0) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nB1F East hall\nNight-duty room"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"B1F East hall\nNight-duty room"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 32) and (GameInfo.gasrandom%2 == 0) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"East office\nSubstation room\nKennel"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"Substation room\nKennel"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 64) and (GameInfo.gasrandom%2 == 0) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nB1F East hall\nParking Garage"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nB1F East hall"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 128) and (GameInfo.gasrandom%2 == 0) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"Interrogation room\nB1F West hall\nKennel"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"B1F West hall\nKennel"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 256) and (GameInfo.gasrandom%2 == 0) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"Waiting room\nHallway\nB1F East hall"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"Hallway\nB1F East hall"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 512) and (GameInfo.gasrandom%2 == 0) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"East office\n1F East hall\nSubstation room"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"1F Lobby\n1F East hall"}, 180, (145*p)+60, 150,  "left")
					end
				end

				if(GameInfo.gasflag == 1) and (GameInfo.gasrandom%2 == 1) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nNight-duty room\nSubstation room"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"Night-duty room\nSubstation room"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 2) and (GameInfo.gasrandom%2 == 1) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"Waiting room\n1F Lobby\nB1F West Hall"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"Waiting room\nB1F West Hall"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 4) and (GameInfo.gasrandom%2 == 1) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nHallway\nSubstation room"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nHallway"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 8)and (GameInfo.gasrandom%2 == 1) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"Interrogation room\n1F East hall\nParking garage"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"1F East hall\nParking garage"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 16) and (GameInfo.gasrandom%2 == 1) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"Night-duty room\nAutopsy room\nKennel"}, 180, (145*p)+60, 180,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"Autopsy room\nKennel"}, 180, (145*p)+60, 180,  "left")
					end
				elseif(GameInfo.gasflag == 32) and (GameInfo.gasrandom%2 == 1) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"East office\nInterrogation room\nSubstation room"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"East office\nInterrogation room"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 64) and (GameInfo.gasrandom%2 == 1) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"Waiting room\nEast office\nB1F East Hall"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"Waiting room\nB1F East Hall"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 128) and (GameInfo.gasrandom%2 == 1) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"2F East Hall\n1F Lobby\nHallway"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"1F Lobby\nHallway"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 256) and (GameInfo.gasrandom%2 == 1) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"Night-duty room\nAutopsy room\nParking garage"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"Autopsy room\nParking garage"}, 180, (145*p)+60, 150,  "left")
					end
				elseif(GameInfo.gasflag == 512) and (GameInfo.gasrandom%2 == 1) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nInterrogation room\nKennel"}, 180, (145*p)+60, 150,  "left")
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf({{1, 1, 0, 1},"2F East Hall\nInterrogation room"}, 180, (145*p)+60, 150,  "left")
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
					love.graphics.printf("-1", 85, (145*p), 300, "left")
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
				elseif(GameInfo.pass3 == 0x00) and (GameInfo.pass6 == 0x01 or
				GameInfo.pass6 == 0x5 or
				GameInfo.pass6 == 0x9 or
				GameInfo.pass6 == 0x1D or
				GameInfo.pass6 == 0x75 or
				GameInfo.pass6 == 0x79 or
				GameInfo.pass6 == 0x7D) then
					love.graphics.printf("4927", 0, (145*p), 300, "left")
				elseif(GameInfo.pass3 == 0x00) and (GameInfo.pass6 == 0x2 or
				GameInfo.pass6 == 0x6 or
				GameInfo.pass6 == 0xA or
				GameInfo.pass6 == 0x1E or
				GameInfo.pass6 == 0x76 or
				GameInfo.pass6 == 0x7A or
				GameInfo.pass6 == 0x7E) then
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
				elseif(GameInfo.passub2 == 0x1) or
				(GameInfo.passub2 == 0x3) or
				(GameInfo.passub2 == 0x5) or
				(GameInfo.passub2 == 0x7) then
				love.graphics.printf("6910", 0, (145*p), 300, "left")
				end
			elseif (GameInfo.scenario == "end of the road") then
				love.graphics.setFont(DefaultFont)
				love.graphics.printf(GameInfo.pass4, 0, (145*p), 300, "left")
			end
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
				if (GameInfo.frames>0) then
					ItemCards[i]:draw(0, (145*p)*(1/0.6)+(100/0.6))
				end
			end
		end
		for i=1, 4 do
			if Players[i].enabled then
				PlayerCards[i]:draw(0, (i-1)*145)
			end
		end
		for i=1, 6 do
			if Enemies[i].inGame then
				EnemyCards[i]:draw(0,(i-1)*14+(145*p)+25)
			end
		end
		for i=7, 12 do
			if Enemies[i].inGame then
				EnemyCards[i]:draw(152,(i-7)*14+(145*p)+25)
			end
		end
		for i=12, 12 do--for plant boss
			if Enemies[i].enabled then
				EnemyCards[i]:draw(152,(i-7)*14+(145*p)+25)
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
    if key == "d" then love.window.setMode(300, 740) love.window.setPosition( x, y )end
	if key == "f4" then love.window.setMode(wx, wy,{resizable=true, vsync=false, borderless=true}) love.window.setPosition( x, y )end
	end
end