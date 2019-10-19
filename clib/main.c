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
Slot Slots[20];
RItem RItems[MAX_ITEM];
Player Players[4];
SPlayer SPlayers[4];
Enemy Enemies[MAX_ENEMY];
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

unsigned short GetSlotNum(int slotNum)
{
  unsigned short buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetLobbyAddress(slotNum), &buffer, 2, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetLobbyAddress(slotNum), &buffer, 2, (PDWORD)&bytesRead);
  return buffer;
}

unsigned short GetSlotPlayer(int slotNum)
{
  unsigned short buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetLobbyAddress(slotNum) + F2_SlotPlayer, &buffer, 2, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetLobbyAddress(slotNum) + F2_SlotPlayer, &buffer, 2, (PDWORD)&bytesRead);
  return buffer;
}

unsigned short GetSlotMaxPlayer(int slotNum)
{
  unsigned short buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetLobbyAddress(slotNum) + F2_SlotMaxPlayer, &buffer, 2, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetLobbyAddress(slotNum) + F2_SlotMaxPlayer, &buffer, 2, (PDWORD)&bytesRead);
  return buffer;
}

unsigned char GetSlotStatus(int slotNum)
{
  unsigned char buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetLobbyAddress(slotNum) + F2_SlotStatus, &buffer, 1, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetLobbyAddress(slotNum) + F2_SlotStatus, &buffer, 1, (PDWORD)&bytesRead);
  return buffer;
}

unsigned char GetSlotPass(int slotNum)
{
  unsigned char buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetLobbyAddress(slotNum) + F2_SlotPass, &buffer, 1, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetLobbyAddress(slotNum) + F2_SlotPass, &buffer, 1, (PDWORD)&bytesRead);
  return buffer;
}

unsigned short GetSlotScenarioID(int slotNum)
{
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetLobbyAddress(slotNum) + F2_SlotScenarioID, &buffer, 2, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetLobbyAddress(slotNum) + F2_SlotScenarioID, &buffer, 2, (PDWORD) &bytesRead);
	return buffer;
}

unsigned short GetSlotVersion(int slotNum)
{
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetLobbyAddress(slotNum) + F2_SlotVersion, &buffer, 2, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetLobbyAddress(slotNum) + F2_SlotVersion, &buffer, 2, (PDWORD) &bytesRead);
	return buffer;
}

unsigned char GetHostStatus()
{
	unsigned char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_HostStatus, &buffer, 1, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_HostStatus, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}

unsigned short GetHostMaxPlayer()
{
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_HostMaxPlayer, &buffer, 2, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_HostMaxPlayer, &buffer, 2, (PDWORD) &bytesRead);
	return buffer;
}

unsigned short GetHostPlayer()
{
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_HostPlayer, &buffer, 2, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_HostPlayer, &buffer, 2, (PDWORD) &bytesRead);
	return buffer;
}

unsigned short GetHostTime()
{
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_HostTime, &buffer, 2, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_HostTime, &buffer, 2, (PDWORD) &bytesRead);
	return buffer;
}

unsigned short GetHostScenarioID()
{
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_HostScenarioID, &buffer, 2, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_HostScenarioID, &buffer, 2, (PDWORD) &bytesRead);
	return buffer;
}

unsigned short GetHostDifficulty()
{
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_HostDifficulty, &buffer, 2, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_HostDifficulty, &buffer, 2, (PDWORD) &bytesRead);
	return buffer;
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

unsigned int GetFightTime()
{
	unsigned int buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_DTFightTime, &buffer, 4, (PDWORD) &bytesRead);
	return buffer;
}

unsigned short GetFightTime2()
{
	unsigned short buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_DTFightTime2, &buffer, 2, (PDWORD) &bytesRead);
	return buffer;
}

unsigned int GetGarageTime()
{
	unsigned int buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_DTGarageTime, &buffer, 4, (PDWORD) &bytesRead);
	return buffer;
}

unsigned int GetGasTime()
{
	unsigned int buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_DTGasTime, &buffer, 4, (PDWORD) &bytesRead);
	return buffer;
}

unsigned int GetGasFlag()
{
	unsigned int buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_DTGasFlag, &buffer, 4, (PDWORD) &bytesRead);
	return buffer;
}

unsigned char GetGasRandom()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_DTGasRandom, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}

unsigned char GetItemRandom()
{
	unsigned char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_ItemRandom, &buffer, 1, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_ItemRandom, &buffer, 1, (PDWORD) &bytesRead);
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

unsigned char GetPass1()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_Pass1, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}

unsigned char GetPass2()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_Pass2, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}

unsigned char GetPass3()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_Pass3, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}

unsigned short GetPassUB1()
{
	unsigned short buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_PassUB1, &buffer, 2, (PDWORD) &bytesRead);
	return buffer;
}
unsigned char GetPassUB2()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_PassUB2, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}
unsigned short GetPass4()
{
	unsigned short buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_Pass4, &buffer, 2, (PDWORD) &bytesRead);
	else
	    ReadProcessMemory(ProcessHandle, (PCVOID) F2_Pass4, &buffer, 2, (PDWORD) &bytesRead);
	return buffer;
}
unsigned char GetPass5()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_Pass5, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}
unsigned char GetPass6()
{
	unsigned char buffer;
	int bytesRead = 0;
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_Pass6, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}
unsigned char GetDifficulty()
{
	unsigned char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
	    ReadProcessMemory(ProcessHandle, (PCVOID) F1_Difficulty, &buffer, 1, (PDWORD) &bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID) F2_Difficulty, &buffer, 1, (PDWORD) &bytesRead);
	return buffer;
}
/*
unsigned int GetE1HP()//enemy HP
{
	unsigned int Pointer;
	unsigned short buffer;
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
*/
void UpdatePickups()
{
    for (int i=0; i < 255; i++)
    {
        unsigned short typeBuffer;
        unsigned short countBuffer;
        unsigned short pickBuffer;
        unsigned int presentBuffer;
        unsigned char mixBuffer;
        int bytesRead = 0;
        if (info.CurrentFile == 1)
        {
            ReadProcessMemory(ProcessHandle, (PCVOID)F1_PickupSpaceStart + (F1_PickupStructSize * i), &typeBuffer, 2, (PDWORD)&bytesRead);
            ReadProcessMemory(ProcessHandle, (PCVOID)F1_PickupSpaceStart + (F1_PickupStructSize * i) + F1_PickupCountOffset, &countBuffer, 2, (PDWORD)&bytesRead);
            ReadProcessMemory(ProcessHandle, (PCVOID)F1_PickupSpaceStart + (F1_PickupStructSize * i) + F1_PickupOffset, &pickBuffer, 2, (PDWORD)&bytesRead);
            ReadProcessMemory(ProcessHandle, (PCVOID)F2_PickupSpaceStart + (F2_PickupStructSize * i) + F1_PresentOffset, &presentBuffer, 4, (PDWORD)&bytesRead);
            ReadProcessMemory(ProcessHandle, (PCVOID)F1_PickupSpaceStart + (F1_PickupStructSize * i) + F1_MixOffset, &mixBuffer, 1, (PDWORD)&bytesRead);
        }
        else if (info.CurrentFile == 2)
        {
            ReadProcessMemory(ProcessHandle, (PCVOID)F2_PickupSpaceStart + (F2_PickupStructSize * i), &typeBuffer, 2, (PDWORD)&bytesRead);
            ReadProcessMemory(ProcessHandle, (PCVOID)F2_PickupSpaceStart + (F2_PickupStructSize * i) + F2_PickupCountOffset, &countBuffer, 2, (PDWORD)&bytesRead);
            ReadProcessMemory(ProcessHandle, (PCVOID)F2_PickupSpaceStart + (F2_PickupStructSize * i) + F2_PickupOffset, &pickBuffer, 2, (PDWORD)&bytesRead);
            ReadProcessMemory(ProcessHandle, (PCVOID)F2_PickupSpaceStart + (F2_PickupStructSize * i) + F2_PresentOffset, &presentBuffer, 4, (PDWORD)&bytesRead);
            ReadProcessMemory(ProcessHandle, (PCVOID)F2_PickupSpaceStart + (F2_PickupStructSize * i) + F2_MixOffset, &mixBuffer, 1, (PDWORD)&bytesRead);
        }
        Items[i].ID = i+1;
        Items[i].Type = typeBuffer;
        Items[i].Count = countBuffer;
        Items[i].Pick = pickBuffer;
        Items[i].Present = presentBuffer;
        Items[i].Mix = mixBuffer;
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


void GetRoomItemF1(int cid)
{
		unsigned int Pointer;
		unsigned char* buffer = malloc(196*MAX_ITEM);
		int bytesRead = 0;

		ReadProcessMemory(ProcessHandle, (PCVOID)F1_RoomItem, &Pointer,4,0);
		ReadProcessMemory(ProcessHandle, (PCVOID)Pointer+0x20000000+0x40-(196*MAX_ITEM/2), buffer, 196*MAX_ITEM, (PDWORD)&bytesRead);

		/* Warning! Unexplainable magic below! */
		for (int i=0; i < MAX_ITEM; i++)
		{
			unsigned char* ptr = buffer+i*196;
			char* ptr2 = buffer+10+i*196;
			RItems[cid].RItem[i].ID = *ptr;
			RItems[cid].RItem[i].EN = *ptr2;
			if ((*ptr) != 0x00)
			{
				RItems[cid].RItem[i].Count = 0;
				RItems[cid].RItem[i].Pick = 0;
				RItems[cid].RItem[i].Present = 0;
				RItems[cid].RItem[i].Mix = 0;
				for (int j=0; j < 1; j++)
				{
					if (*(ptr+j) != 0x00)
					{
						RItems[cid].RItem[i].Type = Items[*(ptr+j)-1].Type;
						RItems[cid].RItem[i].Count = Items[*(ptr+j)-1].Count;
						RItems[cid].RItem[i].Pick = Items[*(ptr+j)-1].Pick;
						RItems[cid].RItem[i].Present = Items[*(ptr+j)-1].Present;
						RItems[cid].RItem[i].Mix = Items[*(ptr+j)-1].Mix;
					}
				}
			}
		}

		free(buffer);
		buffer = NULL;
}

void GetRoomItemF2(int cid)
{
		unsigned int Pointer;
		unsigned int Pointer2;
		unsigned char* buffer = malloc(192*MAX_ITEM);
		int bytesRead = 0;

		ReadProcessMemory(ProcessHandle, (PCVOID)F2_RoomItem, &Pointer,4,0);//24AF48
		ReadProcessMemory(ProcessHandle, (PCVOID)Pointer+0x20000000+0x40-(192*MAX_ITEM/2), buffer, 192*MAX_ITEM, (PDWORD)&bytesRead);

		/* Warning! Unexplainable magic below! */
		for (int i=0; i < MAX_ITEM; i++)
		{
			unsigned char* ptr = buffer+(i)*192;
			char* ptr2 = buffer+10+(i)*192;
			RItems[cid].RItem[i].ID = *ptr;
			RItems[cid].RItem[i].EN = *ptr2;
			if ((*ptr) != 0x00)
			{
				RItems[cid].RItem[i].Count = 0;
				RItems[cid].RItem[i].Pick = 0;
				RItems[cid].RItem[i].Present = 0;
				RItems[cid].RItem[i].Mix = 0;
				for (int j=0; j < 1; j++)
				{
					if (*(ptr+j) != 0x00)
					{
						RItems[cid].RItem[i].Type = Items[*(ptr+j)-1].Type;
						RItems[cid].RItem[i].Count = Items[*(ptr+j)-1].Count;
						RItems[cid].RItem[i].Pick = Items[*(ptr+j)-1].Pick;
						RItems[cid].RItem[i].Present = Items[*(ptr+j)-1].Present;
						RItems[cid].RItem[i].Mix = Items[*(ptr+j)-1].Mix;
					}
				}
			}
		}

		free(buffer);
		buffer = NULL;
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

double GetSize(int characterID)
{
  float buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_SizeOffset, &buffer, 4, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_SizeOffset, &buffer, 4, (PDWORD)&bytesRead);
  return (double)buffer;
}

double GetPower(int characterID)
{
  float buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_PowerOffset, &buffer, 4, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_PowerOffset, &buffer, 4, (PDWORD)&bytesRead);
  return (double)buffer;
}

double GetSpeed(int characterID)
{
  float buffer;
  int bytesRead = 0;
  if (info.CurrentFile == 1)
      ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetCharAddress(characterID) + F1_SpeedOffset, &buffer, 4, (PDWORD)&bytesRead);
  else
      ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetCharAddress(characterID) + F2_SpeedOffset, &buffer, 4, (PDWORD)&bytesRead);
  return (double)buffer;
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
/* slot player enable */
char GetSlotCharacterEnabled(int characterID)
{
    char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetSlotCharAddress(characterID), &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetSlotCharAddress(characterID) + 6, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}

/* 0=main char 1=npc */
char GetSlotNPCType(int characterID)
{
	char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetSlotCharAddress(characterID) + 230, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetSlotCharAddress(characterID) + 2, &buffer, 1, (PDWORD)&bytesRead);
	return buffer;
}
/* slot player name */
char GetSlotNameID(int characterID)
{
    char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_GetSlotCharAddress(characterID) + 228, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_GetSlotCharAddress(characterID), &buffer, 1, (PDWORD)&bytesRead);
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

char GetPlayerNum()
{
    unsigned char buffer;
	int bytesRead = 0;
	if (info.CurrentFile == 1)
		ReadProcessMemory(ProcessHandle, (PCVOID)F1_PlayerNum, &buffer, 1, (PDWORD)&bytesRead);
	else
		ReadProcessMemory(ProcessHandle, (PCVOID)F2_PlayerNum, &buffer, 1, (PDWORD)&bytesRead);
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
	else if (stat == 0x04)
		return "Gas";
	else if (stat == 0x06)
		return "Gas+Bleed";
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

static int LUpdateLobby (lua_State* L)
{
	info.CurrentFile = GetFile();
	if (info.CurrentFile == -1)
		return 0;
	info.HostStatus = GetHostStatus();
	info.HostTime = GetHostTime();
	info.HostMaxPlayer = GetHostMaxPlayer();
	info.HostPlayer = GetHostPlayer();
	info.HostScenarioID = GetHostScenarioID();
	info.HostDifficulty = GetHostDifficulty();
	for (int i=0; i < 20; i++)
	{
		//Slots[i].Enabled = GetLobbySlotStatus(i);
		//if (Slots[i].Enabled == 0)
		//	continue;
		Slots[i].SlotNum = GetSlotNum(i);
		Slots[i].Status = GetSlotStatus(i);
		Slots[i].Pass = GetSlotPass(i);
		Slots[i].Player = GetSlotPlayer(i);
		Slots[i].MaxPlayer = GetSlotMaxPlayer(i);
		Slots[i].ScenarioID = GetSlotScenarioID(i);
		Slots[i].Version = GetSlotVersion(i);
	}
	return 0;
}

static int LUpdateSlotPlayer (lua_State* L)
{
	info.CurrentFile = GetFile();
	if (info.CurrentFile == -1)
		return 0;

	for (int i=0; i < 4; i++)
	{
		SPlayers[i].Enabled = GetSlotCharacterEnabled(i);
		if (SPlayers[i].Enabled == 0)
			continue;
		//SPlayers[i].InGame = GetCharacterInGame(i);
		SPlayers[i].NPCType = GetSlotNPCType(i);
		SPlayers[i].NameID = GetSlotNameID(i);
	}
	return 0;
}
static int LUpdateItem (lua_State* L)
{
	info.CurrentFile = GetFile();
	if (info.CurrentFile == -1)
		return 0;
	for (int i=0; i < MAX_ITEM; i++)
	{
		if (info.CurrentFile == 1)
			GetRoomItemF1(i);
		else
			GetRoomItemF2(i);
		//char* inv = GetInventory(i);
		//char* spinv = GetSpecialInventory(i);
		//char* dinv = GetDeadInventory(i);
		//char* dspinv = GetDeadSpecialInventory(i);
		//memcpy(RItems[i].Inventory, inv, 4);
		//memcpy(RItems[i].SpecialInventory, spinv, 8);
		//memcpy(RItems[i].DeadInventory, dinv, 4);
		//memcpy(RItems[i].DeadInventorySpecial, dspinv, 4);
		//free(inv);
		//free(spinv);
		//free(dinv);
		//free(dspinv);
		//inv = NULL;
		//spinv = NULL;
		//dinv = NULL;
		//dspinv = NULL;
	}
	return 0;
}

static int LUpdatePlayer (lua_State* L)
{
	info.CurrentFile = GetFile();
	if (info.CurrentFile == -1)
		return 0;
	info.ScenarioID = GetScenarioID();
	info.FrameCounter = GetFrames();
	info.FightTime = GetFightTime();
	info.FightTime2 = GetFightTime2();
	info.GarageTime = GetGarageTime();
	info.GasTime = GetGasTime();
	info.GasFlag = GetGasFlag();
	info.GasRandom = GetGasRandom();
	info.ItemRandom = GetItemRandom();
	info.P1Coin = GetP1Coins();
	info.P2Coin = GetP2Coins();
	info.P3Coin = GetP3Coins();
	info.P4Coin = GetP4Coins();
	info.KilledZombie = GetKilledZombies();
	info.PlayerNum = GetPlayerNum();
	info.Pass1 = GetPass1();
	info.Pass2 = GetPass2();
	info.Pass3 = GetPass3();
	info.PassUB1 = GetPassUB1();
	info.PassUB2 = GetPassUB2();
	info.Pass4 = GetPass4();
	info.Pass5 = GetPass5();
	info.Pass6 = GetPass6();
	info.Difficulty = GetDifficulty();
	//info.E1Start = GetE1HP();//enemy1 HP
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
		Players[i].Size = GetSize(i);
		Players[i].Speed = GetSpeed(i);
		Players[i].Power = GetPower(i);
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
	return 0;
}

static int LUpdateEnemy (lua_State* L)
{
	for (int i=0; i < MAX_ENEMY; i++)
	{
		Enemies[i].Enabled = GetEnemyEnabled(i);
		Enemies[i].InGame = GetEnemyInGame(i);
		if (Enemies[i].InGame == 0)
			continue;
		Enemies[i].HP = GetEnemyHealth(i);
		Enemies[i].MaxHP = GetEnemyMaxHealth(i);
		Enemies[i].EnemyType = GetEnemyType(i);
		Enemies[i].NameID = GetEnemyNameID(i);
	}
	for (int i=0; i < MAX_ENEMY; i++)
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

static int LGetLobby (lua_State* L)
{
	double slotNum = lua_tonumber(L, 1);
	int i = (int)(slotNum-1);
	double playerID = lua_tonumber(L, 1);
	lua_newtable(L);

		lua_pushstring(L, "num");
			lua_pushnumber(L, (double)Slots[i].SlotNum);
		lua_rawset(L, -3);
		lua_pushstring(L, "status");
			lua_pushnumber(L, (double)Slots[i].Status);
		lua_rawset(L, -3);
		lua_pushstring(L, "pass");
			lua_pushnumber(L, (double)Slots[i].Pass);
		lua_rawset(L, -3);
		lua_pushstring(L, "version");
			lua_pushnumber(L, (double)Slots[i].Version);
		lua_rawset(L, -3);
		lua_pushstring(L, "player");
			lua_pushnumber(L, (double)Slots[i].Player);
		lua_rawset(L, -3);
		lua_pushstring(L, "maxplayer");
			lua_pushnumber(L, (double)Slots[i].MaxPlayer);
		lua_rawset(L, -3);
		if (info.CurrentFile == 1)
		{
		lua_pushstring(L, "slotscenario");
			lua_pushstring(L, GetF1LobScenarioName(Slots[i].ScenarioID));
		lua_rawset(L, -3);
		}
		else
		{
		lua_pushstring(L, "slotscenario");
			lua_pushstring(L, GetF2LobScenarioName(Slots[i].ScenarioID));
		lua_rawset(L, -3);
		}

	return 1;
}
static int LGetSlotPlayer (lua_State* L)
{
	double playerID = lua_tonumber(L, 1);
	int i = (int)(playerID-1);
	char* charname1 = GetSlotCharacterName(SPlayers[i].NameID);
	char* charname2 = GetCharacterName(SPlayers[i].NameID);
	char* hp = GetCharacterHP(SPlayers[i].NameID);
	char* npchp = GetNPCHP(SPlayers[i].NameID);
	char* power = GetCharacterPower(SPlayers[i].NameID);
	char* npcpower = GetNPCPower(SPlayers[i].NameID);
	char* name1 = GetF1NPCName(SPlayers[i].NameID);
	char* name2 = GetNPCName(SPlayers[i].NameID);
	char* statname = GetStatusText(SPlayers[i].Status);

	lua_newtable(L);

		lua_pushstring(L, "enabled");
			lua_pushboolean(L, SPlayers[i].Enabled);
		lua_rawset(L, -3);

		lua_pushstring(L, "inGame");
			lua_pushboolean(L, SPlayers[i].InGame);
		lua_rawset(L, -3);

		lua_pushstring(L, "npctype");
			lua_pushboolean(L, SPlayers[i].NPCType);
		lua_rawset(L, -3);

		lua_pushstring(L, "hp");
			if (SPlayers[i].NPCType == 0)
				lua_pushstring(L, hp);
			else
				lua_pushstring(L, npchp);
		lua_rawset(L, -3);

		lua_pushstring(L, "power");
			if (SPlayers[i].NPCType == 0)
				lua_pushstring(L, power);
			else
				lua_pushstring(L, npcpower);
		lua_rawset(L, -3);

		//lua_pushstring(L, "type");
		//	lua_pushstring(L, charname);
		//lua_rawset(L, -3);

		//if (SPlayers[i].NPCType == 0)

		lua_pushstring(L, "name");
			if (SPlayers[i].NPCType == 0)
			{
				if (info.CurrentFile == 1)
					lua_pushstring(L, charname1);
				else
					lua_pushstring(L, charname2);
			}
			else
			{
				if (info.CurrentFile == 1)
					lua_pushstring(L, name1);
				else
					lua_pushstring(L, name2);
			}
		lua_rawset(L, -3);

	return 1;
}
static int LGetItem (lua_State* L)
{
	double itemID = lua_tonumber(L, 1);
	int i = (int)(itemID-1);

	lua_newtable(L);

		lua_pushstring(L, "roomitem");
		lua_newtable(L);

			for (int j=0; j < MAX_ITEM; j++)
			{
				lua_pushnumber(L, (double)j+1);
				if (RItems[i].RItem[j].ID == 0x00||
				RItems[i].RItem[j].Count == 0xFFFF||
				RItems[i].RItem[j].EN != 0xFFFF||
				RItems[i].RItem[j].Pick > 0 && RItems[i].RItem[j].Present ==0||
				RItems[i].RItem[j].Mix == 0x20)
				{
					CreateEmptyItemTable
				}
				else
				{
					CreateItemTable(RItems[i].RItem[j]);
				}
			}

		lua_rawset(L, -3);

	return 1;
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

		lua_pushstring(L, "size");
			lua_pushnumber(L, Players[i].Size);
		lua_rawset(L, -3);

		lua_pushstring(L, "speed");
			lua_pushnumber(L, Players[i].Speed);
		lua_rawset(L, -3);

		lua_pushstring(L, "power");
			lua_pushnumber(L, Players[i].Power);
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
		lua_pushstring(L, "hoststatus");
			lua_pushnumber(L, (double)info.HostStatus);
		lua_rawset(L, -3);
		lua_pushstring(L, "hosttime");
			lua_pushnumber(L, (double)info.HostTime);
		lua_rawset(L, -3);
		lua_pushstring(L, "hostmaxplayer");
			lua_pushnumber(L, (double)info.HostMaxPlayer);
		lua_rawset(L, -3);
		lua_pushstring(L, "hostplayer");
			lua_pushnumber(L, (double)info.HostPlayer);
		lua_rawset(L, -3);
		lua_pushstring(L, "hostdifficulty");
			lua_pushstring(L, GetDifficultyName(info.HostDifficulty));
		lua_rawset(L, -3);

		if (info.CurrentFile == 1)
		{
		lua_pushstring(L, "hostscenario");
			lua_pushstring(L, GetF1LobScenarioName(info.HostScenarioID));
		lua_rawset(L, -3);
		}
		else
		{
		lua_pushstring(L, "hostscenario");
			lua_pushstring(L, GetF2LobScenarioName(info.HostScenarioID));
		lua_rawset(L, -3);
		}
		lua_pushstring(L, "scenario");
			lua_pushstring(L, GetScenarioName(info.ScenarioID));
		lua_rawset(L, -3);
		lua_pushstring(L, "frames");
			lua_pushnumber(L, (double)info.FrameCounter);
		lua_rawset(L, -3);
		lua_pushstring(L, "fighttime");
			lua_pushnumber(L, (double)info.FightTime);
		lua_rawset(L, -3);
		lua_pushstring(L, "fighttime2");
			lua_pushnumber(L, (double)info.FightTime2);
		lua_rawset(L, -3);
		lua_pushstring(L, "garagetime");
			lua_pushnumber(L, (double)info.GarageTime);
		lua_rawset(L, -3);
		lua_pushstring(L, "gastime");
			lua_pushnumber(L, (double)info.GasTime);
		lua_rawset(L, -3);
		lua_pushstring(L, "gasflag");
			lua_pushnumber(L, (double)info.GasFlag);
		lua_rawset(L, -3);
		lua_pushstring(L, "gasrandom");
			lua_pushnumber(L, (double)info.GasRandom);
		lua_rawset(L, -3);
		lua_pushstring(L, "itemrandom");
			lua_pushnumber(L, (double)info.ItemRandom);
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
		lua_pushstring(L, "pass1");
			lua_pushnumber(L, (double)info.Pass1);
		lua_rawset(L, -3);
		lua_pushstring(L, "pass2");
			lua_pushnumber(L, (double)info.Pass2);
		lua_rawset(L, -3);
		lua_pushstring(L, "pass3");
			lua_pushnumber(L, (double)info.Pass3);
		lua_rawset(L, -3);
		lua_pushstring(L, "passub1");
			lua_pushnumber(L, (double)info.PassUB1);
		lua_rawset(L, -3);
		lua_pushstring(L, "passub2");
			lua_pushnumber(L, (double)info.PassUB2);
		lua_rawset(L, -3);
		lua_pushstring(L, "pass4");
			lua_pushnumber(L, (double)info.Pass4);
		lua_rawset(L, -3);
		lua_pushstring(L, "pass5");
			lua_pushnumber(L, (double)info.Pass5);
		lua_rawset(L, -3);
		lua_pushstring(L, "pass6");
			lua_pushnumber(L, (double)info.Pass6);
		lua_rawset(L, -3);
		lua_pushstring(L, "playernum");
			lua_pushnumber(L, (double)info.PlayerNum);
		lua_rawset(L, -3);
		lua_pushstring(L, "difficulty");
			lua_pushstring(L, GetDifficultyName(info.Difficulty));
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
	{"updateLobby", LUpdateLobby},
	{"updateSlotPlayer", LUpdateSlotPlayer},
	{"updateItem", LUpdateItem},
	{"updatePlayer", LUpdatePlayer},
	{"updateEnemy", LUpdateEnemy},
	{"getLobby", LGetLobby},
	{"getSlotPlayer", LGetSlotPlayer},
	{"getItem", LGetItem},
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
