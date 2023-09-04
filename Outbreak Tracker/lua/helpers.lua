function GetHealthbar(hp, hpmax)
	local percent = hp / hpmax
	if (percent > 1) then
		return 0
	end
	if (percent == 1) then
		return 1
	end
	if (percent >= 0.95) then
		return 0.95
	end
	if (percent >= 0.90) then
		return 0.90
	end
	if (percent >= 0.85) then
		return 0.85
	end
	if (percent >= 0.80) then
		return 0.80
	end
	if (percent >= 0.75) then
		return 0.75
	end
	if (percent >= 0.70) then
		return 0.70
	end
	if (percent >= 0.65) then
		return 0.65
	end
	if (percent >= 0.60) then
		return 0.65
	end
	if (percent >= 0.55) then
		return 0.55
	end
	if (percent >= 0.50) then
		return 0.50
	end
	if (percent >= 0.45) then
		return 0.45
	end
	if (percent >= 0.40) then
		return 0.40
	end
	if (percent >= 0.35) then
		return 0.35
	end
	if (percent >= 0.30) then
		return 0.30
	end
	if (percent >= 0.25) then
		return 0.25
	end
	if (percent >= 0.20) then
		return 0.20
	end
	if (percent >= 0.15) then
		return 0.15
	end
	if (percent >= 0.10) then
		return 0.10
	end
	if (percent >= 0.05) then
		return 0.05
	end
	if (percent > 0) then
		return 0.05
	end
	if (percent == 0) then
		return 0
	end
	return 0
end

function GetConditionName(hp, hpmax)
	local percent = hp / hpmax
	if (percent >= 0.75) then
		return "fine"
	end
	if (percent >= 0.50) then
		return "caution"
	end
	if (percent >= 0.25) then
		return "caution2"
	end
	if (percent > 0) then
		return "danger"
	end
	if (percent == 0) then
		return "down"
	end
	return "down"
end

function GetConditionName2(hp, hpmax)
	local percent = hp / hpmax
	if (percent > 1) then
		return "dead"
	end
	if (percent >= 0.75) then
		return "fine"
	end
	if (percent >= 0.50) then
		return "caution"
	end
	if (percent >= 0.25) then
		return "caution2"
	end
	if (percent > 0) then
		return "danger"
	end
	if (percent == 0) then
		return "dead"
	end
	return "dead"
end

function GetConditionColor(r, stat)
	if (r == "fine") then
		return {68/255, 134/255, 10/255, 0.5}
	elseif (r == "caution") then
		return {247/255, 223/255, 27/255, 0.5}
	elseif (r == "caution2") then
		return {253/255, 166/255, 25/255, 0.5}
	elseif (r == "danger") then
		return {253/255, 25/255, 25/255, 0.5}
	elseif (r == "down") then
		return {150/255, 15/255, 15/255, 0.5}
	end
end

function GetConditionColor2(r, stat)
	if (r == "fine") then
		return {68/255, 134/255, 10/255, 0.5}
	elseif (r == "caution") then
		return {247/255, 223/255, 27/255, 0.5}
	elseif (r == "caution2") then
		return {253/255, 166/255, 25/255, 0.5}
	elseif (r == "danger") then
		return {253/255, 25/255, 25/255, 0.5}
	elseif (r == "dead") then
		return {0/255, 0/255, 0/255, 0.5}
	elseif (r == "Invincible") then
		return {0/255, 0/255, 0/255, 0.5}
	end
end

function GetConditionColor3(r, stat)
	if (r == "fine") then
		return {109/255, 131/255, 227/255, 1}
	elseif (r == "caution") then
		return {247/255, 223/255, 27/255, 0.75}
	elseif (r == "caution2") then
		return {253/255, 166/255, 25/255, 0.75}
	elseif (r == "danger") then
		return {253/255, 25/255, 25/255, 0.75}
	elseif (r == "dead") then
		return {0/255, 0/255, 0/255, 0.5}
	elseif (r == "Invincible") then
		return {0/255, 0/255, 0/255, 0.5}
	end
end

function GetRoomName(scenario, roomID)
	if not (RoomNames[scenario] == nil) then
		if RoomNames[scenario][roomID] == nil then
			return "Room ID: " .. tostring(roomID)
		else
			return RoomNames[scenario][roomID]
		end
	else
		return "ERROR: Unknown scenario"
	end
end

function GetRoomName_j(scenario, roomID)
	if not (RoomNames_j[scenario] == nil) then
		if RoomNames_j[scenario][roomID] == nil then
			return "Room ID: " .. tostring(roomID)
		else
			return RoomNames_j[scenario][roomID]
		end
	else
		return "ERROR: Unknown scenario"
	end
end

function GetScenarioIDString(id)
	local scenariostring = "\n"..tostring(Slots[id].slotscenario)
	if Slots[id].status ==3 or Slots[id].status ==4 then
		return scenariostring
	elseif Slots[id].status ==1 or Slots[id].status ==2 then
		return "(free)\n"
	else
		return ""
	end
end

function GetVersionString(id)
	local vesionstring = tostring(Slots[id].version)
	if Slots[id].version ==0x11 then
		return "DVD-ROM"
	elseif Slots[id].version ==0x12 then
		return "HDD-ROM"
	else
		return ""
	end
end

function GetSlotString(id)
	local slotstring = tostring(Slots[id].num)
		return slotstring
end

function GetPlayerString(id)
	local playerstring = tostring(Slots[id].player) .. "/" .. tostring(Slots[id].maxplayer)
	if Slots[id].status ==0 then
		return "-/-P\nBusy"--red color
	elseif Slots[id].status ==1 then
		return "-/-P\nVacant"
	elseif Slots[id].status ==2 then
		return "-/-P\nBusy"--yellow color
	elseif Slots[id].status ==3 then
		return tostring(Slots[id].player) .. "/" .. tostring(Slots[id].maxplayer).."\nJoin in"--white color
	elseif Slots[id].status ==4 then
		return tostring(Slots[id].player) .. "/" .. tostring(Slots[id].maxplayer).."\nFull"--pink color
	else
		return playerstring
	end
end

function GetPlayerHealthString(id)
	local healthstring = tostring(Players[id].HP) .. "/" .. tostring(Players[id].maxHP)
	if Players[id].status == "Dead" or Players[id].status == "Down" or Players[id].status == "Zombie" then
		return Players[id].status
	elseif Players[id].status == "Gas" then
		return Players[id].HP .. "  " .. Time2string3(GameInfo.gastime)
	elseif Players[id].status == "Down+Gas" then
		return "Down"
	elseif Players[id].status == "Cleared" then
		return "Cleared"
	--elseif Players[id].vgstoptime >0 then
	--	return Players[id].HP .. "  " .. Time2string3(Players[id].vgstoptime)
	else
		return healthstring
	end
end

function GetEnemiesHealthString2(id)
	local healthstring = tostring(Enemies2[id].HP)
	if Enemies2[id].HP == 0x7fff
	or Enemies2[id].nameID == 11
	or Enemies2[id].nameID == 12
	or Enemies2[id].nameID == 14
	or Enemies2[id].nameID == 26
	or Enemies2[id].nameID == 34
	or Enemies2[id].nameID == 56 then
		return "Inv."
	elseif (Enemies2[id].HP == 0x0
	or Enemies2[id].HP == 0xffff
	or Enemies2[id].HP >= 0x8000)
	and not (Enemies2[id].nameID == 54
	or Enemies2[id].nameID == 58) then
		return "Dead"
	elseif (Enemies2[id].HP == 0xffff
	and Enemies2[id].maxHP == 0x1
	and Enemies2[id].nameID == 54) then
		return "Destroyed"
	elseif (Enemies2[id].HP == 0x0
	and Enemies2[id].nameID == 58) then
		return "Exploded"
	else
		return healthstring 
	end
end

function GetBossHealthString(id)
	local healthstring = tostring(Boss[id].HP)
	if Boss[id].HP == 0x7fff
	or Boss[id].nameID == 11
	or Boss[id].nameID == 12
	or Boss[id].nameID == 14
	or Boss[id].nameID == 26
	or Boss[id].nameID == 34
	or Boss[id].nameID == 56 then
		return "Inv."
	elseif (Boss[id].HP == 0x0
	or Boss[id].HP == 0xffff
	or Boss[id].HP >= 0x8000)
	and not (Boss[id].nameID == 54
	or Boss[id].nameID == 58) then
		return "Dead"
	elseif (Boss[id].HP == 0xffff
	and Boss[id].maxHP == 0x1
	and Boss[id].nameID == 54) then
		return "Destroyed"
	elseif (Boss[id].HP == 0x0
	and Boss[id].nameID == 58) then
		return "Exploded"
	else
		return healthstring 
	end
end

function GetEnemyHealthString(id)
	local healthstring = tostring(Enemies[id].HP) .. "/" .. tostring(Enemies[id].maxHP)
	if Enemies[id].HP == 0x7fff
	or Enemies[id].nameID == 11
	or Enemies[id].nameID == 12
	or Enemies[id].nameID == 14
	or Enemies[id].nameID == 26
	or Enemies[id].nameID == 34
	or Enemies[id].nameID == 56 then
		return "Invincible"
	elseif (Enemies[id].HP == 0x0
	or Enemies[id].HP == 0xffff
	or Enemies[id].HP >= 0x8000)
	and not (Enemies[id].nameID == 54
	or Enemies[id].nameID == 58) then
		return "Dead"
	elseif (Enemies[id].HP == 0xffff
	and Enemies[id].maxHP == 0x1
	and Enemies[id].nameID == 54) then
		return "Destroyed"
	elseif (Enemies[id].HP == 0x0
	and Enemies[id].nameID == 58) then
		return "Exploded"
	else
		return healthstring 
	end
end

function GetBossColor(id)
if Boss[id].nameID == 54
		or Boss[id].nameID == 58 
		or Boss[id].nameID == 60 then
		return {255/255, 80/255, 40/255, 1}
	elseif Boss[id].nameID == 4
		or Boss[id].nameID == 46
		or Boss[id].nameID == 61 then
		return {0, 1, 0, 1}--non enemy
	else
		return {1, 1, 1, 1}
	end
end

function GetEnemyColor(id)
if Enemies[id].nameID == 54
		or Enemies[id].nameID == 58 
		or Enemies[id].nameID == 60 then
		return {255/255, 80/255, 40/255, 1}
	elseif Enemies[id].nameID == 4
		or Enemies[id].nameID == 46
		or Enemies[id].nameID == 61 then
		return {0, 1, 0, 1}--non enemy
	else
		return {1, 1, 1, 1}
	end
end

function GetEnemyColor2(id)
if Enemies2[id].nameID == 54
		or Enemies2[id].nameID == 58 
		or Enemies2[id].nameID == 60 then
		return {255/255, 80/255, 40/255, 1}
	elseif Enemies2[id].nameID == 4
		or Enemies2[id].nameID == 46
		or Enemies2[id].nameID == 61 then
		return {0, 1, 0, 1}--non enemy
	else
		return {1, 1, 1, 1}
	end
end

function GetStatusColor(id)
	if Players[id].status == "Poison" then
		return {1, 0, 1, 1}
	elseif Players[id].status == "Bleed" then
		return {1, 0, 0, 1}
	elseif Players[id].status == "Poison+Bleed" then
		return {0, 1, 1, 1}
	elseif Players[id].status == "Gas" then
		return {1, 1, 0, 1}
	elseif Players[id].status == "Down+Gas" then
		return {1, 1, 0, 1}
	elseif Players[id].status == "Gas+Bleed" then
		return {1, 0.5, 0, 1}
	elseif Players[id].status == "Cleared" then
		return {0, 1, 0, 1}
	else
		return {1, 1, 1, 1}
	end
end

function GetSlotsColor(id)
	if Slots[id].status ==0 then
		return {1, 0, 0, 1}
	elseif Slots[id].status ==2 then
		return {1, 1, 0, 1}
	elseif Slots[id].status ==4 then
		return {1, 100/255, 240/255, 1}
	else
		return {1, 1, 1, 1}
	end
end

function GetVirusState(virus)
	if virus >= 90 then
		return "virus90"
	elseif virus >= 80 then
		return "virus80"
	elseif virus >= 50 then
		return "virus50"
	else
		return "virusOK"
	end
end

function RealTime(x)
	local h = math.floor(x / 3600)
	local m = math.floor((x / 60) % 60)
	local s = math.floor(x % 60)
	local mi = math.floor((x * 10)%10 / 1)
	return string.format("%02d", h) .. ":" .. string.format("%02d", m) .. ":" .. string.format("%02d", s) .. "." .. string.format("%.1d", mi)
end

function Time2string(x)
	local h = math.floor(((x / (3600000)) % 24))
	local m = math.floor((x / (60000)) % 60)
	local s = math.floor((x / 1000) % 60)
	local mi = math.floor(x % 1000 / 100)
	return string.format("%02d", h) .. ":" .. string.format("%02d", m) .. ":" .. string.format("%02d", s) .. "." .. string.format("%.1d", mi)
end

function Time2string2(x)
	local m = math.floor((x / (60)) % 60)
	local s = math.floor((x-60) % 60)
	return string.format("%02d", m) .. ":" .. string.format("%02d", s)
end

function Time2string3(x)
	local m = math.floor((x / (1800)) % 60)
	local s = math.floor((x / 30) % 60)
	return string.format("%02d", m) .. ":" .. string.format("%02d", s)
end

function Time2string4(x)--bleeding time
	local m = math.floor((x / (1800)) % 60)
	local s = math.floor((x / 30) % 60)
	return string.format("%0d", m) .. ":" .. string.format("%02d", s)
end

function Time2string5(x)--stopping virus time
	local m = math.floor((x / (3600)) % 60)
	local s = math.floor((x / 60) % 60)
	return string.format("%0d", m) .. ":" .. string.format("%02d", s)
end

function IsOuNumber(num)
	local num1= num%2
		return string.format(num1)
end