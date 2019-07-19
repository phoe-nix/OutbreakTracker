#define MAX_ITEM 32
#define MAX_ENEMY 12

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
	unsigned char HostStatus;
	unsigned short HostTime;
	unsigned short HostMaxPlayer;
	unsigned short HostPlayer;
	unsigned short HostDifficulty;
	unsigned short HostScenarioID;
	unsigned short ScenarioID;
	unsigned int FrameCounter;
	unsigned char P1Coin;
	unsigned char P2Coin;
	unsigned char P3Coin;
	unsigned char P4Coin;
	unsigned char KilledZombie;
	unsigned char Pass1;
	unsigned char Pass2;
	unsigned char Pass3;
	unsigned short PassUB1;
	unsigned char PassUB2;
	unsigned short Pass4;
	unsigned char Pass5;
	unsigned char Pass6;
	unsigned char PlayerNum;
	unsigned char Difficulty;
	unsigned int E1Start;
	unsigned int E2Start;
	unsigned int E3Start;
	unsigned int E4Start;
} GameInfo;

typedef struct
{
    unsigned short ID;
    unsigned short EN;
	unsigned short Type;
	unsigned short Count;
	unsigned short Pick;
	unsigned int Present;
	unsigned char Mix;
} Item;

typedef struct
{
    Item RItem [MAX_ITEM];
} RItem;

typedef struct
{
	bool Enabled;
	bool InGame;
    unsigned short HP;
    unsigned short MaxHP;
    unsigned char CharacterType;
    double Virus;
    double CritBonus;
    double Size;
    double Power;
    double Speed;
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
    unsigned char CharacterType;
    unsigned char NPCType;
    double Virus;
    double CritBonus;
    double Size;
    double Power;
    double Speed;
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
} SPlayer;

typedef struct
{
	bool Enabled;
	bool InGame;
    unsigned short HP;
    unsigned short MaxHP;
    unsigned char EnemyType;
    unsigned char NameID;
} Enemy;

typedef struct
{
	bool Enabled;
	bool InGame;
	unsigned short SlotNum;
    unsigned char Status;
    unsigned char Pass;
    unsigned short Player;
    unsigned short MaxPlayer;
	unsigned short ScenarioID;
	unsigned short Version;
} Slot;

char* GetSlotCharacterName(int charType)
{
    switch(charType)
    {
        case 0:
            return "Kevin ";//Kevin
        case 1:
            return "Mark ";//Mark
        case 2:
            return "Jim ";//Jim
        case 3:
            return "George ";//George
        case 4:
            return "David ";//David
        case 5:
            return "Alyssa ";//Alyssa
        case 6:
            return "Yoko ";//Yoko
        case 7:
            return "Cindy ";//Cindy
        default:
            return "Unknown";//Unknown
    }
}

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
        case 7:
            return "Unknown";
        case 8:
            return "LUKE";
        case 9:
            return "Unknown";
        case 10:
            return "ARNOLD";
        case 11:
            return "MATT";
        case 12:
            return "BILLY";
        case 13:
            return "HARSH";
        case 14:
            return "Unknown";
        case 15:
            return "Unknown";
        case 16:
            return "Unknown";
        case 17:
            return "PETER";
        case 18:
            return "MARVIN";
        case 19:
            return "FRED";
        case 20:
            return "ANDY";
        case 21:
            return "Unknown";
        case 22:
            return "JEAN";
        case 23:
            return "TONY";
        case 24:
            return "Unknown";
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
        case 31:
            return "Unknown";
        case 32:
            return "NATHAN";
        case 33:
            return "SAMUEL";
        case 34:
            return "Unknown";
        case 35:
            return "WILL";
        case 36:
            return "Unknown";
        case 37:
            return "ROGER";
        case 38:
            return "Unknown";
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
        case 46:
            return "Unknown";
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
        case 52:
            return "Unknown";
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
        case 58:
            return "Unknown";
        case 59:
            return "MARY";
        case 60:
            return "KATE";
        case 61:
            return "Unknown";
        case 62:
            return "Unknown";
        case 63:
            return "DANNY";
        case 64:
            return "DANNY:B";
        case 65:
            return "GILL";
        case 66:
            return "GILL:B";
        case 67:
            return "Unknown";
        case 68:
            return "Unknown";
        case 69:
            return "Unknown";
        case 70:
            return "Unknown";
        case 71:
            return "Unknown";
        case 72:
            return "Unknown";
        case 73:
            return "Unknown";
        case 74:
            return "KEITH";
        case 75:
            return "Unknown";
        case 76:
            return "Unknown";
        case 77:
            return "Unknown";
        case 78:
            return "Unknown";
        case 79:
            return "Unknown";
        case 80:
            return "Unknown";
        case 81:
            return "KURT";
        case 82:
            return "KURT:B";
        case 83:
            return "GARY:B";
        case 84:
            return "AL:C";
        case 85:
            return "Unknown";
        case 86:
            return "Unknown";
        case 87:
            return "DOROTHY";
        case 88:
            return "Unknown";
        case 89:
            return "Unknown";
        case 90:
            return "Unknown";
        case 91:
            return "YOKO:Z";
        case 92:
            return "Unknown";
        case 93:
            return "Unknown";
        case 94:
            return "Unknown";
        case 95:
            return "Unknown";
        case 96:
            return "Unknown";
        case 97:
            return "Unknown";
        case 98:
            return "Unknown";
        case 99:
            return "Unknown";
        case 100:
            return "Unknown";
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
        case 115:
            return "Unknown";
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
        case 132:
            return "Unknown";
        case 133:
            return "HOWARD";
        case 134:
            return "Unknown";
        case 135:
            return "ISAAC";
        case 136:
            return "Unknown";
        case 137:
            return "KATHY";
        case 138:
            return "Unknown";
        case 139:
            return "ELENA";
        case 140:
            return "Unknown";
        case 141:
            return "FRANK";
        case 142:
            return "Unknown";
        case 143:
            return "Unknown";
        case 144:
            return "Unknown";
        case 145:
            return "Unknown";
        case 146:
            return "Unknown";
        case 147:
            return "Unknown";
        case 148:
            return "Unknown";
        case 149:
            return "Unknown";
        case 150:
            return "Unknown";
        case 151:
            return "RODNEY";
        default:
            return NULL;

    }
}

char* GetDifficultyName(unsigned short Difficulty)
{
    switch (Difficulty)
    {
        case 0:
            return "easy";
        case 1:
            return "normal";
        case 2:
            return "hard";
        case 3:
            return "very hard";

        default:
            return "";
    }
}

char* GetF1LobScenarioName(unsigned short F1LobScenarioID)
{
    switch (F1LobScenarioID)
    {
        case 0:
            return "outbreak";
        case 1:
            return "below freezing point";
        case 2:
            return "the hive";
        case 3:
            return "hellfire";
        case 4:
            return "decisions,decisions";
        default:
            return "";
    }
}

char* GetF2LobScenarioName(unsigned short F2LobScenarioID)
{
    switch (F2LobScenarioID)
    {
        case 0:
            return "training ground";
        case 1:
            return "wild things";
        case 2:
            return "underbelly";
        case 3:
            return "flashback";
        case 4:
            return "desperate times";
        case 5:
            return "end of the road";
        case 6:
            return "elimination 1";
        case 7:
            return "elimination 2";
        case 8:
            return "elimination 3";
        case 9:
            return "showdown 1";
        case 10:
            return "showdown 2";
        case 11:
            return "showdown 3";
        default:
            return "";
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
            return "Mouse";//invincible
        case 5:
            return "Crow";
        case 6:
            return "Giant Wasp";//poison
        case 7:
            return "Spider";
        case 8:
            return "ID:8";
        case 9:
            return "Giant Moth";
        case 10:
            return "Caterpillar";//caterpillar
        case 11:
            return "Drainer";//invincible
        case 12:
            return "Drainer";//invincible
        case 13:
            return "Evil Shade";//poison
        case 14:
            return "Drainer";//
        case 15:
            return "Nyx-Tyrant";
        case 16:
            return "Gnaw";//Alligator
        case 17:
            return "ID:17";//f1 outbreak
        case 18:
            return "Megabyte";//Flea
        case 19:
            return "G.Leech";//Leech Boss
        case 20:
            return "Suspended";//Licker Boss
        case 21:
            return "ID:21";
        case 22:
            return "Hunter";
        case 23:
            return "Hunter γ";//Frog
        case 24:
            return "ID:24";
        case 25:
            return "ID:25";
        case 26:
            return "Neptune";//invincible
        case 27:
            return "Leechman";
        case 28:
            return "ID:28";
        case 29:
            return "G-Mutant";
        case 30:
            return "G-Embyro";
        case 31:
            return "ID:31";
        case 32:
            return "Titan";//Elephant
        case 33:
            return "Lion";
        case 34:
            return "Tentacles";
        case 35:
            return "Ivy Plant";
        case 36:
            return "Sci.Tail";//Scissor Tail
        case 37:
            return "ID:37";//f1 outbreak
        case 38:
            return "ID:38";
        case 39:
            return "ID:39";
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
            return "Rafflesia";
        case 47:
            return "Dorothy";
        case 48:
            return "Flying Bug";
        case 49:
            return "Hornbill";
        case 50:
            return "ID:50";
        case 51:
            return "\"Dorothy\"";
        case 52:
            return "Train";
        case 53:
            return "Box";
        case 54:
            return "Mine";
        case 55:
            return "Leech";
        case 56:
            return "ID:56";//
        case 57:
            return "Sniper";
        case 58:
            return "Gas.Tank";//Gasoline Tank
        case 59:
            return "Hands";//Zombie Hands
        case 60:
            return "Fire";
        case 61:
            return "Typewriter";
        case 62:
            return "ID:62";
        case 63:
            return "Megabytes";//Flea Team
        case 64:
            return "Gigabyte";//Flea Boss
        case 65:
            return "Hyena";
        default:
            return "Unknown";

    }
}
