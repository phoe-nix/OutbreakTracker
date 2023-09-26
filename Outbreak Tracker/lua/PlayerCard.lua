PlayerCard = {}
PlayerCard.__index = PlayerCard

local IconPositions = {
--[[ x  | y  ]]--
	{8,   42},
	{56,  42},
	{8,   92},
	{56,  92},
	{117, 92},
	{105, 42},
	{154, 42},
	{105, 92},
	{154, 92},
}

function PlayerCard:new(id)
	local o = {}
	o.id = id or 1
	o.icons = {}
	for i=1, 9 do
		o.icons[i] = ItemIcon:new(unpack(IconPositions[i]))
	end

	o.nameLabel 	  = Label:new(10 , 4, "placeholder", SmallFont)
	o.nameLabelShadow = Label:new(12 , 5, "placeholder", SmallFont, nil, nil, nil, nil, {0, 0, 0, 1})
	o.roomLabel		  = Label:new(110, 0, "placeholder", SmallFont, "center", "center", 190, 40)
	o.roomLabelShadow = Label:new(111, 1, "placeholder", SmallFont, "center", "center", 190, 40, {0, 0, 0, 1})
	--o.roomLabel_j		= Label:new(280, 2, "placeholder", SmallFont, "center", "up", 15, 145)
	--o.roomLabelShadow_j = Label:new(281, 3, "placeholder", SmallFont, "center", "up", 15, 145, {0, 0, 0, 1})
	o.healthLabel	  = Label:new(8  ,20, "placeholder", VerySmallFont, "center", "up", 70, 10)


	return setmetatable(o, self)
end

function PlayerCard:draw(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	local player = Players[self.id]
	local sb = love.graphics.newSpriteBatch(UIAtlas.tex)
	local bustname = "bust" .. Players[self.id].type
	local bx, by, bw, bh = UIAtlas.quads[bustname]:getViewport()
	local scale = 140 / bh;

	if Players[self.id].inGame == false then
		sb:setColor(1, 1, 1, 0.5)
	else
		sb:setColor(1, 1, 1, 1)
	end
	UIAtlas:addSB(sb, bustname, 300 - bw * scale, 145 - bh * scale, 0, scale, scale)
	sb:setColor(1, 1, 1, 1)
	if not(Players[self.id].status == "Dead" or Players[self.id].status == "Down" or Players[self.id].status == "Zombie") then
		sb:setColor(unpack(GetConditionColor(GetConditionName(Players[self.id].HP, Players[self.id].maxHP))))
	else
		sb:setColor(unpack(GetConditionColor(GetConditionName(0, 2))))
	end
	UIAtlas:addSB(sb, "healthmask", 8, 5);
	sb:setColor(1, 1, 1, 1)
	UIAtlas:addSB(sb, "statusbar", 0, 2);
	UIAtlas:addSB(sb, GetVirusState(Players[self.id].virus), 86, 18)
	if not(Players[self.id].type == "Yoko" or Players[self.id].type == "David" or Players[self.id].type == "Cindy")
		and not(Players[self.id].status == "Dead" or Players[self.id].status == "Zombie") then
		sb:setColor(20/255, 48/255, 85/255, 0.8)
		UIAtlas:addSB(sb, "inventorymask", 8, 42);
		UIAtlas:addSB(sb, "ispecialmask", 118, 92);
		sb:setColor(1, 1, 1, 1)
		UIAtlas:addSB(sb, "invSingle", 0, 37);
		UIAtlas:addSB(sb, "invSpecial", 110, 89);
	else
		sb:setColor(20/255, 48/255, 85/255, 0.8)
		UIAtlas:addSB(sb, "inventorymask", 8, 42);
		if not(Players[self.id].status == "Dead" or Players[self.id].status == "Zombie") then
			sb:setColor(50/255, 120/255, 70/255, 0.8)
		end
		UIAtlas:addSB(sb, "inventorymask", 106, 42);
		sb:setColor(1, 1, 1, 1)
		UIAtlas:addSB(sb, "invDouble", 0, 37);
	end
	if Players[self.id].type == "Alyssa" and not (Players[self.id].status == "Dead") then
		love.graphics.setFont(VerySmallFont)
		love.graphics.printf("I",118, 92,12, "center")
		love.graphics.printf("S",130, 92,12, "center")
		love.graphics.printf("W",118, 104,12, "center")
		love.graphics.printf("P",130, 104,12, "center")
	end

	love.graphics.draw(sb)

	for i=1, 4 do
		if not(Players[self.id].inventory[i].id == -1) then
			self.icons[i].type = Players[self.id].inventory[i].type
			self.icons[i].count = Players[self.id].inventory[i].count
			local equip = Players[self.id].equipped
			if equip == 0 then
				self.icons[i].equipped = false
			else
				self.icons[i].equipped = (equip == Players[self.id].inventory[i].id)
			end
			self.icons[i]:draw()
		end
	end
	if not(Players[self.id].type == "Yoko" or  Players[self.id].type == "David" or  Players[self.id].type == "Cindy") and not(Players[self.id].specialItem.id == -1)
		and not(Players[self.id].status == "Dead" or Players[self.id].status == "Zombie") then
		self.icons[5].type = Players[self.id].specialItem.type
		self.icons[5].count = Players[self.id].specialItem.count
		local equip = Players[self.id].equipped
		if equip <= 0 then
			self.icons[5].equipped = false
		else
			self.icons[5].equipped = (equip == Players[self.id].specialItem.id)
		end
		if Players[self.id].specialItem.type == 403 then
			self.icons[5]:draw(false)
		else
			self.icons[5]:draw(true)
		end
	else
		for i=6, 9 do
			if not(Players[self.id].specialInventory[i-5].id == -1) then
				self.icons[i].type = Players[self.id].specialInventory[i-5].type
				self.icons[i].count = Players[self.id].specialInventory[i-5].count
				local equip = Players[self.id].equipped
				if equip <= 0 then
					self.icons[i].equipped = false
				else
					self.icons[i].equipped = (equip == Players[self.id].specialInventory[i-5].id)
				end
				self.icons[i]:draw()
			end
		end
	end

	love.graphics.setFont(VerySmallFont)
	love.graphics.setColor( 0, 1, 0, 1 )
	if Players[self.id].type == "Alyssa" and not (Players[self.id].status == "Dead") then
		if (GameInfo.scenario == "outbreak") then
			if Players[self.id].roomID == 1 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 922211-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 922211+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 1261926-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 1261926+25000) then
					if(GameInfo.difficulty == "very hard") then
						love.graphics.printf("S",130, 92,12, "center")--J's Bar
					elseif GameInfo.difficulty == "hard" then
						love.graphics.printf("P",130, 104,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 5 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 867210-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 867210+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 1301926-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 1301926+25000) then
					if(GameInfo.difficulty == "very hard") then
						love.graphics.printf("S",130, 92,12, "center")--Staff Room
					else
						love.graphics.printf("P",130, 104,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 7 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 915857-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 915857+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 1245250-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 1245250+25000) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf("W",118, 104,12, "center")--Drawing Room (Cabinet)
					else
						love.graphics.printf("S",130, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 14 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 787211-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 787211+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 1301926-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 1301926+25000) then
					if(GameInfo.difficulty == "very hard") then
						love.graphics.printf("P",130, 104,12, "center")--Rooftop
					elseif(GameInfo.difficulty == "hard") then
						love.graphics.printf("S",130, 92,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
		elseif (GameInfo.scenario == "below freezing point") then
			if Players[self.id].roomID == 15 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 560641-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 560641+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 425127-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 425127+25000) then
					if(GameInfo.difficulty == "hard") then
						love.graphics.printf("I",118, 92,12, "center")--Break Room (Locker)
					else
						love.graphics.printf("S",130, 92,12, "center")
					end
				end
			end
		elseif (GameInfo.scenario == "the hive") then
			if Players[self.id].roomID == 14 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 645873-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 645873+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 322941-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 322941+25000) then
					if(GameInfo.difficulty == "very hard") then
						love.graphics.printf("S",130, 92,12, "center")--Locker Room (Locker)
					else
						love.graphics.printf("P",130, 104,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 5 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 661941-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 661941+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 193027-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 193027+25000) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf("I",118, 92,12, "center")--Office (Drawer)
					else
						love.graphics.printf("W",118, 104,12, "center")
					end
				end
			end
		elseif (GameInfo.scenario == "hellfire") then
			if Players[self.id].roomID == 29 or Players[self.id].roomID == 34 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 967660-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 967660+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 977602-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 977602+25000) then
					if(GameInfo.difficulty == "very hard") then
						love.graphics.printf("W",118, 104,12, "center")--1F Corridor→ Lounge Stairs
					elseif(GameInfo.difficulty == "hard") then
						love.graphics.printf("P",130, 104,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 36 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 1014602-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 1014602+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 1042339-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 1042339+25000) then
					if(GameInfo.difficulty == "very hard") then
						love.graphics.printf("W",118, 104,12, "center")--Room 102
					elseif(GameInfo.difficulty == "hard") then
						love.graphics.printf("P",130, 104,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 40 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 769602-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 769602+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 1022339-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 1022339+25000) then
					if(GameInfo.difficulty == "very hard") then
						love.graphics.printf("W",118, 104,12, "center")--Room 201
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf("S",130, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 44 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 1014602-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 1014602+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 1042339-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 1042339+25000) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf("I",118, 92,12, "center")--Room 202
					else
						love.graphics.printf("W",118, 104,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 42 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 861258-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 861258+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 970073-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 970073+25000) then
					if(GameInfo.difficulty == "hard") then
						love.graphics.printf("W",118, 104,12, "center")--Store Room (Locker)
					elseif(GameInfo.difficulty == "easy" or GameInfo.difficulty == "normal") then
						love.graphics.printf("S",130, 92,12, "center")
					end
				end
			end
		elseif (GameInfo.scenario == "decisions,decisions") then
			if Players[self.id].roomID == 78 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 340476-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 340476+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 828902-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 828902+25000) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf("W",118, 104,12, "center")--1F Elevator Passway (Locker)
					else
						love.graphics.printf("S",130, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 55 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 302041-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 302041+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 424727-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 424727+25000) then
					if(GameInfo.difficulty == "very hard") then
						love.graphics.printf("S",130, 92,12, "center")--B4F Control Room (Locker)
					else
						love.graphics.printf("P",130, 104,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 54 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 337211-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 337211+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 386927-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 386927+25000) then
					if(GameInfo.difficulty == "very hard") then
						love.graphics.printf("W",118, 104,12, "center")--T-shaped Corridor
					elseif(GameInfo.difficulty == "hard") then
						love.graphics.printf("S",130, 92,12, "center")
					else
						love.graphics.printf("P",130, 104,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 58 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 272927-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 272927+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 352789-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 352789+25000) then
					if(GameInfo.difficulty == "very hard") then
						love.graphics.printf("W",118, 104,12, "center")--Store Room
					elseif(GameInfo.difficulty == "hard") then
						love.graphics.printf("S",130, 92,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
		elseif (GameInfo.scenario == "wild things") then
			if(math.floor(Players[self.id].positionX*100+0.5) > 1303073-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 1303073+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 1337211-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 1337211+25000) then
				if(GameInfo.difficulty == "very hard") then
					love.graphics.printf("W",118, 104,12, "center")
				elseif GameInfo.difficulty == "hard" then
					love.graphics.printf("S",130, 92,12, "center")
				else
					love.graphics.printf("P",130, 104,12, "center")
				end
			elseif(math.floor(Players[self.id].positionX*100+0.5) > 1473000-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 1473000+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 1431471-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 1431471+25000) then
				if(GameInfo.difficulty == "very hard") then
					love.graphics.printf("P",130, 104,12, "center")
				elseif GameInfo.difficulty == "hard" then
					love.graphics.printf("I",118, 92,12, "center")
				else				
					love.graphics.printf("W",118, 104,12, "center")
				end
			elseif(math.floor(Players[self.id].positionX*100+0.5) > 1442788-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 1442788+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 1454573-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 1454573+25000) then
				if(GameInfo.difficulty == "very hard") then
					love.graphics.printf("S",130, 92,12, "center")
				elseif GameInfo.difficulty == "hard" then
					love.graphics.printf("P",130, 104,12, "center")
				else
					love.graphics.printf("I",118, 92,12, "center")
				end
			elseif(math.floor(Players[self.id].positionX*100+0.5) > 1418758-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 1418758+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 1528529-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 1528529+25000) then
				if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
					love.graphics.printf("W",118, 104,12, "center")
				else
					love.graphics.printf("S",130, 92,12, "center")
				end
			elseif(math.floor(Players[self.id].positionX*100+0.5) > 1067211-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 1067211+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 896926-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 896926+25000) then
				if(GameInfo.difficulty == "very hard") then
					love.graphics.printf("I",118, 92,12, "center")
				end
			elseif(math.floor(Players[self.id].positionX*100+0.5) > 986926-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 986926+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 677789-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 677789+25000) then
				if(GameInfo.difficulty == "very hard") then
					love.graphics.printf("I",118, 92,12, "center")
				elseif GameInfo.difficulty == "hard" then
					love.graphics.printf("W",118, 104,12, "center")
				end
			elseif(math.floor(Players[self.id].positionX*100+0.5) > 632211-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 632211+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 876926-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 876926+25000) then
				if(GameInfo.difficulty == "very hard") then
					love.graphics.printf("P",130, 104,12, "center")
				end
			elseif(math.floor(Players[self.id].positionX*100+0.5) > 714458-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 714458+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 781273-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 781273+25000) then	
				if(GameInfo.difficulty == "very hard") then
					love.graphics.printf("S",130, 92,12, "center")
				else
					love.graphics.printf("P",130, 104,12, "center")
				end
			elseif(math.floor(Players[self.id].positionX*100+0.5) > 986926-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 986926+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 462789-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 462789+25000) then	
				if(GameInfo.difficulty == "normal" or GameInfo.difficulty == "very hard") then
					love.graphics.printf("P",130, 104,12, "center")
				elseif GameInfo.difficulty == "hard" then
					love.graphics.printf("S",130, 92,12, "center")
				else
					love.graphics.printf("I",118, 92,12, "center")
				end
			end
		elseif GameInfo.scenario == "underbelly" then
			if Players[self.id].roomID == 18 or Players[self.id].roomID == 7 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 812397-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 812397+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 292661-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 292661+25000) then
					if GameInfo.difficulty == "very hard" then
						love.graphics.printf("P",130, 104,12, "center")--East Concourse
					elseif GameInfo.difficulty == "hard" then
						love.graphics.printf("I",118, 92,12, "center")--East Concourse
					end
				end
			end
			if Players[self.id].roomID == 3 or Players[self.id].roomID == 7 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 467602-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 467602+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 287339-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 287339+25000) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf("W",118, 104,12, "center")--West Concourse
					end
				end
			end
			if Players[self.id].roomID == 7 or Players[self.id].roomID == 11 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 692339-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 692339+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 287398-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 287398+25000) then
					if GameInfo.difficulty == "very hard" then
						love.graphics.printf("I",118, 92,12, "center")--Break Room (Front)
					elseif GameInfo.difficulty == "hard" then
						love.graphics.printf("W",118, 104,12, "center")--Break Room (Front)
					end
				end
				if (math.floor(Players[self.id].positionX*100+0.5) > 697660-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 697660+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 162602-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 162602+25000) then
					if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
						love.graphics.printf("I",118, 92,12, "center")--Break Room (Back)
					end
				end
			end
			if Players[self.id].roomID == 9 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 573127-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 573127+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 242559-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 242559+25000) then
					if GameInfo.difficulty == "very hard" then
						love.graphics.printf("S",130, 92,12, "center")--Control room (Drawer)
					else
						love.graphics.printf("P",130, 104,12, "center")--Control room (Drawer)
					end
				end
			end
		elseif GameInfo.scenario == "desperate times" then
			if Players[self.id].roomID == 1 or Players[self.id].roomID == 4 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 431927-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 431927+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 947788-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 947788+25000) then
					if GameInfo.difficulty == "very hard" then
						love.graphics.printf("S",130, 92,12, "center")--1F Lobby→ Main Hall
					elseif GameInfo.difficulty == "hard" then
						love.graphics.printf("P",130, 104,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 4 or Players[self.id].roomID == 20 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 564839-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 564839+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 847397-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 847397+25000) then
					if GameInfo.difficulty == "very hard" then
						love.graphics.printf("S",130, 92,12, "center")--1F Lobby→ Hallway
					elseif GameInfo.difficulty == "hard" then
						love.graphics.printf("P",130, 104,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 2 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 211841-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 211841+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 890226-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 890226+25000) then
					if GameInfo.difficulty == "very hard" then
						love.graphics.printf("S",130, 92,12, "center")--Reception Desk (Drawer)
					elseif GameInfo.difficulty == "hard" then
						love.graphics.printf("P",130, 104,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 9 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 585841-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 585841+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 723327-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 723327+25000) then
					if GameInfo.difficulty == "very hard" then
						love.graphics.printf("S",130, 92,12, "center")--1F East Passage (Cabinet)
					elseif GameInfo.difficulty == "hard" then
						love.graphics.printf("P",130, 104,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 11 or Players[self.id].roomID == 12 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 567660-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 567660+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 842602-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 842602+25000) then
					if GameInfo.difficulty == "very hard" then
						love.graphics.printf("S",130, 92,12, "center")--B1F East Hall
					elseif GameInfo.difficulty == "hard" then
						love.graphics.printf("P",130, 104,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 14 or Players[self.id].roomID == 15 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 137339-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 137339+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 862397-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 862397+25000) then
					if GameInfo.difficulty == "very hard" then
						love.graphics.printf("S",130, 92,12, "center")
					elseif GameInfo.difficulty == "hard" then
						love.graphics.printf("P",130, 104,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
			if Players[self.id].roomID == 9 or Players[self.id].roomID == 5 then
				if(math.floor(Players[self.id].positionX*100+0.5) > 592660-25000
				and math.floor(Players[self.id].positionX*100+0.5) < 592660+25000
				and math.floor(Players[self.id].positionY*100+0.5) > 852602-25000
				and math.floor(Players[self.id].positionY*100+0.5) < 852602+25000) then
					if GameInfo.difficulty == "very hard" then
						love.graphics.printf("S",130, 92,12, "center")
					elseif GameInfo.difficulty == "hard" then
						love.graphics.printf("P",130, 104,12, "center")
					else
						love.graphics.printf("I",118, 92,12, "center")
					end
				end
			end
		elseif GameInfo.scenario == "flashback" then
			if(math.floor(Players[self.id].positionX*100+0.5) > 854792-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 854792+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 667988-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 667988+25000) then
				if GameInfo.difficulty == "very hard" then
					love.graphics.printf("S",130, 92,12, "center")
				elseif GameInfo.difficulty == "hard" then
					love.graphics.printf("P",130, 104,12, "center")
				else
					love.graphics.printf("I",118, 92,12, "center")
				end
			elseif(math.floor(Players[self.id].positionX*100+0.5) > 1067339-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 1067339+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 637398-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 637398+25000) then
				if GameInfo.difficulty == "very hard" then
					love.graphics.printf("S",130, 92,12, "center")
				elseif GameInfo.difficulty == "hard" then
					love.graphics.printf("P",130, 104,12, "center")
				end
			end
		elseif GameInfo.scenario == "end of the road" then
			if(math.floor(Players[self.id].positionX*100+0.5) > 481741-25000
			and math.floor(Players[self.id].positionX*100+0.5) < 481741+25000
			and math.floor(Players[self.id].positionY*100+0.5) > 332327-25000
			and math.floor(Players[self.id].positionY*100+0.5) < 332327+25000) then
				if(GameInfo.difficulty == "hard" or GameInfo.difficulty == "very hard") then
					love.graphics.printf("I",118, 92,12, "center")
				else
					love.graphics.printf("S",130, 92,12, "center")
				end
			end
		end
	end
	
	love.graphics.setColor( 1, 1, 1, 1 )

	self.nameLabel.text = Players[self.id].name:upper()
	self.nameLabelShadow.text = Players[self.id].name:upper()
	self.nameLabelShadow:draw()
	self.nameLabel:draw()

	self.healthLabel.color = GetStatusColor(self.id)
	self.healthLabel.text = GetPlayerHealthString(self.id)
	self.healthLabel:draw()

	self.roomLabel.text = GetRoomName(GameInfo.scenario, Players[self.id].roomID)
	self.roomLabelShadow.text = GetRoomName(GameInfo.scenario, Players[self.id].roomID)
	self.roomLabelShadow:draw()
	self.roomLabel:draw()

	local a = Players[self.id].antivirustime
	local b = Players[self.id].antivirusgtime
	local c = Players[self.id].herbtime
	local d = Players[self.id].bleedtime
	local e = Players[self.id].status

	if GameInfo.currentFile == 1 then
		if b > 0 then
			ItemIcons:draw("1/317", 250, 64,0,0.65)
			love.graphics.printf({{0, 0, 0, 1},Time2string5(b)},241,73,60,"right")
			love.graphics.printf({{1, 1, 1, 1},Time2string5(b)},240,72,60,"right")
		end
	end
	if a > c then
		if a > 0 then
			ItemIcons:draw("1/316", 250, 82,0,0.65)
			love.graphics.printf({{0, 0, 0, 1},Time2string5(a)},241,91,60,"right")
			love.graphics.printf({{1, 1, 1, 1},Time2string5(a)},240,90,60,"right")
		end
	else
		if c > 0 then
			ItemIcons:draw("1/316", 250, 82,0,0.65)
			love.graphics.printf({{0, 0, 0, 1},Time2string5(c)},241,91,60,"right")
			love.graphics.printf({{1, 1, 1, 1},Time2string5(c)},240,90,60,"right")
		end
	end

	if d > 0 and (e =="Bleed" or e =="Poison+Bleed" or e =="Gas+Bleed") then
		if b > 0 and GameInfo.currentFile == 1 then
			ItemIcons:draw("1/311", 250, 46,0,0.65)
			love.graphics.printf({{0, 0, 0, 1},Time2string4(d)},241,55,60,"right")
			love.graphics.printf({{1, 0, 0, 1},Time2string4(d)},240,54,60,"right")
		end
		if a > 0 or c >0 then
			ItemIcons:draw("1/311", 250, 64,0,0.65)
			love.graphics.printf({{0, 0, 0, 1},Time2string4(d)},241,73,60,"right")
			love.graphics.printf({{1, 0, 0, 1},Time2string4(d)},240,72,60,"right")
		else
			ItemIcons:draw("1/311", 250, 82,0,0.65)
			love.graphics.printf({{0, 0, 0, 1},Time2string4(d)},241,91,60,"right")
			love.graphics.printf({{1, 0, 0, 1},Time2string4(d)},240,90,60,"right")
		end
	end

	--self.roomLabel_j.text = GetRoomName_j(GameInfo.scenario, Players[self.id].roomID)
	--self.roomLabelShadow_j.text = GetRoomName_j(GameInfo.scenario, Players[self.id].roomID)
	--self.roomLabelShadow_j:draw()
	--self.roomLabel_j:draw()

	love.graphics.setFont(VirusFont)
	if Players[self.id].specialItem.type == 403 then
		love.graphics.printf({{25/255, 255/255, 25/255, 1},tostring(Players[self.id].critBonus) .. "%"}, 118, 125, 46, "right")
	end
	-- Here goes some weird magic 150, 120
	local tx, ty = 192, 125
	local val1 = math.floor(Players[self.id].virus)
	local val2 = math.floor(math.floor(Players[self.id].virus*100+0.5) - val1 * 100)
	love.graphics.printf(tostring(val1), tx, ty, 60, "right", 0, 1.25, 1.25)
	love.graphics.printf("." .. string.format("%02d", val2) .. "%", tx+73, ty+3.5, 60, "left", 0, 1.0, 1.0)
	-- weird magic ends here

	--local siz = math.floor(math.floor((Players[self.id].size)*100))
	--love.graphics.printf(string.format("%d", siz) .. "%", tx+46, ty+3.5-60, 60, "right", 0, 1.0, 1.0)

	local pow = math.floor(math.floor(Players[self.id].power*100+0.5))
	love.graphics.printf({{25/255, 255/255, 255/255, 1},string.format("%d", pow) .. "%"}, tx+46, ty+3.5-20, 60, "right", 0, 1.0, 1.0)

	if Players[self.id].inGame == true then
		if (RoomMasters[1].enabled) then
			if not(Players[self.id].roomID == 0) then
				if (RoomMasters[Players[self.id].roomID].roommaster == self.id)  then
					UIAtlas:draw("room master crown", tx+75, ty+3.5-40);
				end
			end
		end
	end

	--local spd = math.floor(math.floor(Players[self.id].speed*100+0.5))
	--love.graphics.printf(string.format("%d", spd) .. "%", tx+46, ty+3.5-40, 60, "right", 0, 1.0, 1.0)

	--local px = math.floor(math.floor(Players[self.id].positionX*100+0.5))
	--local py = math.floor(math.floor(Players[self.id].positionY*100+0.5))
	--love.graphics.setFont(VerySmallFont)
	--love.graphics.printf({{25/255, 255/255, 255/255, 1},string.format("%d", px)}, tx+46, ty+3.5-60, 60, "right", 0, 1.0, 1.0)
	--love.graphics.printf({{25/255, 255/255, 255/255, 1},string.format("%d", py)}, tx+46, ty+3.5-40, 60, "right", 0, 1.0, 1.0)
	love.graphics.pop()
--love.graphics.printf("I",118, 92,12, "center")
--love.graphics.printf("S",130, 92,12, "center")
--love.graphics.printf("W",118, 104,12, "center")
--love.graphics.printf("P",130, 104,12, "center")
end
