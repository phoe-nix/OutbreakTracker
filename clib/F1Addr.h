// I'm way too lazy to f&@! with defines lol.

const int F1_P1Start = 0x20476DD0; // 0x204772E0 Not the actual start, but used as anchor point.
const int F1_P2Start = 0x20477EB0;
const int F1_P3Start = 0x20478F90;
const int F1_P4Start = 0x2047A070;
const int F1_PickupSpaceStart = 0x20396812; // 1 item - 60 bytes
const int F1_DeadInventoryStart = 0x2048BDE2;
const int F1_VirusMaxStart = 0x206E6C70;
const int F1_ScenarioIDAddr = 0x203065AA;
const int F1_FrameCounter = 0x2048BF78;

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

const int F1_PickupStructSize = 60;
const int F1_PickupCountOffset = 30;
const int F1_PickupOffset = 34;
const int F1_PresentOffset = 26;
const int F1_MixOffset = 21;

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
const int F1_RoomItem = 0x2023BD90;//room item pointer 0x24AF48
const int F1_Pointer = 0x20386B94;//enemy HP
const int F1_EHPOffset = 0x544;

const int F1_EMaxHPOffset = 0x546;
const int F1_E1Start = 0x20420000;
const int F1_E2Start = 0x20420D90;
const int F1_E3Start = 0x20421B20;
const int F1_E4Start = 0x204228B0;
const int F1_E5Start = 0x20423640;
const int F1_E6Start = 0x204243D0;
const int F1_E7Start = 0x20425160;
const int F1_E8Start = 0x20425EF0;
const int F1_E9Start = 0x20426C80;
const int F1_E10Start = 0x20427A10;
const int F1_E11Start = 0x204287A0;
const int F1_E12Start = 0x20429530;
const int F1_EnemyEnabled = 0;
const int F1_EnemyInGame = 1;
const int F1_EnemyNameIDOffset = 3;
const int F1_EnemyTypeOffset = 4;
const int F1_EnemyStatusOffset = 0x32;

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
const int F1_PlayerNum =  0x2023BE14;//23C004
const int F1_HostStatus =  0x2062E230;
const int F1_HostPlayer =  0x206547AA;//number of players 629602 62E682 6547AA 68AF31
const int F1_HostMaxPlayer =  0x205FFFDA;//number of players 629604
const int F1_HostScenarioID =  0x2062E236;//62E750
const int F1_HostTime =  0x2062EB80;//
const int F1_HostDifficulty = 0x2060292A;

const int F1_LobP1Start = 0x20630D40;
const int F1_LobP2Start = 0x206310E8;
const int F1_LobP3Start = 0x20631490;
const int F1_LobP4Start = 0x20631838;

const int F1_SlotPlayer = 0x2;
const int F1_SlotMaxPlayer = 0x4;
const int F1_SlotStatus = 0xE;
const int F1_SlotPass = 0xF;
const int F1_SlotScenarioID = 0x14;
const int F1_SlotVersion = 0x16;//0x11=dvd, 0x12=hdd
const int F1_SlotTitle = 0x18;
const int F1_Slot1 = 0x20629600;
const int F1_Slot2 = 0x2062975C;
const int F1_Slot3 = 0x206298B8;
const int F1_Slot4 = 0x20629A14;
const int F1_Slot5 = 0x20629B70;
const int F1_Slot6 = 0x20629CCC;
const int F1_Slot7 = 0x20629E28;
const int F1_Slot8 = 0x20629F84;
const int F1_Slot9 = 0x2062A0E0;
const int F1_Slot10 = 0x2062A23C;
const int F1_Slot11 = 0x2062A398;
const int F1_Slot12 = 0x2062A4F4;
const int F1_Slot13 = 0x2062A650;
const int F1_Slot14 = 0x2062A7AC;
const int F1_Slot15 = 0x2062A908;
const int F1_Slot16 = 0x2062AA64;
const int F1_Slot17 = 0x2062ABC0;
const int F1_Slot18 = 0x2062AD1C;
const int F1_Slot19 = 0x2062AE78;
const int F1_Slot20 = 0x2062AFD4;

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

const int F1_Pass1 = 0x2048AC13;
const int F1_Pass2 = 0x2048AC17;
const int F1_Pass3 = 0x2048AC14;
const int F1_Pass4 = 0x2048AC1A;//48ADCE
const int F1_Pass5 = 0x2048AC1B;//48ADCF  on=48ADF3
const int F1_Pass6 = 0x2048AC15;//4927=7500 4032=7480 40 4284=0200
const int F1_Difficulty = 0x2048C01A;
const int F1_ItemRandom = 0x2023BBA0;//23BB28 23C055 23BD20 426AA9 23BBA0 23BD24
//pass 6D6570
//事件零下48BF60
//b7f 48AD93:0x00=off 0x01=on
//b5f 48AD91:0x40=off 0x50=on
//b4f 48AD92:0x00=off 0x40=on
//零下pass 48AC17 A375=0x20 J126=0x40 C582=0x80
//48AC13 0634 0-1f 80-9f 4509 20-3f a0 bf 9741 40-7f c0-ff
//狱炎谜题 1=0x20 2=0x40 3=0x80 4=0x100
//48AC1B 02
const int F1_SlotP1Start = 0x20630E54;//+3A8 62FCF0
const int F1_SlotP2Start = 0x206311FC;//630F38 6312E0
const int F1_SlotP3Start = 0x206315A4;
const int F1_SlotP4Start = 0x2063194C;

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