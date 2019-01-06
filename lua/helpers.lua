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

function GetPlayerHealthString(id)
	local healthstring = tostring(Players[id].HP) .. "/" .. tostring(Players[id].maxHP)
	if Players[id].status == "Dead" or Players[id].status == "Down" or Players[id].status == "Zombie" then
		return Players[id].status
	else
		return healthstring 
	end
end

function GetStatusColor(id)
	if Players[id].status == "Poison" then
		return {1, 0, 1, 1}
	elseif Players[id].status == "Bleed" then
		return {1, 0, 0, 1}
	elseif Players[id].status == "Poison+Bleed" then
		return {0, 1, 1, 1}
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

function Time2string(x)
	local h = math.floor(((x / (3600000)) % 24))
	local m = math.floor((x / (60000)) % 60)
	local s = math.floor((x / 1000) % 60)
	local mi = math.floor(x % 1000 / 10)
	return string.format("%02d", h) .. ":" .. string.format("%02d", m) .. ":" .. string.format("%02d", s) .. "." .. string.format("%2.2d", mi)
end