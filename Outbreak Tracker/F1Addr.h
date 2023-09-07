// I'm way too lazy to f&@! with defines lol.

const int F1_P1Start = 0x476DD0; // 0x204772E0 Not the actual start, but used as anchor point.
const int F1_P2Start = 0x477EB0;
const int F1_P3Start = 0x478F90;
const int F1_P4Start = 0x47A070;
const int F1_PickupSpaceStart = 0x39680C; // 1 item - 60 bytes
const int F1_DeadInventoryStart = 0x48BDE2;
const int F1_VirusMaxStart = 0x6E6C70;
const int F1_ScenarioIDAddr = 0x3065AA;
const int F1_FrameCounter = 0x48BF78;
const int F1_RoomPriorty = 0x00825810;

const int F1_PositionX = 0x38;
const int F1_PositionY = 0x40;
const int F1_RoomIDOffset = 0x1E2;
const int F1_CharacterEnabled = 0;
const int F1_CharacterInGame = 1;
const int F1_HPOffset = 0x544;
const int F1_MaxHPOffset = 0x546;
const int F1_CharacterTypeOffset = 0xB98;
const int F1_CharacterStatusOffset = 0xBA0; 
const int F1_VirusOffset = 0xBAC;
const int F1_CritBonusOffset = 0xBB0;

const int F1_SizeOffset = 0xB4;
const int F1_SpeedOffset = 0xBC0;
const int F1_PowerOffset = 0xBC4;

const int F1_NameTypeOffset = 0xBB4;
const int F1_InventoryOffset = 0xC84;
const int F1_EquippedItemOffset = 0xC7C;
const int F1_BleedTimeOffset = 0xC5A;
const int F1_AntiVirusTimeOffset = 0xBB6;//anti-virus time
const int F1_AntiVirusGTimeOffset = 0xBB8;//anti-virus g time
const int F1_HerbTimeOffset = 0xBBA;//herb time

const int F1_PickupStructSize = 60;
const int F1_ItemRoomIDOffset = 1;
const int F1_PickupCountOffset = 36;
const int F1_PickupOffset = 40;
const int F1_PresentOffset = 32;
const int F1_MixOffset = 27;
const int F1_IDOffset = 6;
const int F1_NumberOffset = 4;

int F1_GetCharAddress(int characterID) // clunckiest thing ever
{
    switch (characterID)
    {
        case 0:
            return F1_P1Start;
        case 1:
            return F1_P2Start;
        case 2:
            return F1_P3Start;
        case 3:
            return F1_P4Start;
        default:
            return -1;
    }
}
const int F1_RoomItem = 0x23BD90;//room item pointer 0x24AF48
const int F1_Pointer = 0x386B94;//enemy HP
const int F1_EHPOffset = 0x544;

const int F1_EMaxHPOffset = 0x546;
const int F1_E1Start = 0x420000;
const int F1_E2Start = 0x420D90;
const int F1_E3Start = 0x421B20;
const int F1_E4Start = 0x4228B0;
const int F1_E5Start = 0x423640;
const int F1_E6Start = 0x4243D0;
const int F1_E7Start = 0x425160;
const int F1_E8Start = 0x425EF0;
const int F1_E9Start = 0x426C80;
const int F1_E10Start = 0x427A10;
const int F1_E11Start = 0x4287A0;
const int F1_E12Start = 0x429530;
const int F1_EnemyEnabled = 0;
const int F1_EnemyInGame = 1;
const int F1_EnemyNameIDOffset = 3;
const int F1_EnemyTypeOffset = 0xBBA;
const int F1_EnemyStatusOffset = 0x32;
const int F1_EnemyListOffset = 0x71A030;

int F1_GetEnemyAddress(int enemyID)
{
    switch (enemyID)
    {
        case 0:
            return F1_E12Start;
        case 1:
            return F1_E11Start;
        case 2:
            return F1_E10Start;
        case 3:
            return F1_E9Start;
        case 4:
            return F1_E8Start;
        case 5:
            return F1_E7Start;
        case 6:
            return F1_E6Start;
        case 7:
            return F1_E5Start;
        case 8:
            return F1_E4Start;
        case 9:
            return F1_E3Start;
        case 10:
            return F1_E2Start;
        case 11:
            return F1_E1Start;
        default:
            return -1;
    }
}

int F1_GetEnemy2Address(int enemyID)
{
    switch (enemyID)
    {
        case 0:
            return F1_E1Start;
        case 1:
            return F1_E2Start;
        case 2:
            return F1_E3Start;
        case 3:
            return F1_E4Start;
        case 4:
            return F1_E5Start;
        case 5:
            return F1_E6Start;
        default:
            return -1;
    }
}

const int F1_Door1HP = 0x472FC0;//472FC0/472FF0
const int F1_Door2HP = 0x473086;//473086
const int F1_Door3HP = 0x4731C0;//4731C0/473220
const int F1_Door4HP = 0x473232;//473232/473260
const int F1_Door5HP = 0x473504;//473504/4735F0
const int F1_Door6HP = 0x473652;//room 102
const int F1_Door7HP = 0x473712;//room 201
const int F1_Door8HP = 0x4737D2;//room 202
const int F1_Door9HP = 0x4739B6;//4739B6/473A70 dd t-shaped
const int F1_Door10HP = 0x473A40;//473A40/473A72 store room

int F1_GetDoorHP(int doorID)
{
    switch (doorID)
    {
        case 0:return F1_Door1HP;
        case 1:return F1_Door2HP;
        case 2:return F1_Door3HP;
        case 3:return F1_Door4HP;
        case 4:return F1_Door5HP;
        case 5:return F1_Door6HP;
        case 6:return F1_Door7HP;
        case 7:return F1_Door8HP;
        case 8:return F1_Door9HP;
        case 9:return F1_Door10HP;
        default:return -1;
    }
}

const int F1_Door1Flag = 0x48AFBC;//48AFBC
const int F1_Door2Flag = 0x48AFEC;//48AFEC
const int F1_Door3Flag = 0x48AD90;//
const int F1_Door4Flag = 0x48B058;//48B058
const int F1_Door5Flag = 0x48B10C;//48B10C/48B148
const int F1_Door6Flag = 0x48B160;//room 102
const int F1_Door7Flag = 0x48B190;//room 201
const int F1_Door8Flag = 0x48B1C0;//room 202
const int F1_Door9Flag = 0x48B238;//48B238/48B268 dd t-shaped
const int F1_Door10Flag = 0x48B25C;//48B25C/48B268 store room

int F1_GetDoorFlag(int doorID)
{
    switch (doorID)
    {
        case 0:return F1_Door1Flag;
        case 1:return F1_Door2Flag;
        case 2:return F1_Door3Flag;
        case 3:return F1_Door4Flag;
        case 4:return F1_Door5Flag;
        case 5:return F1_Door6Flag;
        case 6:return F1_Door7Flag;
        case 7:return F1_Door8Flag;
        case 8:return F1_Door9Flag;
        case 9:return F1_Door10Flag;
        default:return -1;
    }
}

const int F1_DoorHP = 0x472F90;
const int F1_DoorFlag = 0x48ADBC;//lock flag
const int F1_PlayerNum =  0x23BE14;//23C004
const int F1_HostStatus =  0x62E230;
const int F1_HostPlayer =  0x6547AA;//number of players 629602 62E682 6547AA 68AF31
const int F1_HostMaxPlayer =  0x5FFFDA;//number of players 629604
const int F1_HostScenarioID =  0x62E236;//62E750
const int F1_HostTime =  0x62EB80;//
const int F1_HostDifficulty = 0x60292A;

const int F1_LobP1Start = 0x630D40;
const int F1_LobP2Start = 0x6310E8;
const int F1_LobP3Start = 0x631490;
const int F1_LobP4Start = 0x631838;

const int F1_SlotPlayer = 0x2;
const int F1_SlotMaxPlayer = 0x4;
const int F1_SlotStatus = 0xE;
const int F1_SlotPass = 0xF;
const int F1_SlotScenarioID = 0x14;
const int F1_SlotVersion = 0x16;//0x11=dvd, 0x12=hdd
const int F1_SlotTitle = 0x18;
const int F1_Slot1 = 0x629600;
const int F1_Slot2 = 0x62975C;
const int F1_Slot3 = 0x6298B8;
const int F1_Slot4 = 0x629A14;
const int F1_Slot5 = 0x629B70;
const int F1_Slot6 = 0x629CCC;
const int F1_Slot7 = 0x629E28;
const int F1_Slot8 = 0x629F84;
const int F1_Slot9 = 0x62A0E0;
const int F1_Slot10 = 0x62A23C;
const int F1_Slot11 = 0x62A398;
const int F1_Slot12 = 0x62A4F4;
const int F1_Slot13 = 0x62A650;
const int F1_Slot14 = 0x62A7AC;
const int F1_Slot15 = 0x62A908;
const int F1_Slot16 = 0x62AA64;
const int F1_Slot17 = 0x62ABC0;
const int F1_Slot18 = 0x62AD1C;
const int F1_Slot19 = 0x62AE78;
const int F1_Slot20 = 0x62AFD4;

int F1_GetLobbyAddress(int slotNum)
{
    switch (slotNum)
    {
        case 0:
            return F1_Slot1;
        case 1:
            return F1_Slot2;
        case 2:
            return F1_Slot3;
        case 3:
            return F1_Slot4;
        case 4:
            return F1_Slot5;
        case 5:
            return F1_Slot6;
        case 6:
            return F1_Slot7;
        case 7:
            return F1_Slot8;
        case 8:
            return F1_Slot9;
        case 9:
            return F1_Slot10;
        case 10:
            return F1_Slot11;
        case 11:
            return F1_Slot12;
        case 12:
            return F1_Slot13;
        case 13:
            return F1_Slot14;
        case 14:
            return F1_Slot15;
        case 15:
            return F1_Slot16;
        case 16:
            return F1_Slot17;
        case 17:
            return F1_Slot18;
        case 18:
            return F1_Slot19;
        case 19:
            return F1_Slot20;
        default:
            return -1;
    }
}

const int F1_Pass1 = 0x48AC13;
const int F1_Pass2 = 0x48AC17;
const int F1_Pass3 = 0x48AC14;
const int F1_Pass4 = 0x48AC1A;//48AC1A 48ADCE
const int F1_Pass5 = 0x48AC1B;//48ADCF  on=48ADF3
const int F1_Pass6 = 0x48AC15;//4927=7500 4032=7480 40 4284=0200
const int F1_Difficulty = 0x48C01A;
const int F1_ItemRandom = 0x23BB20;//23BB28 23C055 23BD20 426AA9 23BBA0 23BD24
const int F1_ItemRandom2 = 0x23BBA1;
const int F1_PuzzleRandom = 0x23BBA0;// puzzle set
const int F1_Cleared = 0x48BF60;//
/*pass 6D6570
事件零下48BF60
b7f 48AD93:0x00=off 0x01=on
b5f 48AD91:0x40=off 0x50=on
b4f 48AD92:0x00=off 0x40=on
零下pass 48AC17 A375=0x20 J126=0x40 C582=0x80
48AC13 0634 0-1f 80-9f 4509 20-3f a0 bf 9741 40-7f c0-ff
狱炎谜题 1=0x20 2=0x40 3=0x80 4=0x100
48AC1B 02
48ADCE
    :0 44 110
1234:
12  : C
1  4: 24 60
   4: 20 64
  3 : 10 54
 2  : 8 4C
1   : 4 40 8C C8 114 150
*/
const int F1_SlotP1Start = 0x630E54;//+3A8 62FCF0
const int F1_SlotP2Start = 0x6311FC;//630F38 6312E0
const int F1_SlotP3Start = 0x6315A4;
const int F1_SlotP4Start = 0x63194C;

int F1_GetSlotCharAddress(int characterID)
{
    switch (characterID)
    {
        case 0:
            return F1_SlotP1Start;
        case 1:
            return F1_SlotP2Start;
        case 2:
            return F1_SlotP3Start;
        case 3:
            return F1_SlotP4Start;
        default:
            return -1;
    }
}