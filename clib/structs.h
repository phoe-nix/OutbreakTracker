#define true 1
#define false 0
typedef int bool;

#define CreateItemTable(sd) \
    lua_newtable(L); \
        lua_pushstring(L, "id"); \
            lua_pushnumber(L, (double)sd.ID); \
        lua_rawset(L, -3); \
        lua_pushstring(L, "type"); \
            lua_pushnumber(L, (double)sd.Type); \
        lua_rawset(L, -3); \
        lua_pushstring(L, "count"); \
            lua_pushnumber(L, (double)sd.Count); \
        lua_rawset(L, -3); \
    lua_rawset(L, -3);

#define CreateEmptyItemTable \
    lua_newtable(L); \
        lua_pushstring(L, "id"); \
            lua_pushnumber(L, -1); \
        lua_rawset(L, -3); \
        lua_pushstring(L, "type"); \
            lua_pushnumber(L, 0); \
        lua_rawset(L, -3); \
        lua_pushstring(L, "count"); \
            lua_pushnumber(L, 0); \
        lua_rawset(L, -3); \
    lua_rawset(L, -3);

typedef struct
{
	unsigned char CurrentFile;
	unsigned short ScenarioID;
	unsigned int FrameCounter;
} GameInfo;

typedef struct
{
    unsigned char ID;
	unsigned short Type;
	unsigned short Count;
} Item;

typedef struct
{
	bool Enabled;
	bool InGame;
    unsigned short HP;
    unsigned short MaxHP;
    unsigned char CharacterType;
    double Virus;
    double CritBonus;
    unsigned short RoomID;
    unsigned char Status;
    unsigned char NameID;
    unsigned char Inventory [4];
    unsigned char SpecialItem;
    unsigned char SpecialInventory [4];
    unsigned char DeadInventory [4];
    unsigned char DeadInventorySpecial [4];
    Item CindyBag [4];
    unsigned char EquippedItem;
} Player;

char* GetCharacterName(int charType)
{
    switch(charType)
    {
        case 0:
            return "Kevin";
        case 1:
            return "Mark";
        case 2:
            return "Jim";
        case 3:
            return "George";
        case 4:
            return "David";
        case 5:
            return "Alyssa";
        case 6:
            return "Yoko";
        case 7:
            return "Cindy";
        default:
            return "Unknown";
    }
}

char* GetNPCName(int nameID)
{
    switch (nameID)
    {
        case 1:
            return "MACDOWELL";
        case 2:
            return "RODRIGUEZ";
        case 3:
            return "CONRAD";
        case 4:
            return "HUNK:B";
        case 5:
            return "HUNK";
        case 6:
            return "MIGUEL";
        case 8:
            return "LUKE";
        case 10:
            return "ARNOLD";
        case 11:
            return "MATT";
        case 12:
            return "BILLY";
        case 13:
            return "HARSH";
        case 17:
            return "PETER";
        case 18:
            return "MARVIN";
        case 19:
            return "FRED";
        case 20:
            return "ANDY";
        case 22:
            return "JEAN";
        case 23:
            return "TONY";
        case 25:
            return "PATRICK";
        case 26:
            return "LLOYD";
        case 27:
            return "AUSTIN";
        case 28:
            return "CLINT";
        case 29:
            return "BONE";
        case 30:
            return "BOB";
        case 32:
            return "NATHAN";
        case 33:
            return "SAMUEL";
        case 35:
            return "WILL";
        case 37:
            return "ROGER";
        case 39:
            return "CARTER";
        case 40:
            return "GREG";
        case 41:
            return "FROST";
        case 42:
            return "FROST:B";
        case 43:
            return "JAKE";
        case 44:
            return "GARY";
        case 45:
            return "RICHARD";
        case 47:
            return "MICKEY";
        case 48:
            return "AL";
        case 49:
            return "AXEMAN";
        case 50:
            return "AL:B";
        case 51:
            return "BEN";
        case 53:
            return "REGAN";
        case 54:
            return "REGAN:B";
        case 55:
            return "MONICA";
        case 56:
            return "LINDA";
        case 57:
            return "RITA";
        case 59:
            return "MARY";
        case 60:
            return "KATE";
        case 63:
            return "DANNY";
        case 64:
            return "DANNY:B";
        case 65:
            return "GILL";
        case 66:
            return "GILL:B";
        case 74:
            return "KEITH";
        case 81:
            return "KURT";
        case 82:
            return "KURT:B";
        case 83:
            return "GARY:B";
        case 84:
            return "AL:C";
        case 87:
            return "DOROTHY";
        case 91:
            return "YOKO:Z";
        case 101:
            return "RAYMOND";
        case 102:
            return "ARTHUR";
        case 103:
            return "AARON";
        case 104:
            return "DORIAN";
        case 105:
            return "ELLIOTT";
        case 106:
            return "ERIC";
        case 107:
            return "HARRY";
        case 108:
            return "Mr.RED";
        case 109:
            return "Mr.BLUE";
        case 110:
            return "Mr.GREEN";
        case 111:
            return "Mr.GOLD";
        case 112:
            return "Mr.BLACK";
        case 113:
            return "KARL";
        case 114:
            return "DUSTIN";
        case 116:
            return "DEREK";
        case 117:
            return "Ms.WHITE";
        case 118:
            return "Ms.PEACH";
        case 119:
            return "Ms.WATER";
        case 120:
            return "LEN";
        case 121:
            return "NICOLAS";
        case 122:
            return "SEAN";
        case 123:
            return "PHILIP";
        case 124:
            return "DON";
        case 125:
            return "MATTHEW";
        case 126:
            return "ROBERT";
        case 127:
            return "CHUCK";
        case 128:
            return "GINGER";
        case 129:
            return "LAURA";
        case 130:
            return "AMELIA";
        case 131:
            return "ETHAN";
        case 133:
            return "HOWARD";
        case 135:
            return "ISAAC";
        case 137:
            return "KATHY";
        case 139:
            return "ELENA";
        case 141:
            return "FRANK";
        case 151:
            return "RODNEY";
        default:
            return NULL;

    }
}

char* GetScenarioName(unsigned short ScenarioID)
{
    switch (ScenarioID)
    {
        case 1:
            return "outbreak";
        case 35:
            return "below freezing point";
        case 28:
            return "the hive";
        case 2:
            return "hellfire";
        case 41:
            return "decisions,decisions";
        case 20:
            return "training ground";
        case 40:
            return "wild things";
        case 10:
            return "underbelly";
        case 26:
            return "flashback";
        case 15:
            return "desperate times";
        case 6:
            return "end of the road";
        case 29:
            return "elimination 1";
        case 30:
            return "elimination 2";
        case 27:
            return "elimination 3";
        case 21:
            return "showdown 1";
        case 22:
            return "showdown 2";
        case 23:
            return "showdown 3";
        default:
            return "";
    }
}