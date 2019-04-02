// I'm way too lazy to f&@! with defines lol.

const int F1_P1Start = 0x204772E0; // Not the actual start, but used as anchor point.
const int F1_P2Start = 0x204783C0;
const int F1_P3Start = 0x204794A0;
const int F1_P4Start = 0x2047A580;
const int F1_PickupSpaceStart = 0x20396812; // 1 item - 60 bytes
const int F1_DeadInventoryStart = 0x2048BDE2;
const int F1_VirusMaxStart = 0x206E6C70;
const int F1_ScenarioIDAddr = 0x203065AA;
const int F1_FrameCounter = 0x2048BF78;

const int F1_RoomIDOffset = -814;
const int F1_CharacterEnabled = -1296;
const int F1_CharacterInGame = -1295;
const int F1_HPOffset = 52;
const int F1_MaxHPOffset = 54;
const int F1_CharacterTypeOffset = 1672;
const int F1_CharacterStatusOffset = 1680; 
const int F1_VirusOffset = 1692;
const int F1_CritBonusOffset = 1696;
const int F1_NameTypeOffset = 1700;
const int F1_InventoryOffset = 1908;
const int F1_EquippedItemOffset = 1900;

const int F1_PickupStructSize = 60;
const int F1_PickupCountOffset = 30;

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

const int F1_Pointer = 0x20386B94;//enemy HP
const int F1_EHPOffset = 0x544;

const int F1_EMaxHPOffset = 0x546;

const int F1_E1Start = 0x20425160;
const int F1_E2Start = 0x20425EF0;
const int F1_E3Start = 0x20426C80;
const int F1_E4Start = 0x20427A10;
const int F1_E5Start = 0x204287A0;
const int F1_E6Start = 0x20429530;
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
