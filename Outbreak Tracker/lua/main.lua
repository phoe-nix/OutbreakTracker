local tracker = require "luaoutbreaktracker"

require "assets"
require "helpers"
require "ItemIcon"
require "Label"
require "PlayerCard"
require "EnemyCard"
require "ItemCard"
require "DoorCard"
require "LobbyCard"
require "SPlayerCard"
require "language"

local InitResult = false
local RetryTimer = 0
local scalex,scaley = 300, 740
local errorX, errorY = 0, 500
local TimeSwitch=1
local PuzzleSwitch=1
local EnemyHPSwitch=1
local ItemSwitch=1
local Style=0
local HelpMenu=0
local PlayerList=1
local EnemyList=0
local ItemList=0
local doorList=1
local RoomName=1
LanguageSwitch=0;

Slots = {}
SPlayers = {}
Items = {}
Items2 = {}
RoomMasters = {}
Doors = {}
Players = {}
Enemies = {}
Enemies2 = {}
GameInfo = {}

LobbyCards = {}
SPlayerCards = {}
ItemCards = {}
ItemCards2 = {}
ItemCards3 = {}
DoorCards = {}
PlayerCards = {}
EnemyCards = {}
EnemyCards2 = {}
EnemyCards3 = {}
EnemyCards4 = {}

function love.load(args)
	LoadAssets()
	InitResult = tracker.init()
	for i=1, 20 do
		LobbyCards[i] = LobbyCard:new(i)
	end
	for i=1, 4 do
		SPlayerCards[i] = SPlayerCard:new(i)
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
	for i=1, 19 do
		DoorCards[i] = DoorCard:new(i)
	end
	for i=1, 4 do
		PlayerCards[i] = PlayerCard:new(i)
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
	for i=1, 80 do
		EnemyCards4[i] = EnemyCard4:new(i)
	end
end

function love.draw()
	wx, wy, display = love.window.getMode()-- get window size
	love.graphics.scale(wx/scalex, wy/scaley)

	local p = GameInfo.playernum
	local itemset = GameInfo.itemrandom
	local r = GameInfo.itemrandom2
	local puzzleset = GameInfo.puzzlerandom
	local gr = GameInfo.gasrandom
	local f = GameInfo.frames
	local s = GameInfo.scenario
	local d = GameInfo.difficulty
	local hs = GameInfo.hoststatus
	local hm = GameInfo.hostscenario
	local hd = GameInfo.hostdifficulty
	local hp = GameInfo.hostplayer
	local hmp = GameInfo.hostmaxplayer
	local ht = GameInfo.hosttime
	local gl = GameInfo.gasflag
	local pass1 = GameInfo.pass1
	local pass2 = GameInfo.pass2
	local pass3 = GameInfo.pass3
	local pass4 = GameInfo.pass4
	local pass6 = GameInfo.pass6

	if InitResult == true and not(GameInfo.currentFile == 255) then
		if(pass1 >= 0 and pass1 <= 0x1F or pass1 >= 0x80 and pass1 <= 0x9F) then passbfp="0634"
		elseif(pass1 >= 0x20 and pass1 <= 0x3F or pass1 >= 0xA0 and pass1 <= 0xBF) then passbfp="4509"
		elseif(pass1 >= 0x40 and pass1 <= 0x7F or pass1 >= 0xC0 and pass1 <= 0xFF) then passbfp="9741"
		end

		if(pass2 == 0x20) then pass2bfp="A375-B482"
		elseif(pass2 == 0x40) then pass2bfp="J126-D580"
		elseif(pass2 == 0x80) then pass2bfp="C582-A194"
		end

		if(pass1 >= 0 and pass1 <= 0x1F or pass1 >= 0x80 and pass1 <= 0x9F) then passhive="3555-0930"
		elseif(pass1 >= 0x20 and pass1 <= 0x3F or
				pass1 >= 0x60 and pass1 <= 0x7F or
				pass1 >= 0xA0 and pass1 <= 0xBF or
				pass1 >= 0xE0 and pass1 <= 0xFF) then passhive="5315-0930"
		elseif(pass1 >= 0x40 and pass1 <= 0x5F or
				pass1 >= 0xC0 and pass1 <= 0xDF) then passhive="8211-0930"
		end

		if(pass3 >= 0x0 and pass3 <= 0x1) then hfpass="0721-DCH"
		elseif(pass3 >= 0x2 and pass3 <= 0x3) then hfpass="2287-JIA"
		elseif(pass3 >= 0x4 and pass3 <= 0x7) then hfpass="6354-BAE"
		elseif(pass3 >= 0x8 and pass3 <= 0xF) then hfpass="5128-GGF"
		end

		if(GameInfo.pass4 == 0x4000) then hfmap="1234"
		elseif(GameInfo.pass4 == 0x4020) then hfmap="234"
		elseif(GameInfo.pass4 == 0x4040) then hfmap="134"
		elseif(GameInfo.pass4 == 0x4060) then hfmap="34"
		elseif(GameInfo.pass4 == 0x4080) then hfmap="124"
		elseif(GameInfo.pass4 == 0x40A0) then hfmap="24"
		elseif(GameInfo.pass4 == 0x40C0) then hfmap="14"
		elseif(GameInfo.pass4 == 0x40E0) then hfmap="4"
		elseif(GameInfo.pass4 == 0x4100) then hfmap="123"
		elseif(GameInfo.pass4 == 0x4120) then hfmap="23"
		elseif(GameInfo.pass4 == 0x4140) then hfmap="13"
		elseif(GameInfo.pass4 == 0x4160) then hfmap="3"
		elseif(GameInfo.pass4 == 0x4180) then hfmap="12"
		elseif(GameInfo.pass4 == 0x41A0) then hfmap="2"
		elseif(GameInfo.pass4 == 0x41C0) then hfmap="1"
		else hfmap="?"
		end

		if(puzzleset%2 == 0) then hfpower="1" else hfpower="2" end

		if((pass3 >= 0 and pass3 < 0x40) and pass6%2 == 0x0) then ddpass="4284"
		elseif(pass3 >= 0x40 and pass3 < 0x80) then ddpass="4161"
		elseif(pass3 >= 0x80 and pass6 < 0x1) then ddpass="4032"
		elseif((pass3 >= 0x00 and pass3 < 0x40) and pass6%2 == 0x1) then ddpass="4927"
		end
		if(d=="easy") then clocktime="03:25"
		elseif (d=="normal") then clocktime="10:05"
		elseif (d=="hard") then clocktime="07:40"
		elseif (d=="very hard") then clocktime="02:50"
		end

		if(gr>=0 and gr < 10) then order=1
		elseif(gr>=10 and gr < 20) then order=2
		elseif(gr>=20 and gr < 30) then order=3
		elseif(gr>=30 and gr < 40) then order=4
		elseif(gr>=40 and gr < 50) then order=5
		elseif(gr>=50 and gr < 60) then order=6
		elseif(gr>=60 and gr < 70) then order=7
		elseif(gr>=70 and gr < 80) then order=8
		elseif(gr>=80 and gr < 90) then order=9
		elseif(gr>=90 and gr < 100) then order=10
		elseif(gr>=100 and gr < 110) then order=11
		elseif(gr>=110 and gr < 120) then order=12
		elseif(gr>=120 and gr < 130) then order=13
		elseif(gr>=130 and gr < 140) then order=14
		elseif(gr>=140 and gr < 150) then order=15
		elseif(gr>=150 and gr < 160) then order=16
		elseif(gr>=160 and gr < 170) then order=17
		elseif(gr>=170 and gr < 180) then order=18
		elseif(gr>=180 and gr < 190) then order=19
		elseif(gr>=190 and gr < 200) then order=20
		elseif(gr>=200 and gr < 210) then order=21
		elseif(gr>=210 and gr < 220) then order=22
		elseif(gr>=220 and gr < 230) then order=23
		elseif(gr>=230 and gr < 240) then order=24
		elseif(gr>=240 and gr < 255) then order=25
		end

		if(gr%16 == 0) then passwt="39DJ"
		elseif(gr%16 == 1) then passwt="LV4U"
		elseif(gr%16 == 2) then passwt="EXP2"
		elseif(gr%16 == 3) then passwt="E67C"
		elseif(gr%16 == 4) then passwt="6SR2"
		elseif(gr%16 == 5) then passwt="Q898"
		elseif(gr%16 == 6) then passwt="44V7"
		elseif(gr%16 == 7) then passwt="K3G6"
		elseif(gr%16 == 8) then passwt="SW4D"
		elseif(gr%16 == 9) then passwt="FM54"
		elseif(gr%16 == 10) then passwt="5TF3"
		elseif(gr%16 == 11) then passwt="4NZH"
		elseif(gr%16 == 12) then passwt="B37B"
		elseif(gr%16 == 13) then passwt="LYNX"
		elseif(gr%16 == 14) then passwt="9AAA"
		elseif(gr%16 == 15) then passwt="YTY7"
		end

		if(gr%16 == 0) then passdt="2236"
		elseif(gr%16 == 1) then passdt="1587"
		elseif(gr%16 == 2) then passdt="2994"
		elseif(gr%16 == 3) then passdt="3048"
		elseif(gr%16 == 4) then passdt="4425"
		elseif(gr%16 == 5) then passdt="5170"
		elseif(gr%16 == 6) then passdt="6703"
		elseif(gr%16 == 7) then passdt="7312"
		elseif(gr%16 == 8) then passdt="8669"
		elseif(gr%16 == 9) then passdt="9851"
		elseif(gr%16 == 10) then passdt="0764"
		elseif(gr%16 == 11) then passdt="3516"
		elseif(gr%16 == 12) then passdt="5835"
		elseif(gr%16 == 13) then passdt="6249"
		elseif(gr%16 == 14) then passdt="7177"
		elseif(gr%16 == 15) then passdt="9408"
		end

		if(gr%16 == 0) then passub1="DESK"
		elseif(gr%16 == 1) then passub1="MISS"
		elseif(gr%16 == 2) then passub1="FREE"
		elseif(gr%16 == 3) then passub1="JUNK"
		elseif(gr%16 == 4) then passub1="NEWS"
		elseif(gr%16 == 5) then passub1="CARD"
		elseif(gr%16 == 6) then passub1="DIET"
		elseif(gr%16 == 7) then passub1="POEM"
		elseif(gr%16 == 8) then passub1="BEER"
		elseif(gr%16 == 9) then passub1="LOCK"
		elseif(gr%16 == 10) then passub1="TEST"
		elseif(gr%16 == 11) then passub1="SOFA"
		elseif(gr%16 == 12) then passub1="WINE"
		elseif(gr%16 == 13) then passub1="TAPE"
		elseif(gr%16 == 14) then passub1="GOLF"
		elseif(gr%16 == 15) then passub1="PLAN"
		end

		if(gr%16 == 0) then passub2="2916"
		elseif(gr%16 == 1) then passub2="3719"
		elseif(gr%16 == 2) then passub2="0154"
		elseif(gr%16 == 3) then passub2="6443"
		elseif(gr%16 == 4) then passub2="7688"
		elseif(gr%16 == 5) then passub2="1812"
		elseif(gr%16 == 6) then passub2="5551"
		elseif(gr%16 == 7) then passub2="6010"
		elseif(gr%16 == 8) then passub2="0652"
		elseif(gr%16 == 9) then passub2="6234"
		elseif(gr%16 == 10) then passub2="0533"
		elseif(gr%16 == 11) then passub2="9439"
		elseif(gr%16 == 12) then passub2="1421"
		elseif(gr%16 == 13) then passub2="1127"
		elseif(gr%16 == 14) then passub2="7840"
		elseif(gr%16 == 15) then passub2="6910"
		end
		if Style==0 then
			time_x = 0
			time_y = 145*p
			lobby_n = 20
			lobby_x = 0
			lobby_y = 32
			hostmap_x = 0
			hostmap_y = 580
			hostmap_scale = 0.85
			hosttime_x = 15
			hosttime_y = 595
			hostplayer_x = 15
			hostplayer_y = 620
			hostdifficulty_x = 10
			hostdifficulty_y = 590
			slotplayer_x = 0
			slotplayer_y = 145
			slotplayer_z = 0
			timeleft_x = 0
			timeleft_y = 145*p
			passwt_x = 60
			passwt_y = 145*p
			icon_x = 150-8
			icon_y = 145*p+56
			icon_scale = 0.75
			gastime_x = 150-8
			gastime_y = 145*p+90
			gastime_scale = 0.65
			gasroom_x = 180
			gasroom_y = 145*p+60
			playercard_x = 0
			playercard_y = 145
			itemcard_x = 30
			itemcard_y = (2+145*p)*(1/0.6)+(100/0.6)
			itemset_x = 0
			itemset_y = 720
			itemr_y = 145*p+110
			door_x = 238
			door_y = p*145+100
		else
			time_x = 300
			time_y = 185
			lobby_n = 5
			lobby_x = 0
			lobby_y = 32
			hostmap_x = 1090
			hostmap_y = 0
			hostmap_scale = 1
			hosttime_x =1102
			hosttime_y =15
			hostplayer_x = 1102
			hostplayer_y = 35
			hostdifficulty_x = 1130
			hostdifficulty_y = 15
			slotplayer_x = 290
			slotplayer_y = 0
			slotplayer_z = 0
			timeleft_x = 300*p
			timeleft_y = 185
			passwt_x = 300*p+60
			passwt_y = 185
			icon_x = 300*p-5
			icon_y = 145+14
			icon_scale = 0.6
			gastime_x = 300*p+20
			gastime_y = 145+20
			gastime_scale = 1
			gasroom_x = 300*p
			gasroom_y = 120
			playercard_x = 300
			playercard_y = 0
			itemcard_x = 30
			itemcard_y = 145+(60/0.6)
			itemset_x = 0
			itemset_y = 195
			itemr_y = 155
			door_x = 238
			door_y = 145
		end

		love.graphics.setFont(TimeFont)
		if (hs == 3 and s == "") then
			UIAtlas:draw("title bar", 0, 2, 0, 1)
			love.graphics.setFont(VerySmallFont)
			love.graphics.printf(_l("No"),10, 8,20, "right")
			love.graphics.printf(_l("Title & Scenario"),40, 8,130, "left")
			love.graphics.printf(_l("HEADS"),240, 8,50, "left")
			for i=1, lobby_n do
				LobbyCards[i]:draw(lobby_x, (i-1)*lobby_y)		
			end
			if Style==1 then
				for i=6, 10 do
					LobbyCards[i]:draw(300, (i-6)*lobby_y)		
				end
				for i=11, 15 do
					LobbyCards[i]:draw(300*2, (i-11)*lobby_y)		
				end
				for i=16, 20 do
					LobbyCards[i]:draw(300*3, (i-16)*lobby_y)		
				end
			end
		end

		if (hs >= 4 and hs < 6 and s=="") then
			UIAtlas:draw(hm, hostmap_x, hostmap_y, 0, hostmap_scale)
			love.graphics.printf(Time2string2(GameInfo.hosttime), hosttime_x, hosttime_y, 300, "left")
			love.graphics.printf(hp.."/"..hmp+2, hostplayer_x, hostplayer_y, 300, "left")
			love.graphics.setFont(DefaultFont)
			love.graphics.printf(hd, hostdifficulty_x, hostdifficulty_y, 200, "right")

			for i=1, 4 do
				if SPlayers[i].enabled then
					SPlayerCards[i]:draw((i-1)*slotplayer_x+slotplayer_z, (i-1)*slotplayer_y)
				end
			end
			--sfx = love.audio.newSource("assets/full.wav", "stream")
			--if	timerswitch==0 then playtimer=0 end
			--if hp ==4 then timerswitch=1
				--love.graphics.printf(math.floor(playtimer), 0, 720, 300, "right") --real timer
			--	if playtimer==0 then
					--sfx:play()
			--	else
					--sfx:stop()
			--	end
			--end
			--love.graphics.circle( 'line', 100 + math.sin( timer ) * 20, 100 + math.cos( timer ) * 20, 20 )
		end

		if not(GameInfo.scenario == "") then
			if(f>0) then
				if TimeSwitch==1 then
					love.graphics.printf(Time2string(GameInfo.frames / 0.03), time_x, time_y, 300, "right")
				--elseif TimeSwitch==2 then
				--	love.graphics.printf(RealTime(timer), time_x, time_y, 300, "right")
				end
				if(f > 0 and doorList ==1 )then
					if (s == "outbreak") then
						for i=1, 4 do DoorCards[i]:draw(door_x+30, (i-1)*15+door_y)end
					elseif (s == "hellfire") then
						for i=5, 8 do DoorCards[i]:draw(door_x+30, (i-5)*15+door_y)end
					elseif (s == "decisions,decisions") then
						for i=9, 10 do DoorCards[i]:draw(door_x+30, (i-9)*15+door_y)end
					elseif (s == "wild things") then
						for i=1, 4 do DoorCards[i]:draw(door_x+30, (i-1)*15+door_y)end
						if d == "very hard" then
							for i=5, 8 do DoorCards[i]:draw(door_x, (i-5)*15+door_y)end
						elseif d == "hard" then
							for i=7, 8 do DoorCards[i]:draw(door_x, (i-7)*15+door_y)end
						else
							for i=8, 8 do DoorCards[i]:draw(door_x, (i-8)*15+door_y)end
						end
					elseif (s == "underbelly" and (d == "very hard" or d == "hard")) then
						for i=9, 12 do DoorCards[i]:draw(door_x+30, (i-9)*15+door_y)end
					elseif (s == "flashback" and (d == "very hard" or d == "hard")) then
						for i=13, 13 do DoorCards[i]:draw(door_x+30, (i-13)*15+door_y)end
					elseif (s == "desperate times") then
						for i=18, 18 do DoorCards[i]:draw(door_x, (i-18)*15+door_y)end
						for i=14, 17 do DoorCards[i]:draw(door_x+30, (i-14)*15+door_y)end
					elseif (s == "end of the road") then
						if Doors[19].flag == 0 then
							for i=19, 19 do DoorCards[i]:draw(door_x+30, (i-19)*15+door_y)end
						end
					end
				end
				if not(s == "") and (f > 0) and ItemSwitch ==1 then
					love.graphics.printf(itemset+1 .."\n"..math.floor(r/10)+1, 0, itemr_y, 24, "center")
					for i=1, 1 do
						ItemCards[i]:draw(itemcard_x, itemcard_y)
					end
				end
				if PlayerList == 1 then
					for i=1, 4 do
						if Players[i].enabled then
							PlayerCards[i]:draw((i-1)*playercard_x, (i-1)*playercard_y)
						end
					end
				end
				if ItemList==1 then
					if Style==0 then
						for i=1, 10 do
							ItemCards2[i]:draw(1+45*(i-1), 1)
						end
						for i=11, 20 do
							ItemCards2[i]:draw(1+45*(i-11), 1+44*1)
						end
						for i=21, 30 do
							ItemCards2[i]:draw(1+45*(i-21), 1+44*2)
						end
						for i=31, 40 do
							ItemCards2[i]:draw(1+45*(i-31), 1+44*3)
						end
						for i=41, 50 do
							ItemCards2[i]:draw(1+45*(i-41), 1+44*4)
						end
						for i=51, 60 do
							ItemCards2[i]:draw(1+45*(i-51), 1+44*5)
						end
						for i=61, 70 do
							ItemCards2[i]:draw(1+45*(i-61), 1+44*6)
						end
						for i=71, 80 do
							ItemCards2[i]:draw(1+45*(i-71), 1+44*7)
						end
						for i=81, 90 do
							ItemCards2[i]:draw(1+45*(i-81), 1+44*8)
						end
						for i=91, 100 do
							ItemCards2[i]:draw(1+45*(i-91), 1+44*9)
						end
						for i=101, 110 do
							ItemCards2[i]:draw(1+45*(i-101), 1+44*10)
						end
						for i=111, 120 do
							ItemCards2[i]:draw(1+45*(i-111), 1+44*11)
						end
						for i=121, 130 do
							ItemCards2[i]:draw(1+45*(i-121), 1+44*12)
						end
						for i=131, 140 do
							ItemCards2[i]:draw(1+45*(i-131), 1+44*13)
						end
						for i=141, 150 do
							ItemCards2[i]:draw(1+45*(i-141), 1+44*14)
						end
						for i=151, 160 do
							ItemCards2[i]:draw(1+45*(i-151), 1+44*15)
						end
						for i=161, 170 do
							ItemCards2[i]:draw(1+45*(i-161), 1+44*16)
						end
						for i=171, 180 do
							ItemCards2[i]:draw(1+45*(i-171), 1+44*17)
						end
						for i=181, 190 do
							ItemCards2[i]:draw(1+45*(i-181), 1+44*18)
						end
						for i=191, 200 do
							ItemCards2[i]:draw(1+45*(i-191), 1+44*19)
						end
						for i=201, 210 do
							ItemCards2[i]:draw(1+45*(i-201), 1+44*20)
						end
						love.graphics.setFont(VerySmallFont)
						love.graphics.printf("Item set: "..itemset+1 .."-"..math.floor(r/10)+1, 4, 720, 300, "left")
					else
						for i=1, 30 do
							ItemCards2[i]:draw(1+46*(i-1), 1)
						end
						for i=31, 60 do
							ItemCards2[i]:draw(1+46*(i-31), 1+44*1)
						end
						for i=61, 90 do
							ItemCards2[i]:draw(1+46*(i-61), 1+44*2)
						end
						for i=91, 120 do
							ItemCards2[i]:draw(1+46*(i-91), 1+44*3)
						end
						for i=121, 150 do
							ItemCards2[i]:draw(1+46*(i-121), 1+44*4)
						end
						for i=151, 180 do
							ItemCards2[i]:draw(1+46*(i-151), 1+44*5)
						end
						for i=181, 210 do
							ItemCards2[i]:draw(1+46*(i-181), 1+44*6)
						end
						love.graphics.setFont(VerySmallFont)
						love.graphics.printf("Item set: "..itemset+1 .."-"..math.floor(r/10)+1, 4, 190, 300, "left")
					end
				end

				if ItemList==2 then
					if Style==0 then
						for i=1, 10 do
							ItemCards3[i]:draw(1+45*(i-1), 1)
						end
						for i=11, 20 do
							ItemCards3[i]:draw(1+45*(i-11), 1+44*1)
						end
						for i=21, 30 do
							ItemCards3[i]:draw(1+45*(i-21), 1+44*2)
						end
						for i=31, 40 do
							ItemCards3[i]:draw(1+45*(i-31), 1+44*3)
						end
						for i=41, 50 do
							ItemCards3[i]:draw(1+45*(i-41), 1+44*4)
						end
						for i=51, 60 do
							ItemCards3[i]:draw(1+45*(i-51), 1+44*5)
						end
						for i=61, 70 do
							ItemCards3[i]:draw(1+45*(i-61), 1+44*6)
						end
						for i=71, 80 do
							ItemCards3[i]:draw(1+45*(i-71), 1+44*7)
						end
						for i=81, 90 do
							ItemCards3[i]:draw(1+45*(i-81), 1+44*8)
						end
						for i=91, 100 do
							ItemCards3[i]:draw(1+45*(i-91), 1+44*9)
						end
						for i=101, 110 do
							ItemCards3[i]:draw(1+45*(i-101), 1+44*10)
						end
						for i=111, 120 do
							ItemCards3[i]:draw(1+45*(i-111), 1+44*11)
						end
						for i=121, 130 do
							ItemCards3[i]:draw(1+45*(i-121), 1+44*12)
						end
						for i=131, 140 do
							ItemCards3[i]:draw(1+45*(i-131), 1+44*13)
						end
						for i=141, 150 do
							ItemCards3[i]:draw(1+45*(i-141), 1+44*14)
						end
						for i=151, 160 do
							ItemCards3[i]:draw(1+45*(i-151), 1+44*15)
						end
						for i=161, 170 do
							ItemCards3[i]:draw(1+45*(i-161), 1+44*16)
						end
						for i=171, 180 do
							ItemCards3[i]:draw(1+45*(i-171), 1+44*17)
						end
						for i=181, 190 do
							ItemCards3[i]:draw(1+45*(i-181), 1+44*18)
						end
						for i=191, 200 do
							ItemCards3[i]:draw(1+45*(i-191), 1+44*19)
						end
						for i=201, 210 do
							ItemCards3[i]:draw(1+45*(i-201), 1+44*20)
						end
							love.graphics.rectangle('line',2,605,296,133,3,3,1)
							love.graphics.setColor( 0, 0, 0, 1 )
							love.graphics.rectangle('fill',2,605,296,133,3,3,1)
							love.graphics.setColor( 1, 1, 1, 1 )
							love.graphics.setFont(MiniFont)
						if RoomName == 1 then
							for i=1,13 do
								love.graphics.printf("1"*(i-1)*2+1,2, 605+10*(i-1),12, "right")
								love.graphics.printf(GetRoomName(s,(i-1)*2+1),16, 605+10*(i-1),160, "left")
								love.graphics.printf("1"*(i-1)*2+2,150, 605+10*(i-1),12, "right")
								love.graphics.printf(GetRoomName(s,(i-1)*2+2),166, 605+10*(i-1),160, "left")
							end
						elseif RoomName == 2 then
							for i=1,13 do
							love.graphics.printf("1"*(i-1)*2+27,2, 605+10*(i-1),12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+27),16, 605+10*(i-1),160, "left")
							love.graphics.printf("1"*(i-1)*2+28,150, 605+10*(i-1),12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+28),166, 605+10*(i-1),160, "left")
							end
						elseif RoomName == 3 then
							for i=1,13 do
							love.graphics.printf("1"*(i-1)*2+53,2, 605+10*(i-1),12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+53),16, 605+10*(i-1),160, "left")
							love.graphics.printf("1"*(i-1)*2+54,150, 605+10*(i-1),12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+54),166, 605+10*(i-1),160, "left")
							end
						elseif RoomName == 4 then
							for i=1,10 do
							love.graphics.printf("1"*(i-1)*2+79,2, 605+10*(i-1),12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+79),16, 605+10*(i-1),160, "left")
							love.graphics.printf("1"*(i-1)*2+80,150, 605+10*(i-1),12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+80),166, 605+10*(i-1),160, "left")
							end
						end
					else
						for i=1, 30 do
							ItemCards3[i]:draw(1+46*(i-1), 1)
						end
						for i=31, 60 do
							ItemCards3[i]:draw(1+46*(i-31), 1+44*1)
						end
						for i=61, 90 do
							ItemCards3[i]:draw(1+46*(i-61), 1+44*2)
						end
						for i=91, 120 do
							ItemCards3[i]:draw(1+46*(i-91), 1+44*3)
						end
						for i=121, 150 do
							ItemCards3[i]:draw(1+46*(i-121), 1+44*4)
						end
						for i=151, 180 do
							ItemCards3[i]:draw(1+46*(i-151), 1+44*5)
						end
						for i=181, 210 do
							ItemCards3[i]:draw(1+46*(i-181), 1+44*6)
						end
							love.graphics.rectangle('line',902,2,296,201,3,3,1)
							love.graphics.setColor( 0, 0, 0, 1 )
							love.graphics.rectangle('fill',902,2,296,201,3,3,1)
							love.graphics.setColor( 1, 1, 1, 1 )
							love.graphics.setFont(MiniFont)
						if RoomName == 1 then
							for i=1,20 do
							love.graphics.printf("1"*(i-1)*2+1,902, 10*(i-1)+2,12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+1),916, 10*(i-1)+2,160, "left")
							love.graphics.printf("1"*(i-1)*2+2,1050, 10*(i-1)+2,12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+2),1066, 10*(i-1)+2,160, "left")
							end
						elseif RoomName == 2 then
							for i=1,20 do
							love.graphics.printf("1"*(i-1)*2+41,902, 10*(i-1)+2,12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+41),916, 10*(i-1)+2,160, "left")
							love.graphics.printf("1"*(i-1)*2+42,1050, 10*(i-1)+2,12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+42),1066, 10*(i-1)+2,160, "left")
							end
						elseif RoomName == 3 then
							for i=1,9 do
							love.graphics.printf("1"*(i-1)*2+81,902, 10*(i-1)+2,12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+81),916, 10*(i-1)+2,160, "left")
							love.graphics.printf("1"*(i-1)*2+82,1050, 10*(i-1)+2,12, "right")
							love.graphics.printf(GetRoomName(s,(i-1)*2+82),1066, 10*(i-1)+2,160, "left")
							end
						end
					end
				end	

				if EnemyHPSwitch==1 then
					if Style==0 then
						--for i=8, 8 do
						--	--if Boss[i].nameID==32 then
							--	BossCards[i]:draw(0,(i-8)*1+(145*p)+20)
							--end
						--end
                
						for i=1, 6 do
							if Enemies[i].inGame then
								EnemyCards[i]:draw(0,(i-1)*14+(145*p)+20)
							end
						end
						for i=7, 12 do
							if Enemies[i].inGame then
								EnemyCards[i]:draw(150,(i-7)*14+(145*p)+20)
							end
						end
						for i=12, 12 do--for plant boss
							if Enemies[i].enabled then
								if not Enemies[i].inGame then
									EnemyCards[i]:draw(150,(i-7)*14+(145*p)+20)
								end
							end
						end
					else
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
				end
				if EnemyHPSwitch==2 then
					if Style==0 then
						--for i=8, 8 do
						--	--if Boss[i].nameID==32 then
							--	BossCards[i]:draw(0,(i-8)*1+(145*p)+20)
							--end
						--end
                
						for i=1, 6 do
							if Enemies[i].inGame then
								EnemyCards2[i]:draw(0,(i-1)*14+(145*p)+20)
							end
						end
						for i=7, 12 do
							if Enemies[i].inGame then
								EnemyCards2[i]:draw(150,(i-7)*14+(145*p)+20)
							end
						end
						for i=12, 12 do--for plant boss
							if Enemies[i].enabled then
								if not Enemies[i].inGame then
									EnemyCards2[i]:draw(150,(i-7)*14+(145*p)+20)
								end
							end
						end
					else
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
				end
				if EnemyList==1 then
					if Style==0 then
						for i=1, 80 do
							if Enemies2[i].roomID>0 then
								EnemyCards4[i]:draw(0,(i-1)*11)
							end
						end
					else
						for i=1, 18 do
							if Enemies2[i].roomID>0 then
								EnemyCards4[i]:draw(0,(i-1)*11)
							end
						end
						for i=19, 36 do
							if Enemies2[i].roomID>0 then
								EnemyCards4[i]:draw(300,(i-19)*11)
							end
						end
						for i=37, 54 do
							if Enemies2[i].roomID>0 then
								EnemyCards4[i]:draw(600,(i-37)*11)
							end
						end
						for i=55, 72 do
							if Enemies2[i].roomID>0 then
								EnemyCards4[i]:draw(900,(i-55)*11)
							end
						end
					end
				end
			end
		end
		love.graphics.setFont(TimeFont)
		if EnemyHPSwitch<3 and f > 0 and EnemyList == 0 and ItemList ==0 then
			if (s == "wild things") then
				if(GameInfo.wttime > 0) and not (GameInfo.wttime == 0xffff) then
					love.graphics.printf(Time2string3(GameInfo.wttime), timeleft_x, timeleft_y, 300, "left")
				else
					ItemIcons:draw("2/14005", timeleft_x, timeleft_y-3,0,0.5)
					love.graphics.setFont(DefaultFont)
					love.graphics.printf(GameInfo.coin, timeleft_x+26,timeleft_y, 300, "left")
				end
				
				if not (d == "easy") then
					if(PuzzleSwitch == 1) then
						love.graphics.setFont(DefaultFont)
						if (GameInfo.passwt%8 >= 4 and GameInfo.passwt%8 <8) then-- >=4 and <8, >=C and <F
							love.graphics.setColor( 0, 200/255, 0, 1 )
						else
							love.graphics.setColor( 127/255, 127/255, 127/255, 1 )
						end
						love.graphics.printf(passwt, passwt_x, passwt_y, 300, "left")
					end
				end

			love.graphics.setColor( 1, 1, 1, 1 )

			elseif (s == "desperate times") then
				if(GameInfo.fighttime2 == 0) then
					love.graphics.setFont(DefaultFont)
					love.graphics.printf((GameInfo.killedzombies), timeleft_x, timeleft_y, 300, "left")
				else
					ItemIcons:draw("2/11511", icon_x, icon_y,0,icon_scale)
					love.graphics.printf(Time2string3(GameInfo.gastime), gastime_x, gastime_y, 56, "center",0,gastime_scale,gastime_scale)
				end
				love.graphics.setFont(TimeFont)
				if(GameInfo.garagetime > 0) and (GameInfo.fighttime2  > 0) then
					love.graphics.printf(Time2string3(GameInfo.garagetime), timeleft_x+70, timeleft_y, 60, "center")
				end
				if(GameInfo.fighttime > 0) and (GameInfo.fighttime2 == 0xffff)then
					love.graphics.printf(Time2string3(GameInfo.fighttime), timeleft_x, timeleft_y, 60, "center")
				end
				if(GameInfo.fighttime2 > 0) and not (GameInfo.fighttime2 == 0xffff) then
					love.graphics.printf(Time2string3(GameInfo.fighttime2), timeleft_x, timeleft_y, 60, "center")
				end

				love.graphics.setFont(DefaultFont)
				if(GameInfo.fighttime == 0) and (GameInfo.fighttime2 == 0xffff) then
					if(PuzzleSwitch == 1) then
						if (GameInfo.passdt3%8 >= 4 and GameInfo.passdt3%8 <8) then-- >=4 and <8, >=C and <F						love.graphics.setColor( 0, 200/255, 0, 1 )
							love.graphics.setColor( 0, 200/255, 0, 1 )
						else
							love.graphics.setColor( 127/255, 127/255, 127/255, 1 )
						end
						love.graphics.printf(passdt, timeleft_x, timeleft_y, 300, "left")
					end
				end

			love.graphics.setColor( 1, 1, 1, 1 )

				love.graphics.setFont(VerySmallFont)
				if(gr%2 == 0) and not (GameInfo.fighttime2 == 0) then
					if(gl == 1) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,4).."\n"..GetRoomName(s,14).."\n"..GetRoomName(s,20)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,14).."\n"..GetRoomName(s,20)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 2) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,7).."\n"..GetRoomName(s,10).."\n"..GetRoomName(s,12)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,7).."\n"..GetRoomName(s,12)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 4) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,9).."\n"..GetRoomName(s,13).."\n"..GetRoomName(s,27)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,9).."\n"..GetRoomName(s,13)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 8) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,5).."\n"..GetRoomName(s,7).."\n"..GetRoomName(s,21)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,5).."\n"..GetRoomName(s,21)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 16) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,4).."\n"..GetRoomName(s,10).."\n"..GetRoomName(s,11)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,10).."\n"..GetRoomName(s,11)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 32) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,5).."\n"..GetRoomName(s,15).."\n"..GetRoomName(s,16)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,15).."\n"..GetRoomName(s,16)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 64) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,4).."\n"..GetRoomName(s,11).."\n"..GetRoomName(s,13)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,4).."\n"..GetRoomName(s,11)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 128) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,14).."\n"..GetRoomName(s,15).."\n"..GetRoomName(s,21)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,14).."\n"..GetRoomName(s,15)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 256) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,11).."\n"..GetRoomName(s,20).."\n"..GetRoomName(s,27)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,11).."\n"..GetRoomName(s,20)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 512) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,5).."\n"..GetRoomName(s,9).."\n"..GetRoomName(s,16)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,5).."\n"..GetRoomName(s,9)}, gasroom_x, gasroom_y, 150, "left")
						end
					end
				end

				if(gr%2 == 1) and not (GameInfo.fighttime2 == 0) then
					if(gl == 1) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,7).."\n"..GetRoomName(s,10).."\n"..GetRoomName(s,16)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,10).."\n"..GetRoomName(s,16)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 2) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,4).."\n"..GetRoomName(s,14).."\n"..GetRoomName(s,27)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,14).."\n"..GetRoomName(s,27)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 4) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,7).."\n"..GetRoomName(s,16).."\n"..GetRoomName(s,20)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,7).."\n"..GetRoomName(s,20)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 8) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,9).."\n"..GetRoomName(s,13).."\n"..GetRoomName(s,21)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,9).."\n"..GetRoomName(s,13)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 16) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,10).."\n"..GetRoomName(s,12).."\n"..GetRoomName(s,15)}, gasroom_x, gasroom_y, 180,  "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,12).."\n"..GetRoomName(s,15)}, gasroom_x, gasroom_y, 150,  "left")
						end
					elseif(gl == 32) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,5).."\n"..GetRoomName(s,16).."\n"..GetRoomName(s,21)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,5).."\n"..GetRoomName(s,21)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 64) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,5).."\n"..GetRoomName(s,11).."\n"..GetRoomName(s,27)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,11).."\n"..GetRoomName(s,27)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 128) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,4).."\n"..GetRoomName(s,7).."\n"..GetRoomName(s,20)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,4).."\n"..GetRoomName(s,20)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 256) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,10).."\n"..GetRoomName(s,12).."\n"..GetRoomName(s,13)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,12).."\n"..GetRoomName(s,13)}, gasroom_x, gasroom_y, 150, "left")
						end
					elseif(gl == 512) then
						if(d == "hard" or d == "very hard") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,7).."\n"..GetRoomName(s,15).."\n"..GetRoomName(s,21)}, gasroom_x, gasroom_y, 150, "left")
						elseif(d == "easy" or d == "normal") then
							love.graphics.printf({{1, 1, 0, 1},GetRoomName(s,7).."\n"..GetRoomName(s,21)}, gasroom_x, gasroom_y, 150, "left")
						end
					end
				end

			elseif (s == "below freezing point") then
				if(PuzzleSwitch == 1) then
					love.graphics.setFont(DefaultFont)
					love.graphics.printf(passbfp.."-"..pass2bfp, timeleft_x, timeleft_y, 300, "left")
				end

			elseif (s == "the hive") then
				if(PuzzleSwitch == 1) then
					love.graphics.setFont(DefaultFont)
					love.graphics.printf(passhive, timeleft_x, timeleft_y, 300, "left")
				end

			elseif (s == "hellfire") then
				if(PuzzleSwitch == 1) then
					love.graphics.setFont(DefaultFont)
					love.graphics.printf(hfpass.."-"..hfmap.."-"..hfpower, timeleft_x, timeleft_y, 300, "left")
				end

			elseif (s == "decisions,decisions") then
				if(PuzzleSwitch == 1) then
					love.graphics.setFont(DefaultFont)
					love.graphics.printf(ddpass.."-"..clocktime, timeleft_x, timeleft_y, 300, "left")
				end

			elseif (s == "underbelly") then
				if(GameInfo.escapetime == 0 or GameInfo.escapetime == 0xffff)then
					if(PuzzleSwitch == 1) then
						love.graphics.setFont(DefaultFont)
						if(GameInfo.passub3%64 >=32) then
							love.graphics.setColor( 0, 200/255, 0, 1 )
						else
							love.graphics.setColor( 127/255, 127/255, 127/255, 1 )
						end
						love.graphics.printf(passub1, timeleft_x, timeleft_y, 300, "left")

						if(GameInfo.passub3%32 >=16) then
							love.graphics.setColor( 0, 200/255, 0, 1 )
						else
							love.graphics.setColor( 127/255, 127/255, 127/255, 1 )
						end
						love.graphics.printf(passub2, timeleft_x+60, timeleft_y, 300, "left")
					end

					love.graphics.setColor( 1, 1, 1, 1 )
				else
					love.graphics.setFont(TimeFont)
					love.graphics.printf(Time2string3(GameInfo.escapetime), timeleft_x, timeleft_y, 60, "center")
				end

			elseif (s == "flashback") then
				if(GameInfo.escapetime > 0) and not (GameInfo.escapetime == 0xffff)then
					love.graphics.setFont(TimeFont)
					love.graphics.printf(Time2string3(GameInfo.escapetime), timeleft_x, timeleft_y, 60, "center")
				end

			elseif (s == "end of the road") then
				love.graphics.setFont(DefaultFont)
				love.graphics.printf(GameInfo.pass4, timeleft_x, timeleft_y, 300, "left")
			end
		end	
		if HelpMenu==1 then
			love.graphics.rectangle('line',2,2,296,360,3,3,1)
			love.graphics.setColor( 0, 0, 0, 0.85 )
			love.graphics.rectangle('fill',2,2,296,360,3,3,1)
			love.graphics.setFont(VerySmallFont)
			love.graphics.setColor( 1, 1, 1, 1 )
			love.graphics.printf(_l("Language list"), 4, 4, 300, "left")
			love.graphics.printf(_l("Help Menu"), 4, 60, 300, "left")
		end

	elseif InitResult == false then
		love.graphics.setFont(DefaultFont)
		love.graphics.printf(_l("Unable to find PCSX2 process.\n Will try again in ") .. tostring(math.floor(5-RetryTimer + 0.5)) .. ".", errorX, errorY, 300, "center")
		love.graphics.setFont(VerySmallFont)
		love.graphics.printf(_l("Language list"), 4, 4, 300, "left")
		love.graphics.printf(_l("Hotkeys list"), 4, 60, 300, "left")
	elseif InitResult == true and GameInfo.currentFile == 255 then
		love.graphics.setFont(DefaultFont)
		love.graphics.printf(_l("This is not Biohazard Outbreak game.\n Will try again in ") .. tostring(math.floor(5-RetryTimer + 0.5)) .. ".", errorX, errorY, 300, "center")
		love.graphics.setFont(VerySmallFont)
		love.graphics.printf(_l("Language list"), 4, 4, 300, "left")
		love.graphics.printf(_l("Hotkeys list"), 4, 60, 300, "left")
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
		tracker.updateRoom()
		tracker.update()
		GameInfo = tracker.getGameInfo()
		local p = GameInfo.playernum
		local itemset = GameInfo.itemrandom
		local r = GameInfo.itemrandom2
		local gr = GameInfo.gasrandom
		local f = GameInfo.frames
		local s = GameInfo.scenario
		local d = GameInfo.difficulty
		local hs = GameInfo.hoststatus
		local hm = GameInfo.hostscenario
		local hd = GameInfo.hostdifficulty
		local hp = GameInfo.hostplayer
		local hmp = GameInfo.hostmaxplayer
		local ht = GameInfo.hosttime
		local gl = GameInfo.gasflag

		--if GameInfo.cleared >= 12 then
		--timer = timer and timer or 0
		--elseif GameInfo.cleared < 2 then
		--timer =0
		--else
		--timer = timer and timer + dt or 0
		--end
		--if (hs == 4 and s == "") then
		--	playtimer = playtimer and playtimer + dt or 0
		--end
		if GameInfo.currentFile > 0 then
			if (hs == 3 and s == "") then
				for i=1, 20 do
					Slots[i] = tracker.getLobby(i)
				end
			end
			--if (hs >= 4 and hs < 6 and s=="") then
				for i=1, 4 do
					SPlayers[i] = tracker.getSlotPlayer(i)
				end
			--end
			if not(s == "") and (f > 0) and ItemSwitch ==1 then
				for i=1, 1 do
					Items[i] = tracker.getItem(i)
				end
			end
			if not(s == "") and PlayerList ==1 then
				for i=1, 4 do
					Players[i] = tracker.getPlayer(i)
				end
			end
			if not(s == "") and (f > 0) and EnemyHPSwitch ==1 then
				for i=1, 12 do
					Enemies[i] = tracker.getEnemy(i)
				end
			end
			if not(s == "") and (f > 0) and EnemyList ==1 then
				for i=1, 80 do
					Enemies2[i] = tracker.getEnemyList(i)
				end
			end
			if not(s == "") and (f > 0) and ItemList >0 then
				for i=1, 255 do
					Items2[i] = tracker.getItem2(i)
				end
			end
			if not(s == "") and (f > 0) and doorList ==1 then
				for i=1, 19 do
					Doors[i] = tracker.getDoor(i)
				end
			end
			if not(s == "") and (f > 0) then
				for i=1, 128 do
					RoomMasters[i] = tracker.getRoomMaster(i)
				end
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
	--if key == "f5" then
	--	if doorList==0 then doorList=1 ItemList=0 ItemSwitch=0 PlayerList =0 EnemyHPSwitch=0 TimeSwitch=0
		--elseif EnemyList==1 then EnemyList=2
	--	else doorList=0 PlayerList =1 EnemyHPSwitch=1 ItemSwitch=1 TimeSwitch=1
	--	end
	--end
	if key == "f4" then
		if EnemyList==0 then EnemyList=1 ItemList=0 ItemSwitch=0 PlayerList =0 EnemyHPSwitch=0 TimeSwitch=0 doorList=0
		--elseif EnemyList==1 then EnemyList=2
		else EnemyList=0 PlayerList =1 EnemyHPSwitch=1 ItemSwitch=1 TimeSwitch=1 doorList=1
		end
	end
	if key == "f8" then love.window.setMode(wx, wy,{borderless=true,resizable=true,vsync = 3}) love.window.setPosition(x, y)end
	if key == "f1" then
		if HelpMenu==0 then HelpMenu=1
		else HelpMenu=0
		end
	end	
	if key == "f2" then --vsync
		if ItemList==0 then ItemList=1 ItemSwitch=0 PlayerList =0 EnemyHPSwitch=0 EnemyList=0 TimeSwitch=0  doorList=0
		elseif ItemList==1 then ItemList=2 ItemSwitch=0 PlayerList =0 EnemyHPSwitch=0 EnemyList=0 TimeSwitch=0 doorList=0
		else ItemList=0 ItemSwitch=1 PlayerList =1 EnemyHPSwitch=1 TimeSwitch=1 doorList=1
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
	if key == "d" then love.window.setMode(300, 160+(145*4),{resizable=true,vsync = 3}) love.window.setPosition(x, y)scalex,scaley = 300, 160+(145*4) Style = 0 end
	if key == "h" then love.window.setMode(300*4+150, 145+60,{resizable=true,vsync = 3}) love.window.setPosition(x, y)scalex,scaley = 300*4+150, 145+60 Style = 1 end
	if key == "v" then love.window.setMode(300, 160+(145*4),{resizable=true,vsync = 3}) love.window.setPosition(x, y)scalex,scaley = 300, 160+(145*4) Style = 0 end
	if key =="l" then
		if LanguageSwitch == 0 then LanguageSwitch=1
		elseif LanguageSwitch==1 then LanguageSwitch=0
		end
	end
	if InitResult then
		if not(s == "") then
			if key =="kp0" then
				PlayerSwitch=0 EnemyHPSwitch=1
			end
			if key =="kp1" then
				PlayerSwitch=1 EnemyHPSwitch=2
			end
			if key =="kp2" then
				PlayerSwitch=2 EnemyHPSwitch=2
			end
			if key =="kp3" then
				PlayerSwitch=3 EnemyHPSwitch=2
			end
			if key =="kp4" then
				PlayerSwitch=4 EnemyHPSwitch=2
			end
			if key =="t" then
				if TimeSwitch == 0 then TimeSwitch=1
				elseif TimeSwitch==1 then TimeSwitch=0
				end
			end
			if key =="i" then
				if ItemSwitch == 0 then ItemSwitch=1
				elseif ItemSwitch==1 then ItemSwitch=0
				end
			end
			if key =="q" then
				if PuzzleSwitch == 0 then PuzzleSwitch=1
				elseif PuzzleSwitch==1 then PuzzleSwitch=0
				end
			end
			if key =="e" then
				if EnemyHPSwitch == 0 then EnemyHPSwitch=1
				elseif EnemyHPSwitch==1 then EnemyHPSwitch=2
				elseif EnemyHPSwitch==2 then EnemyHPSwitch=0
				end
			end
			if key == "1" then love.window.setMode(300, (145*1),{resizable=true,vsync = 3}) love.window.setPosition(x, y)scalex,scaley = 300, (145*1) end
			if key == "2" then love.window.setMode(300, (145*2),{resizable=true,vsync = 3}) love.window.setPosition(x, y)scalex,scaley = 300, (145*2) end
			if key == "3" then love.window.setMode(300, (145*3),{resizable=true,vsync = 3}) love.window.setPosition(x, y)scalex,scaley = 300, (145*3) end
			if key == "4" then love.window.setMode(300, (145*4),{resizable=true,vsync = 3}) love.window.setPosition(x, y)scalex,scaley = 300, (145*4) end
			if key == "a" then
				if Style==0 then
					love.window.setMode(300, 160+(145*p),{resizable=true,vsync = 3}) love.window.setPosition(x, y)scalex,scaley = 300, 160+(145*p)
				else
					love.window.setMode(300*p+150, 145+60,{resizable=true,vsync = 3}) love.window.setPosition(x, y)scalex,scaley = 300*p+150, 145+60
				end
					end
			--if key == "s" then love.window.setMode(110, (145*p),{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 110,(145*p) end
			--if key == "t" then love.window.setMode(300, 20+(145*p),{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300, 20+(145*p)end
			--if key == "e" then love.window.setMode(300, 105+(145*p)) love.window.setPosition(x, y)end
			--if key == "d" then love.window.setMode(300, 740) love.window.setPosition(x, y)end
			
			--if key == "h" then love.window.setMode(300*p+150, 145+60,{resizable=true}) love.window.setPosition(x, y)scalex,scaley = 300*p+150, 145+60 Style = 1 end
			
		end
	end
end
