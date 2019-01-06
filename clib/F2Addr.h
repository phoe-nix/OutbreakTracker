// I'm way too lazy to f&@! with defines lol.

const int F2_P1Start = 0x2047C23C; // Not the actual start, but used as anchor point.
const int F2_P2Start = 0x2047D33C;
const int F2_P3Start = 0x2047E43C;
const int F2_P4Start = 0x2047F53C;
const int F2_PickupSpaceStart = 0x20397B82; // 1 item - 60 bytes // settings byte on offset ITEM_PTR+37?
const int F2_DeadInventoryStart = 0x20491146;
const int F2_VirusMaxStart = 0x20728500;
const int F2_ScenarioIDAddr = 0x203137BA;
const int F2_FrameCounter = 0x204912B8;

const int F2_RoomIDOffset = -810;
const int F2_CharacterEnabled = -1292;
const int F2_CharacterInGame = -1291;
const int F2_HPOffset = 52;
const int F2_MaxHPOffset = 54;
const int F2_CharacterTypeOffset = 1700;
const int F2_CharacterStatusOffset = 1708;
const int F2_VirusOffset = 1720;
const int F2_NameTypeOffset = 1724;
const int F2_CritBonusOffset = 1736;
const int F2_InventoryOffset = 1928;
const int F2_EquippedItemOffset = 1920;

const int F2_PickupStructSize = 60;
const int F2_PickupCountOffset = 30;

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