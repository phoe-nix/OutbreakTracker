#include <windows.h>
#include <tlhelp32.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <string.h>

#include "structs.h"
#include "F1Addr.h"
#include "F2Addr.h"

DWORD ProcessID = 0;
HANDLE ProcessHandle = 0;

GameInfo info;
Player Players[5];
Enemy Enemies[6];
Item Items[256];

int GetProcessID(char* processname)
{
	/* Successfully copy-pasted from random StackOverflow answer since I don't know how to work with Windows' crappy API.*/
	HANDLE hProcessSnap;
	PROCESSENTRY32 pe32;
	int result = 0;
	hProcessSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
	if (INVALID_HANDLE_VALUE == hProcessSnap) return(FALSE);
	pe32.dwSize = sizeof(PROCESSENTRY32);
	if (!Process32First(hProcessSnap, &pe32))
	{
	  CloseHandle(hProcessSnap);
	  return(0);
	}
	do
	{
	  if (0 == strcmp(processname, pe32.szExeFile))
	  {
	      result = pe32.th32ProcessID;
	      break;
	  }
	} while (Process32Next(hProcessSnap, &pe32));
	CloseHandle(hProcessSnap);
	return result;
}

char GetFile()
{
	/* Pretty crappy, but eh. */
    int bytesRead = 0;
    char f1;
    char f2;
    ReadProcessMemory(ProcessHandle, (PCVOID) 0x202321B3, &f1, 1, (PDWORD)&bytesRead);
    ReadProcessMemory(ProcessHandle, (PCVOID) 0x2023DFD3, &f2, 1, (PDWORD)&bytesRead);
    if (f1 == 0x53)
        return 1;
    else if (f2 == 0x53)
        return 2;
    else
        return -1;
}

unsigned short GetScenarioID()
{
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_ScenarioIDAddr, &buffer, 2, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_ScenarioIDAddr, &buffer, 2, (PDWORD) &bytesRead);
	return buffer;
}

unsigned int GetFrames()
{
	unsigned int buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_FrameCounter, &buffer, 4, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_FrameCounter, &buffer, 4, (PDWORD) &bytesRead);
	return buffer;
}

unsigned char GetP1Coins()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_Coin, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}

unsigned char GetP2Coins()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_Coin+2, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}

unsigned char GetP3Coins()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_Coin+4, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}

unsigned char GetP4Coins()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_Coin+6, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}

unsigned char GetKilledZombies()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_KilledZombie, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}

unsigned int GetE1HP()//enemy HP
{
	unsigned int Pointer;
	unsigned  buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	{
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_Pointer, &Pointer,4,0);
	    ReadProcessMemory(ProcessHandle, (PCVOID)Pointer+0x20000000 + F1_EHPOffset, &buffer, 2, (PDWORD) &bytesRead);
	}
	else
	{
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_Pointer, &Pointer,4,0);
		ReadProcessMemory(ProcessHandle, (PCVOID)Pointer+0x20000000 + F2_EHPOffset, &buffer, 2, (PDWORD)&bytesRead);
	}
	return buffer;
}

unsigned int GetE2HP()//enemy HP
{
	unsigned int Pointer;
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	{
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_Pointer-4, &Pointer,4,0);
	    ReadProcessMemory(ProcessHandle, (PCVOID)Pointer+0x20000000 + F1_EHPOffset, &buffer, 2, (PDWORD) &bytesRead);
	}
	else
	{
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_Pointer-4, &Pointer,4,0);
		ReadProcessMemory(ProcessHandle, (PCVOID)Pointer+0x20000000 + F2_EHPOffset, &buffer, 2, (PDWORD)&bytesRead);
	}
	return buffer;
}

unsigned int GetE3HP()//enemy HP
{
	unsigned int Pointer;
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	{
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_Pointer-8, &Pointer,4,0);
	    ReadProcessMemory(ProcessHandle, (PCVOID)Pointer+0x20000000 + F1_EHPOffset, &buffer, 2, (PDWORD) &bytesRead);
	}
	else
	{
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_Pointer-8, &Pointer,4,0);
		ReadProcessMemory(ProcessHandle, (PCVOID)Pointer+0x20000000 + F2_EHPOffset, &buffer, 2, (PDWORD)&bytesRead);
	}
	return buffer;
}

unsigned int GetE4HP()//enemy HP
{
	unsigned int Pointer;
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	{
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_Pointer-12, &Pointer,4,0);
	    ReadProcessMemory(ProcessHandle, (PCVOID)Pointer+0x20000000 + F1_EHPOffset, &buffer, 2, (PDWORD) &bytesRead);
	}
	else
	{
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_Pointer-12, &Pointer,4,0);
		ReadProcessMemory(ProcessHandle, (PCVOID)Pointer+0x20000000 + F2_EHPOffset, &buffer, 2, (PDWORD)&bytesRead);
	}
	return buffer;
}

void UpdatePickups()
{
    for (int i=0; i < 255; i++)
    {
        unsigned short typeBuffer;
        unsigned short countBuffer;
        int bytesRead = 0;
        if (info.CurrentFile == 1)
        {
            ReadProcessMemory(ProcessHandle, (PCVOID)F1_PickupSpaceStart + (F1_PickupStructSize * i), &typeBuffer, 2, (PDWORD)&bytesRead);
            ReadProcessMemory(ProcessHandle, (PCVOID)F1_PickupSpaceStart + (F1_PickupStructSize * i) + F1_PickupCountOffset, &countBuffer, 2, (PDWORD)&bytesRead);
        }
        else if (info.CurrentFile == 2)
        {
            ReadProcessMemory(ProcessHandle, (PCVOID)F2_PickupSpaceStart + (F2_PickupStructSize * i), &typeBuffer, 2, (PDWORD)&bytesRead);
            ReadProcessMemory(ProcessHandle, (PCVOID)F2_PickupSpaceStart + (F2_PickupStructSize * i) + F2_PickupCountOffset, &countBuffer, 2, (PDWORD)&bytesRead);
        }
        Items[i].ID = i+1;
        Items[i].Type = typeBuffer;
        Items[i].Count = countBuffer;
    }
}

unsigned short GetRoomID(int characterID)
{
  unsigned short buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_RoomIDOffset, &buffer, 2, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_RoomIDOffset, &buffer, 2, (PDWORD)&bytesRead);
  return buffer;
}

unsigned short GetHealth(int characterID)
{
  unsigned short buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_HPOffset, &buffer, 2, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_HPOffset, &buffer, 2, (PDWORD)&bytesRead);
  return buffer;
}

unsigned short GetMaxHealth(int characterID)
{
  unsigned short buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_MaxHPOffset, &buffer, 2, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_MaxHPOffset, &buffer, 2, (PDWORD)&bytesRead);
  return buffer;
}

char GetCharacterType(int characterID)
{
	char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_CharacterTypeOffset, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_CharacterTypeOffset, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

char* GetInventory(int characterID)
{
	char* buffer = malloc(4);
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_InventoryOffset, buffer, 4, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_InventoryOffset, buffer, 4, (PDWORD)&bytesRead);
	return buffer;
}

char GetSpecialItem(int characterID)
{
	char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_InventoryOffset + 4, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_InventoryOffset + 4, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

char* GetSpecialInventory(int characterID)
{
	char* buffer = malloc(4);
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_InventoryOffset + 5, buffer, 4, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_InventoryOffset + 5, buffer, 4, (PDWORD)&bytesRead);
	return buffer;
}

char* GetDeadInventory(int characterID)
{
	char* buffer = malloc(4);
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_DeadInventoryStart + 8*characterID, buffer, 4, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_DeadInventoryStart + 8*characterID, buffer, 4, (PDWORD)&bytesRead);
	return buffer;
}

char* GetDeadSpecialInventory(int characterID)
{
	char* buffer = malloc(4);
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_DeadInventoryStart + 8*characterID + 4, buffer, 4, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_DeadInventoryStart + 8*characterID + 4, buffer, 4, (PDWORD)&bytesRead);
	return buffer;
}

void GetCindyBag(int cid)
{
	if (Players[cid].CharacterType == 7)
	{
		unsigned char* buffer = malloc(36);
		int bytesRead = 0;
		if (info.CurrentFile == 1)
			ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(cid) + F1_InventoryOffset + 5, buffer, 36, (PDWORD)&bytesRead);
		else
			ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(cid) + F2_InventoryOffset + 5, buffer, 36, (PDWORD)&bytesRead);
		
		/* Warning! Unexplainable magic below! */
		for (int i=0; i < 4; i++)
		{
			unsigned char* ptr = buffer+i*9;
			Players[cid].CindyBag[i].ID = *ptr;
			if ((*ptr) != 0x00)
			{
				if (i != 3)
				{
					Players[cid].CindyBag[i].Count = 0;
					for (int j=0; j < 9; j++)
					{
						if (*(ptr+j) != 0x00)
						{
							Players[cid].CindyBag[i].Type = Items[*(ptr+j)-1].Type;
							Players[cid].CindyBag[i].Count += Items[*(ptr+j)-1].Count;
						}
					}
				}
				else
				{
					Players[cid].CindyBag[i].Type = Items[(*ptr)-1].Type;
					Players[cid].CindyBag[i].Count = 1;
				}
			}
		}

		free(buffer);
		buffer = NULL;
	}
}


double GetPercentage(int characterID)
{
	int currentBuffer;
	int maxBuffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	{
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_VirusOffset, &currentBuffer, 4, (PDWORD)&bytesRead);
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_VirusMaxStart + 4 * Players[characterID].CharacterType, &maxBuffer, 4, (PDWORD)&bytesRead);
	}
	else
	{
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_VirusOffset, &currentBuffer, 4, (PDWORD)&bytesRead);
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_VirusMaxStart + 4 * Players[characterID].CharacterType, &maxBuffer, 4, (PDWORD)&bytesRead);
	}

	return (double)currentBuffer/(double)maxBuffer*100.0;
}

double GetCritBonus(int characterID)
{
	float buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_CritBonusOffset, &buffer, 4, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_CritBonusOffset, &buffer, 4, (PDWORD)&bytesRead);
	return (double)buffer;
}

char GetNameID(int characterID)
{
    char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_NameTypeOffset, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_NameTypeOffset, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

char GetEquippedItem(int characterID)
{
    char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_EquippedItemOffset, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_EquippedItemOffset, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

char GetCharacterStatus(int characterID)
{
    char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_CharacterStatusOffset, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_CharacterStatusOffset, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

char GetCharacterEnabled(int characterID)
{
    char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_CharacterEnabled, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_CharacterEnabled, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

char GetCharacterInGame(int characterID)
{
    char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_CharacterInGame, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_CharacterInGame, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

char GetEnemyNameID(int enemyID)
{
    char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetEnemyAddress(enemyID) + F1_EnemyNameIDOffset, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetEnemyAddress(enemyID) + F2_EnemyNameIDOffset, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

char GetEnemyType(int enemyID)
{
	char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetEnemyAddress(enemyID) + F1_EnemyTypeOffset, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetEnemyAddress(enemyID) + F2_EnemyTypeOffset, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

unsigned short GetEnemyHealth(int enemyID)
{
  unsigned short buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetEnemyAddress(enemyID) + F1_EHPOffset, &buffer, 2, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetEnemyAddress(enemyID) + F2_EHPOffset, &buffer, 2, (PDWORD)&bytesRead);
  return buffer;
}

unsigned short GetEnemyMaxHealth(int enemyID)
{
  unsigned short buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetEnemyAddress(enemyID) + F1_EMaxHPOffset, &buffer, 2, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetEnemyAddress(enemyID) + F2_EMaxHPOffset, &buffer, 2, (PDWORD)&bytesRead);
  return buffer;
}

char GetEnemyEnabled(int enemyID)
{
    char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetEnemyAddress(enemyID) + F1_EnemyEnabled, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetEnemyAddress(enemyID) + F2_EnemyEnabled, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

char GetEnemyInGame(int enemyID)
{
    char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetEnemyAddress(enemyID) + F1_EnemyInGame, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetEnemyAddress(enemyID) + F2_EnemyInGame, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

char* GetStatusText(unsigned char stat)
{
	if (stat == 0x01)
		return "Poison";
	else if (stat == 0x02)
		return "Bleed";
	else if (stat == 0x03)
		return "Poison+Bleed";
	else if (stat == 0x00)
		return "OK";

	if (info.CurrentFile == 1)
	    if (stat >= 0x80)
			return "Zombie";
	    else if (stat >= 0x18 && stat <= 0x1C)
	        return "Down";
	    else if (stat > 0x1C)
	        return "Dead";
	if (info.CurrentFile == 2)
	    if (stat >= 0x30 && stat <= 0x34)
	        return "Zombie";
	    else if (stat >= 0x08 && stat <= 0x0C)
	        return "Down";
	    else if (stat > 0x0C)
	        return "Dead";

	return "unknown";
}

static int LInit (lua_State* L) {
	ProcessID = GetProcessID("pcsx2.exe");
	if (ProcessID != 0)
	{
		ProcessHandle = OpenProcess(PROCESS_VM_READ, FALSE, ProcessID);
		lua_pushboolean(L, 1);
	}
	else
		lua_pushboolean(L, 0);
	return 1;
}

static int LUpdate (lua_State* L)
{
	info.CurrentFile = GetFile();
	if (info.CurrentFile == -1)
		return 0;
	info.ScenarioID = GetScenarioID();
	info.FrameCounter = GetFrames();
	info.P1Coin = GetP1Coins();
	info.P2Coin = GetP2Coins();
	info.P3Coin = GetP3Coins();
	info.P4Coin = GetP4Coins();
	info.KilledZombie = GetKilledZombies();
	//info.E1Start = GetE1HP();//enemy1 HP
	//info.E2Start = GetE2HP();//enemy2 HP
	//info.E3Start = GetE3HP();//enemy3 HP
	//info.E4Start = GetE4HP();//enemy4 HP
	UpdatePickups();
	for (int i=0; i < 4; i++)
	{
		Players[i].Enabled = GetCharacterEnabled(i);
		if (Players[i].Enabled == 0)
			continue;
		Players[i].InGame = GetCharacterInGame(i);
		Players[i].HP = GetHealth(i);
		Players[i].MaxHP = GetMaxHealth(i);
		Players[i].CharacterType = GetCharacterType(i);
		Players[i].NameID = GetNameID(i);
		Players[i].Virus = GetPercentage(i);
		Players[i].RoomID = GetRoomID(i);
		Players[i].SpecialItem = GetSpecialItem(i);
		Players[i].EquippedItem = GetEquippedItem(i);
		Players[i].Status = GetCharacterStatus(i);
		Players[i].CritBonus = GetCritBonus(i);
		GetCindyBag(i);

		char* inv = GetInventory(i);
		char* spinv = GetSpecialInventory(i);
		char* dinv = GetDeadInventory(i);
		char* dspinv = GetDeadSpecialInventory(i);
		memcpy(Players[i].Inventory, inv, 4);
		memcpy(Players[i].SpecialInventory, spinv, 4);
		memcpy(Players[i].DeadInventory, dinv, 4);
		memcpy(Players[i].DeadInventorySpecial, dspinv, 4);
		free(inv);
		free(spinv);
		free(dinv);
		free(dspinv);
		inv = NULL;
		spinv = NULL;
		dinv = NULL;
		dspinv = NULL;
	}
	for (int i=0; i < 6; i++)
	{
		Enemies[i].Enabled = GetEnemyEnabled(i);
		if (Enemies[i].Enabled == 0)
			continue;
		Enemies[i].InGame = GetEnemyInGame(i);
		Enemies[i].HP = GetEnemyHealth(i);
		Enemies[i].MaxHP = GetEnemyMaxHealth(i);
		Enemies[i].EnemyType = GetEnemyType(i);
		Enemies[i].NameID = GetEnemyNameID(i);
	}
	return 0;
}

static int LGetPlayer (lua_State* L)
{
	double playerID = lua_tonumber(L, 1);
	int i = (int)(playerID-1);
	char* charname = GetCharacterName(Players[i].CharacterType);
	char* name = GetNPCName(Players[i].NameID);
	char* statname = GetStatusText(Players[i].Status);

	lua_newtable(L);

		lua_pushstring(L, "enabled");
			lua_pushboolean(L, Players[i].Enabled);
		lua_rawset(L, -3);

		lua_pushstring(L, "inGame");
			lua_pushboolean(L, Players[i].InGame);
		lua_rawset(L, -3);

		lua_pushstring(L, "HP");
			lua_pushnumber(L, (double)Players[i].HP);
		lua_rawset(L, -3);

		lua_pushstring(L, "maxHP");
			lua_pushnumber(L, (double)Players[i].MaxHP);
		lua_rawset(L, -3);

		lua_pushstring(L, "type");
			lua_pushstring(L, charname);
		lua_rawset(L, -3);

		lua_pushstring(L, "virus");
			lua_pushnumber(L, Players[i].Virus);
		lua_rawset(L, -3);

		lua_pushstring(L, "critBonus");
			lua_pushnumber(L, Players[i].CritBonus);
		lua_rawset(L, -3);

		lua_pushstring(L, "roomID");
			lua_pushnumber(L, (double)Players[i].RoomID);
		lua_rawset(L, -3);

		lua_pushstring(L, "status");
			lua_pushstring(L, statname);
		lua_rawset(L, -3);

		lua_pushstring(L, "name");
			if (name == NULL)
				lua_pushstring(L, charname);
			else
				lua_pushstring(L, name);
		lua_rawset(L, -3);

		lua_pushstring(L, "inventory");
		lua_newtable(L);
			for (int j=0; j < 4; j++)
			{
				lua_pushnumber(L, (double)j+1);
				unsigned char id;
				if (strcmp(statname, "Dead") == 0 || strcmp(statname, "Zombie") == 0)
					id = Players[i].DeadInventory[j];
				else
					id = Players[i].Inventory[j];
				if (id == 0x00)
				{
					CreateEmptyItemTable
				}
				else
				{
					CreateItemTable(Items[id-1]);
				}
			}
		lua_rawset(L, -3);

		lua_pushstring(L, "specialItem");
		if (Players[i].SpecialItem == 0x00)
		{
			CreateEmptyItemTable
		}
		else
		{
			CreateItemTable(Items[Players[i].SpecialItem-1])
		}

		lua_pushstring(L, "specialInventory");
		lua_newtable(L);
		if (Players[i].CharacterType == 7) // if Cindy
			for (int j=0; j < 4; j++)
			{
				lua_pushnumber(L, (double)j+1);
				if (Players[i].CindyBag[j].ID == 0x00)
				{
					CreateEmptyItemTable
				}	
				else
				{
					CreateItemTable(Players[i].CindyBag[j]);
				}
			}
		else
			for (int j=0; j < 4; j++)
			{
				lua_pushnumber(L, (double)j+1);
				unsigned char id;
				if (strcmp(statname, "Dead") == 0 || strcmp(statname, "Zombie") == 0)
					id = Players[i].DeadInventorySpecial[j];
				else
					id = Players[i].SpecialInventory[j];
				if (id == 0x00)
				{
					CreateEmptyItemTable
				}
				else
				{
					CreateItemTable(Items[id-1]);
				}
			}
		lua_rawset(L, -3);

		lua_pushstring(L, "equipped");
			lua_pushnumber(L, (double)Players[i].EquippedItem);
		lua_rawset(L, -3);

	return 1;
}
static int LGetEnemy (lua_State* L)
{
	double enemyID = lua_tonumber(L, 1);
	int i = (int)(enemyID-1);
	char* charname= GetEnemyName(Enemies[i].EnemyType);
	char* name = GetEnemyName2(Enemies[i].NameID);

	lua_newtable(L);

		lua_pushstring(L, "enabled");
			lua_pushboolean(L, Enemies[i].Enabled);
		lua_rawset(L, -3);

		lua_pushstring(L, "inGame");
			lua_pushboolean(L, Enemies[i].InGame);
		lua_rawset(L, -3);

		lua_pushstring(L, "HP");
			lua_pushnumber(L, (double)Enemies[i].HP);
		lua_rawset(L, -3);

		lua_pushstring(L, "maxHP");
			lua_pushnumber(L, (double)Enemies[i].MaxHP);
		lua_rawset(L, -3);

		lua_pushstring(L, "nameID");
			lua_pushnumber(L, (double)Enemies[i].NameID);
		lua_rawset(L, -3);

		lua_pushstring(L, "type");
			lua_pushstring(L, charname);
		lua_rawset(L, -3);

		lua_pushstring(L, "name");
			if (name == NULL)
				lua_pushstring(L, charname);
			else
				lua_pushstring(L, name);
		lua_rawset(L, -3);

	return 1;
}
static int LGetGameInfo (lua_State* L)
{
	lua_newtable(L);
		lua_pushstring(L, "currentFile");
			lua_pushnumber(L, (double)info.CurrentFile);
		lua_rawset(L, -3);
		lua_pushstring(L, "scenario");
			lua_pushstring(L, GetScenarioName(info.ScenarioID));
		lua_rawset(L, -3);
		lua_pushstring(L, "frames");
			lua_pushnumber(L, (double)info.FrameCounter);
		lua_rawset(L, -3);
		lua_pushstring(L, "p1coins");
			lua_pushnumber(L, (double)info.P1Coin);
		lua_rawset(L, -3);
		lua_pushstring(L, "p2coins");
			lua_pushnumber(L, (double)info.P2Coin);
		lua_rawset(L, -3);
		lua_pushstring(L, "p3coins");
			lua_pushnumber(L, (double)info.P3Coin);
		lua_rawset(L, -3);
		lua_pushstring(L, "p4coins");
			lua_pushnumber(L, (double)info.P4Coin);
		lua_rawset(L, -3);
		lua_pushstring(L, "killedzombies");
			lua_pushnumber(L, (double)info.KilledZombie);
		lua_rawset(L, -3);
		lua_pushstring(L, "E1HP");//enemy1 HP
			lua_pushnumber(L, (double)info.E1Start);
		lua_rawset(L, -3);
		lua_pushstring(L, "E2HP");//enemy2 HP
			lua_pushnumber(L, (double)info.E2Start);
		lua_rawset(L, -3);
		lua_pushstring(L, "E3HP");//enemy3 HP
			lua_pushnumber(L, (double)info.E3Start);
		lua_rawset(L, -3);
		lua_pushstring(L, "E4HP");//enemy4 HP
			lua_pushnumber(L, (double)info.E4Start);
		lua_rawset(L, -3);
	return 1;
}

static int LTestFunction (lua_State* L)
{
	lua_pushstring(L, "luaoutbreaktracker. Made by Fedor Vorobyev, aka \"Fothsid\"");
	return 1;
}

static const struct luaL_Reg library_functions [] = {
	{"init", LInit},
	{"update", LUpdate},
	{"getPlayer", LGetPlayer},
	{"getEnemy", LGetEnemy},
	{"getGameInfo", LGetGameInfo},
	{"about", LTestFunction},
	{NULL, NULL}
};

__declspec(dllexport) int luaopen_luaoutbreaktracker (lua_State *L){
	luaL_register(L, "tracker", library_functions);
	return 1;
}
