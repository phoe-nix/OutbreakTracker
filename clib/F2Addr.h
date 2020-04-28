// I'm way too lazy to f&@! with defines lol.

const int F2_P1Start = 0x2047BD30; // 0x2047C23C Not the actual start, but used as anchor point.
const int F2_P2Start = 0x2047CE30;
const int F2_P3Start = 0x2047DF30;
const int F2_P4Start = 0x2047F030;
const int F2_PickupSpaceStart = 0x20397B7C; // 1 item - 60 bytes // settings byte on offset ITEM_PTR+37?
const int F2_DeadInventoryStart = 0x20491146;
const int F2_VirusMaxStart = 0x20728500;
const int F2_ScenarioIDAddr = 0x203137BA;
const int F2_FrameCounter = 0x204912B8;

const int F2_PositionX = 0x38;
const int F2_PositionY = 0x40;
const int F2_RoomIDOffset = 0x1E2;
const int F2_CharacterEnabled = 0;
const int F2_CharacterInGame = 1;
const int F2_HPOffset = 0x540;
const int F2_MaxHPOffset = 0x542;
const int F2_CharacterTypeOffset = 0xBB0;
const int F2_CharacterStatusOffset = 0xBB8;
const int F2_VirusOffset = 0xBC4;
const int F2_NameTypeOffset = 0xBC8;
const int F2_CritBonusOffset = 0xBD4;

const int F2_SizeOffset = 0xB4;
const int F2_SpeedOffset = 0xBD8;
const int F2_PowerOffset = 0xBDC;

const int F2_InventoryOffset = 0xC94;
const int F2_EquippedItemOffset = 0xC8C;
const int F2_BleedTimeOffset = 0xC6A;

const int F2_PickupStructSize = 60;
const int F2_ItemRoomIDOffset = 1;
const int F2_PickupCountOffset = 36;
const int F2_PickupOffset = 40;
const int F2_PresentOffset = 32;//28 38
const int F2_MixOffset = 27;
const int F2_IDOffset = 6;
const int F2_NumberOffset = 4;

int F2_GetCharAddress(int characterID)
{
    switch (characterID)
    {
        case 0:
            return F2_P1Start;
        case 1:
            return F2_P2Start;
        case 2:
            return F2_P3Start;
        case 3:
            return F2_P4Start;
        default:
            return -1;
    }
}

const int F2_RoomItem = 0x2024AF48;//room item pointer 0x24AF48 387CB0
int F2_GetItemAddress(int characterID)
{
    switch (characterID)
    {
        case 0:
            return 0x203BA200;
        case 1:
            return 0x203B9B40;
        case 2:
            return 0x203B9B40;
        case 3:
            return 0x203B9B40;
        default:
            return -1;
    }
}

const int F2_Pointer = 0x20388314;//enemy HP
const int F2_EHPOffset = 0x540;
const int F2_EMaxHPOffset = 0x542;
const int F2_E1Start = 0x204245D0;
const int F2_E2Start = 0x20425380;
const int F2_E3Start = 0x20426130;
const int F2_E4Start = 0x20426EE0;
const int F2_E5Start = 0x20427C90;
const int F2_E6Start = 0x20428A40;
const int F2_E7Start = 0x204297F0;
const int F2_E8Start = 0x2042A5A0;
const int F2_E9Start = 0x2042B350;
const int F2_E10Start = 0x2042C100;
const int F2_E11Start = 0x2042CEB0;
const int F2_E12Start = 0x2042DC60;
const int F2_EnemyEnabled = 0;
const int F2_EnemyInGame = 1;
const int F2_EnemyNameIDOffset = 3;
const int F2_EnemyTypeOffset = 0xBD2;
const int F2_EnemyStatusOffset = 0x32;//8,32,cb0,1F3

int F2_GetEnemyAddress(int enemyID)
{
    switch (enemyID)
    {
        case 0:
            return F2_E12Start;
        case 1:
            return F2_E11Start;
        case 2:
            return F2_E10Start;
        case 3:
            return F2_E9Start;
        case 4:
            return F2_E8Start;
        case 5:
            return F2_E7Start;
        case 6:
            return F2_E6Start;
        case 7:
            return F2_E5Start;
        case 8:
            return F2_E4Start;
        case 9:
            return F2_E3Start;
        case 10:
            return F2_E2Start;
        case 11:
            return F2_E1Start;
        default:
            return -1;
    }
}

int F2_GetEnemy2Address(int enemyID)
{
    switch (enemyID)
    {
        case 0:
            return F2_E1Start;
        case 1:
            return F2_E2Start;
        case 2:
            return F2_E3Start;
        case 3:
            return F2_E4Start;
        case 4:
            return F2_E5Start;
        case 5:
            return F2_E6Start;
        default:
            return -1;
    }
}

const int F2_Coin = 0x20491188;//wild things
const int F2_KilledZombie = 0x20491268;//47ca64,49010c,491268,desperate times
const int F2_MaxZombie = 0x2179464a;
const int F2_DTStart = 0x20490f6c;
const int F2_PlayerNum =  0x2024AFCC;
const int F2_HostStatus =  0x2062DDF0;
const int F2_HostPlayer =  0x206411E6;//number of players
const int F2_HostMaxPlayer =  0x205FF77A;//number of players
const int F2_HostScenarioID =  0x2062DDF6;
const int F2_HostTime =  0x2062E768;
const int F2_HostDifficulty = 0x206020CA;
//wt door 0x477762 0x4777A2
//dt unlock door 3BC0E4
//p1power +BDC 47c90c 
//num of player in game 24AFCC 49135f
//slot character 630D40 6310E8 631490 631838
//slot npc 630D42 1
//slot Scenario 62DDF6 62E324
//slot num 63C56A 63C56C
//slot1 628da0 +2players +4maxplayers slot2+15C
//slot1 628DAE 00=Busy 01=Vacant 02=Busy(设定中) 03=Join in 04=Full 05=playing 06=opening
//slot2 628EFC
//62B672 num of players in door
//63C56A num of players in chat room
//63C56C num of players in lobbies

const int F2_SlotP1Start = 0x20630D40;
const int F2_SlotP2Start = 0x206310E8;
const int F2_SlotP3Start = 0x20631490;
const int F2_SlotP4Start = 0x20631838;

int F2_GetSlotCharAddress(int characterID)
{
    switch (characterID)
    {
        case 0:
            return F2_SlotP1Start;
        case 1:
            return F2_SlotP2Start;
        case 2:
            return F2_SlotP3Start;
        case 3:
            return F2_SlotP4Start;
        default:
            return -1;
    }
}
const int F2_SlotPlayer = 0x2;
const int F2_SlotMaxPlayer = 0x4;
const int F2_SlotStatus = 0xE;
const int F2_SlotPass = 0xF;
const int F2_SlotScenarioID = 0x14;
const int F2_SlotVersion = 0x16;//0x11=dvd, 0x12=hdd
const int F2_SlotTitle = 0x18;
const int F2_Slot1 = 0x20628DA0;
const int F2_Slot2 = 0x20628EFC;
const int F2_Slot3 = 0x20629058;
const int F2_Slot4 = 0x206291B4;
const int F2_Slot5 = 0x20629310;
const int F2_Slot6 = 0x2062946C;
const int F2_Slot7 = 0x206295C8;
const int F2_Slot8 = 0x20629724;
const int F2_Slot9 = 0x20629880;
const int F2_Slot10 = 0x206299DC;
const int F2_Slot11 = 0x20629B38;
const int F2_Slot12 = 0x20629C94;
const int F2_Slot13 = 0x20629DF0;
const int F2_Slot14 = 0x20629F4C;
const int F2_Slot15 = 0x2062A0A8;
const int F2_Slot16 = 0x2062A204;
const int F2_Slot17 = 0x2062A360;
const int F2_Slot18 = 0x2062A4BC;
const int F2_Slot19 = 0x2062A618;
const int F2_Slot20 = 0x2062A774;

int F2_GetLobbyAddress(int slotNum)
{
    switch (slotNum)
    {
        case 0:
            return F2_Slot1;
        case 1:
            return F2_Slot2;
        case 2:
            return F2_Slot3;
        case 3:
            return F2_Slot4;
        case 4:
            return F2_Slot5;
        case 5:
            return F2_Slot6;
        case 6:
            return F2_Slot7;
        case 7:
            return F2_Slot8;
        case 8:
            return F2_Slot9;
        case 9:
            return F2_Slot10;
        case 10:
            return F2_Slot11;
        case 11:
            return F2_Slot12;
        case 12:
            return F2_Slot13;
        case 13:
            return F2_Slot14;
        case 14:
            return F2_Slot15;
        case 15:
            return F2_Slot16;
        case 16:
            return F2_Slot17;
        case 17:
            return F2_Slot18;
        case 18:
            return F2_Slot19;
        case 19:
            return F2_Slot20;
        default:
            return -1;
    }
}

const int F2_PassUB1 = 0x20490073;//异界
const int F2_PassUB2 = 0x20490075;//异界
const int F2_EscapeTime = 0x20491256;//异界
const int F2_FBTime = 0x20491254;//记忆
const int F2_Pass4 = 0x20491268;//突破
const int F2_Difficulty = 0x2049135A;
const int F2_DTGasRandom = 0x2024ADB0;//24ADB0(offline) 491338(online)
const int F2_DTGasFlag = 0x2048FFFC;
const int F2_DTGasTime = 0x20491278;
const int F2_DTFightTime = 0x2049126C;
const int F2_DTFightTime2 = 0x2049124E;
const int F2_DTGarageTime = 0x20491270;//48FE71 switch
const int F2_ItemRandom = 0x2024AD30;//
/*clear 4912A0
//random set? 24AD30 397B80 397B82 491338 491353 49135E
//gas address
24ADB0 3F 98(89 95)  1 2F East Hall
98 F1(AE 88)
00
//48FE74 02 = set2
//48FE78 80 = set2
//48FE79 04 = set2
//48FE7A 01 = set2
//48FE7C 80 = set2
//48FF38 80 gas random
//48FF3C 80
//490266 04?
//490356 02
//4912CB 01
//491338
 online 8D=vh set1 online 8e= vh set2
offline 93=easy 8b=normal 7c= hard 73=vh
//491353 01
//(item?) 49135E 2a =set 1 2b= set2 
//49136F 01
//493982 02
//490073 750BB0 2916 3719 0154 6443 7688 1812 5551 6010 0652 6234 0533 9439 1421 1127 7840 6910
24AD7C
24AE2C
24AE43
24AE48
24AE57
24AE74
24AE84
24AE88
24AE94
24AEF8
24B320
24B480
24B4C8
24B54C
24D156
24E164

*/