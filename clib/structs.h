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
	unsigned char P1Coin;
	unsigned char P2Coin;
	unsigned char P3Coin;
	unsigned char P4Coin;
	unsigned char KilledZombie;
	unsigned int E1Start;
	unsigned int E2Start;
	unsigned int E3Start;
	unsigned int E4Start;
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

typedef struct
{
	bool Enabled;
	bool InGame;
    unsigned short HP;
    unsigned short MaxHP;
    unsigned char EnemyType;
    unsigned char NameID;
} Enemy;

char* GetCharacterName(int charType)
{
    switch(charType)
    {
        case 0:
            return "Kevin";//Kevin
        case 1:
            return "Mark";//Mark
        case 2:
            return "Jim";//Jim
        case 3:
            return "George";//George
        case 4:
            return "David";//David
        case 5:
            return "Alyssa";//Alyssa
        case 6:
            return "Yoko";//Yoko
        case 7:
            return "Cindy";//Cindy
        default:
            return "Unknown";//Unknown
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


char* GetEnemyName(int charType)
{
    switch(charType)
    {
        case 0:
            return "Kevin";//Kevin
        case 1:
            return "Mark";//Mark
        case 2:
            return "Jim";//Jim
        case 3:
            return "George";//George
        case 4:
            return "David";//David
        case 5:
            return "Alyssa";//Alyssa
        case 6:
            return "Yoko";//Yoko
        case 7:
            return "Cindy";//Cindy
        default:
            return "Unknown";//Unknown
    }
}

char* GetEnemyName2(int nameID)
{
    switch (nameID)
    {
		case 0:
            return "Licker";
        case 1:
            return "Zombie";
        case 2:
            return "Dog";
        case 3:
            return "Worm";
        case 4:
            return "Mouse";
        case 5:
            return "Crow";
        case 6:
            return "Bee";
        case 7:
            return "Big Spider";
        case 8:
            return "Small Spider";
        case 9:
            return "Moth";
        case 10:
            return "Name10";
        case 11:
            return "Name11";
        case 12:
            return "Name12";
        case 13:
            return "Name13";
        case 14:
            return "Name14";
        case 15:
            return "Nyx-Tyrant";
        case 16:
            return "Alligator";
        case 17:
            return "Name17";
        case 18:
            return "Flea";
        case 19:
            return "Leech Boss";
        case 20:
            return "Licker Boss";
        case 21:
            return "Name21";
        case 22:
            return "Hunter";
        case 23:
            return "Frog";
        case 24:
            return "Name24";
        case 25:
            return "Name25";
        case 26:
            return "Name26";
        case 27:
            return "Leech Man";
        case 28:
            return "Name28";
        case 29:
            return "G Mutant";
        case 30:
            return "G Baby";
        case 31:
            return "Name31";
        case 32:
            return "Elephant";
        case 33:
            return "Lion";
        case 34:
            return "Tentacles";
        case 35:
            return "Name35";
        case 36:
            return "Scissor Tail";//Scissor Tail
        case 37:
            return "Name37";
        case 38:
            return "Name38";
        case 39:
            return "Name39";
        case 40:
            return "Tyrant?";
        case 41:
            return "Tyrant";
        case 42:
            return "Nyx";
        case 43:
            return "Thanatos";
        case 44:
            return "Nyx-Core";
        case 45:
            return "Axeman";
        case 46:
            return "Ivy Plant";
        case 47:
            return "Dorothy";
        case 48:
            return "Giant Wasp";
        case 49:
            return "Hornbill";
        case 50:
            return "Name50";
        case 51:
            return "Name51";
        case 52:
            return "Train";
        case 53:
            return "Box";
        case 54:
            return "Mine";
        case 55:
            return "Leech";
        case 56:
            return "";
        case 57:
            return "Name57";
        case 58:
            return "Gasoline Tank";
        case 59:
            return "Zombie Hands";
        case 60:
            return "Fire";
        case 61:
            return "Name61";
        case 62:
            return "Name62";
        case 63:
            return "Flea Team";
        case 64:
            return "Flea Boss";
        case 65:
            return "Hyena";
        default:
            return NULL;

    }
}
