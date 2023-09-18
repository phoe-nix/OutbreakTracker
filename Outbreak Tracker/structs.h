#define MAX_PLAYER_SLOTS 4
#define MAX_ITEM 32
#define MAX_ENEMY 12
#define MAX_DOOR 19

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
        lua_pushstring(L, "pick"); \
            lua_pushnumber(L, (double)sd.Pick); \
        lua_rawset(L, -3); \
        lua_pushstring(L, "present"); \
            lua_pushnumber(L, (double)sd.Present); \
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
        lua_pushstring(L, "pick"); \
            lua_pushnumber(L, 0); \
        lua_rawset(L, -3); \
        lua_pushstring(L, "present"); \
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
	unsigned char Cleared;
	unsigned short WTTime;
	unsigned short EscapeTime;
	unsigned int FightTime;
	unsigned short FightTime2;
	unsigned int GarageTime;
	unsigned int GasTime;
	unsigned int GasFlag;
	unsigned char GasRandom;
	unsigned char ItemRandom;
	unsigned char ItemRandom2;
	unsigned char PuzzleRandom;
	unsigned char Coin;
	unsigned char KilledZombie;
	unsigned char PlayerNum;
	unsigned short PassDT1;
	unsigned char PassWT;
	unsigned char PassDT2;
	unsigned char PassDT3;
	unsigned char Pass1;
	unsigned char Pass2;
	unsigned char Pass3;
	unsigned short PassUB1;
	unsigned char PassUB2;
	unsigned char PassUB3;
	unsigned short Pass4;
	unsigned char Pass5;
	unsigned char Pass6;
	unsigned char Difficulty;
	unsigned int E1Start;
	unsigned int E2Start;
	unsigned int E3Start;
	unsigned int E4Start;
} GameInfo;

typedef struct
{
	unsigned char Number;
    unsigned short ID;
    unsigned short EN;
	unsigned short Type;
	unsigned short Count;
	unsigned short Pick;
	unsigned int Present;
	unsigned char Mix;
	unsigned char RoomID;
} Item;

typedef struct
{
	bool Enabled;
	bool InGame;
    unsigned char Number;
    unsigned char Flag;
    unsigned short HP;
    unsigned short MaxHP;
    unsigned char BossType;
    unsigned char NameID;
	unsigned char RoomID;
    unsigned char Type;
    unsigned char Status;
} Enemy2;

typedef struct
{
    Item RItem [MAX_ITEM];
} RItem;

typedef struct
{
    char RoomMaster;
} RoomPriority;

typedef struct
{
    bool Enabled;
    RoomPriority Room [128];
} RoomsType;

typedef struct
{
	bool Enabled;
	bool InGame;
    unsigned short HP;
    unsigned short MaxHP;
    unsigned short BleedTime;
    unsigned short AntiVirusTime;
    unsigned short AntiVirusGTime;
    unsigned short HerbTime;
    unsigned char CharacterType;
    double Virus;
    double CritBonus;
    double Size;
    double Power;
    double Speed;
    double PositionX;
    double PositionY;
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
	unsigned short HP;
	unsigned short Flag;
} Door;

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

char* GetCharacterNameF1(int charType)
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

char* GetF1NPCName(int nameID)
{
    switch (nameID)
    {
        case 1:
            return "MACDOWELL";//HPtype3
        case 2:
            return "RODRIGUEZ";//HPtype4
        case 3:
            return "CONRAD";//HPtype2
        case 4:
            return "HUNK:B";//HPtype3
        case 5:
            return "HUNK";//HPtype5
        case 6:
            return "MIGUEL";//HPtype3
        case 7:
            return "Unknown";
        case 8:
            return "LUKE";//HPtype4
        case 9:
            return "Unknown";
        case 10:
            return "ARNOLD";//HPtype5
        case 11:
            return "MATT";//HPtype2
        case 12:
            return "BILLY";//HPtype3
        case 13:
            return "HARSH";//HPtype3
        case 14:
            return "Unknown";//
        case 15:
            return "Unknown";//HARSH?
        case 16:
            return "Unknown";//zombie?
        case 17:
            return "PETER";//HPtype3
        case 18:
            return "MARVIN";//HPtype3
        case 19:
            return "FRED";//HPtype2
        case 20:
            return "ANDY";//HPtype3
        case 21:
            return "Unknown";//MARVIN
        case 22:
            return "JEAN";//HPtype4
        case 23:
            return "TONY";//HPtype4
        case 24:
            return "Unknown";//MAN
        case 25:
            return "PATRICK";//HPtype3
        case 26:
            return "LLOYD";//HPtype3
        case 27:
            return "AUSTIN";//HPtype3
        case 28:
            return "CLINT";//HPtype4
        case 29:
            return "BONE";//HPtype2
        case 30:
            return "BOB";//HPtype5
        case 31:
            return "Unknown";//MAN
        case 32:
            return "NATHAN";//HPtype3
        case 33:
            return "SAMUEL";//HPtype4
        case 34:
            return "Unknown";//bug
        case 35:
            return "WILL";//HPtype2
        case 36:
            return "Unknown";//WILL:B
        case 37:
            return "ROGER";//HPtype3
        case 38:
            return "Unknown";//bug
        case 39:
            return "CARTER";//HPtype3
        case 40:
            return "GREG";//HPtype6
        case 41:
            return "FROST";//HPtype4
        case 42:
            return "FROST:B";//HPtype3
        case 43:
            return "JAKE";//HPtype1
        case 44:
            return "GARY";//HPtype3
        case 45:
            return "RICHARD";//HPtype4
        case 46:
            return "Unknown";//MICK
        case 47:
            return "MICKEY";//HPtype2
        case 48:
            return "AL";//HPtype3
        case 49:
            return "AXEMAN ";//HPtype5
        case 50:
            return "AL:B";//HPtype2
        case 51:
            return "BEN";//HPtype3
        case 52:
            return "Unknown";//regan's daughter
        case 53:
            return "REGAN";//HPtype3
        case 54:
            return "REGAN:B";//HPtype3
        case 55:
            return "MONICA";//HPtype2
        case 56:
            return "LINDA";//HPtype2
        case 57:
            return "RITA";//HPtype4
        case 58:
            return "Unknown";//bug
        case 59:
            return "MARY";//HPtype3
        case 60:
            return "KATE";//HPtype3
        case 61:
            return "Unknown";//bug
        case 62:
            return "Unknown";//bug
        case 63:
            return "DANNY";//HPtype4
        case 64:
            return "DANNY:B";//HPtype5
        case 65:
            return "GILL";//HPtype2
        case 66:
            return "GILL:B";//HPtype3
        case 67:
            return "Unknown";//none
        case 68:
            return "Unknown";//none
        case 69:
            return "Unknown";//none
        case 70:
            return "Unknown";//docter
        case 71:
            return "Unknown";//none
        case 72:
            return "Unknown";//none
        case 73:
            return "Unknown";//cindy
        case 74:
            return "KEITH";//HPtype4
        case 75:
            return "Unknown";//none
        case 76:
            return "Unknown";//none
        case 77:
            return "Unknown";//none
        case 78:
            return "Unknown";//none
        case 79:
            return "Unknown";//none
        case 80:
            return "Unknown";//none
        case 81:
            return "KURT";//HPtype3
        case 82:
            return "KURT:B";//HPtype3
        case 83:
            return "GARY:B";//HPtype3
        case 84:
            return "AL:C";//HPtype3
        case 85:
            return "Unknown";//none
        case 86:
            return "Unknown";//none
        case 87:
            return "DOROTHY";//HPtype5
        case 88:
            return "Unknown";//none
        case 89:
            return "Unknown";//none
        case 90:
            return "Unknown";//none
        case 91:
            return "YOKO:Z";//HPtype4
        case 92:
            return "Unknown";//none
        case 93:
            return "Unknown";//none
        case 94:
            return "Unknown";//none
        case 95:
            return "Unknown";//none
        case 96:
            return "Unknown";//none
        case 97:
            return "Unknown";//none
        case 98:
            return "Unknown";//none
        case 99:
            return "Unknown";//none
        case 100:
            return "Unknown";//mr.grey
        case 101:
            return "RAYMOND";//HPtype3
        case 102:
            return "ARTHUR";//HPtype2
        case 103:
            return "AARON";//HPtype5
        case 104:
            return "DORIAN";//HPtype3
        case 105:
            return "ELLIOTT";//HPtype4
        case 106:
            return "ERIC";//HPtype2
        case 107:
            return "HARRY";//HPtype2
        case 108:
            return "Mr.RED";//HPtype0
        case 109:
            return "Mr.BLUE";//HPtype0
        case 110:
            return "Mr.GREEN";//HPtype6
        case 111:
            return "Mr.GOLD";//HPtype6
        case 112:
            return "Mr.BLACK";//HPtype6
        case 113:
            return "KARL";//HPtype5
        case 114:
            return "DUSTIN";//HPtype4
        case 115:
            return "Unknown";//UBCS
        case 116:
            return "DEREK";//HPtype3
        case 117:
            return "Ms.WHITE";//HPtype0
        case 118:
            return "Ms.PEACH";//HPtype6
        case 119:
            return "Ms.WATER";//HPtype6
        case 120:
            return "LEN";//HPtype4
        case 121:
            return "NICOLAS";//HPtype3
        case 122:
            return "SEAN";//HPtype5
        case 123:
            return "PHILIP";//HPtype4
        case 124:
            return "DON";//HPtype3
        case 125:
            return "MATTHEW";//HPtype3
        case 126:
            return "ROBERT";//HPtype4
        case 127:
            return "CHUCK";//HPtype2
        case 128:
            return "GINGER";//HPtype4
        case 129:
            return "LAURA";//HPtype2
        case 130:
            return "AMELIA";//HPtype3
        case 131:
            return "ETHAN";//HPtype2
        case 132:
            return "Unknown";//ETHAN:B
        case 133:
            return "HOWARD";//HPtype3
        case 134:
            return "Unknown";//HOWARD
        case 135:
            return "ISAAC";//HPtype4
        case 136:
            return "ISAAC:B";//ISAAC:B
        case 137:
            return "KATHY";//HPtype2
        case 138:
            return "KATHY:B";//KATHY
        case 139:
            return "ELENA";//HPtype4
        case 140:
            return "ELENA:B";//ELENA
        case 141:
            return "FRANK";//HPtype4
        case 142:
            return "KATHY:C";//GOLDEN WOMAN
        case 143:
            return "Unknown";//none
        case 144:
            return "Unknown";//none
        case 145:
            return "Unknown";//none
        case 146:
            return "Unknown";//none
        case 147:
            return "Unknown";//none
        case 148:
            return "Unknown";//none
        case 149:
            return "Unknown";//none
        case 150:
            return "Unknown";//none
        case 151:
            return "RODNEY";//HPtype2
        case 201:
            return "Kevin";//none
        case 202:
            return "Mark";//none
        case 203:
            return "Jim";//none
        case 204:
            return "George";//none
        case 205:
            return "David";//none
        case 206:
            return "Alyssa";//none
        case 207:
            return "Yoko";//none
        case 208:
            return "Cindy";//none
        default:
            return NULL;

    }
}

char* GetNPCName(int nameID)
{
    switch (nameID)
    {
        case 1:
            return "MACDOWELL";//HPtype3
        case 2:
            return "RODRIGUEZ";//HPtype4
        case 3:
            return "CONRAD";//HPtype2
        case 4:
            return "HUNK:B";//HPtype3
        case 5:
            return "HUNK";//HPtype5
        case 6:
            return "MIGUEL";//HPtype3
        case 7:
            return "Unknown";
        case 8:
            return "LUKE";//HPtype4
        case 9:
            return "Unknown";
        case 10:
            return "ARNOLD";//HPtype5
        case 11:
            return "MATT";//HPtype2
        case 12:
            return "BILLY";//HPtype3
        case 13:
            return "HARSH";//HPtype3
        case 14:
            return "Unknown";//HARSH:B
        case 15:
            return "Unknown";//HARSH:C
        case 16:
            return "Unknown";//zombie?
        case 17:
            return "PETER";//HPtype3
        case 18:
            return "MARVIN";//HPtype3
        case 19:
            return "FRED";//HPtype2
        case 20:
            return "ANDY";//HPtype3
        case 21:
            return "Unknown";//MARVIN:B
        case 22:
            return "JEAN";//HPtype4
        case 23:
            return "TONY";//HPtype4
        case 24:
            return "Unknown";//PATRICK:B
        case 25:
            return "PATRICK";//HPtype3
        case 26:
            return "LLOYD";//HPtype3
        case 27:
            return "AUSTIN";//HPtype3
        case 28:
            return "CLINT";//HPtype4
        case 29:
            return "BONE";//HPtype2
        case 30:
            return "BOB";//HPtype5
        case 31:
            return "Unknown";//FIRST LEECHMAN
        case 32:
            return "NATHAN";//HPtype3
        case 33:
            return "SAMUEL";//HPtype4
        case 34:
            return "Unknown";//bug
        case 35:
            return "WILL";//HPtype2
        case 36:
            return "Unknown";//WILL:B
        case 37:
            return "ROGER";//HPtype3
        case 38:
            return "Unknown";//bug
        case 39:
            return "CARTER";//HPtype3
        case 40:
            return "GREG";//HPtype6
        case 41:
            return "FROST";//HPtype4
        case 42:
            return "FROST:B";//HPtype3
        case 43:
            return "JAKE";//HPtype1
        case 44:
            return "GARY";//HPtype3
        case 45:
            return "RICHARD";//HPtype4
        case 46:
            return "Unknown";//MICKEY:B
        case 47:
            return "MICKEY";//HPtype2
        case 48:
            return "AL";//HPtype3
        case 49:
            return "AXEMAN";//HPtype5
        case 50:
            return "AL:B";//HPtype2
        case 51:
            return "BEN";//HPtype3
        case 52:
            return "Unknown";//LUCY
        case 53:
            return "REGAN";//HPtype3
        case 54:
            return "REGAN:B";//HPtype3
        case 55:
            return "MONICA";//HPtype2
        case 56:
            return "LINDA";//HPtype2
        case 57:
            return "RITA";//HPtype4
        case 58:
            return "Unknown";//bug
        case 59:
            return "MARY";//HPtype3
        case 60:
            return "KATE";//HPtype3
        case 61:
            return "Unknown";//bug
        case 62:
            return "Unknown";//bug
        case 63:
            return "DANNY";//HPtype4
        case 64:
            return "DANNY:B";//HPtype5
        case 65:
            return "GILL";//HPtype2
        case 66:
            return "GILL:B";//HPtype3
        case 67:
            return "Unknown";//none
        case 68:
            return "Unknown";//none
        case 69:
            return "Unknown";//none
        case 70:
            return "Unknown";//docter
        case 71:
            return "Unknown";//none
        case 72:
            return "Unknown";//none
        case 73:
            return "Unknown";//cindy
        case 74:
            return "KEITH";//HPtype4
        case 75:
            return "Unknown";//none
        case 76:
            return "Unknown";//none
        case 77:
            return "Unknown";//none
        case 78:
            return "Unknown";//none
        case 79:
            return "Unknown";//none
        case 80:
            return "Unknown";//none
        case 81:
            return "KURT";//HPtype3
        case 82:
            return "KURT:B";//HPtype3
        case 83:
            return "GARY:B";//HPtype3
        case 84:
            return "AL:C";//HPtype3
        case 85:
            return "Unknown";//none
        case 86:
            return "Unknown";//none
        case 87:
            return "DOROTHY";//HPtype5
        case 88:
            return "Unknown";//none
        case 89:
            return "Unknown";//none
        case 90:
            return "Unknown";//none
        case 91:
            return "YOKO:Z";//HPtype4
        case 92:
            return "Unknown";//none
        case 93:
            return "Unknown";//none
        case 94:
            return "Unknown";//none
        case 95:
            return "Unknown";//none
        case 96:
            return "Unknown";//none
        case 97:
            return "Unknown";//none
        case 98:
            return "Unknown";//none
        case 99:
            return "Unknown";//none
        case 100:
            return "Unknown";//MR.GREY
        case 101:
            return "RAYMOND";//HPtype3
        case 102:
            return "ARTHUR";//HPtype2
        case 103:
            return "AARON";//HPtype5
        case 104:
            return "DORIAN";//HPtype3
        case 105:
            return "ELLIOTT";//HPtype4
        case 106:
            return "ERIC";//HPtype2
        case 107:
            return "HARRY";//HPtype2
        case 108:
            return "Mr.RED";//HPtype0
        case 109:
            return "Mr.BLUE";//HPtype0
        case 110:
            return "Mr.GREEN";//HPtype6
        case 111:
            return "Mr.GOLD";//HPtype6
        case 112:
            return "Mr.BLACK";//HPtype6
        case 113:
            return "KARL";//HPtype5
        case 114:
            return "DUSTIN";//HPtype4
        case 115:
            return "Unknown";//CECIL
        case 116:
            return "DEREK";//HPtype3
        case 117:
            return "Ms.WHITE";//HPtype0
        case 118:
            return "Ms.PEACH";//HPtype6
        case 119:
            return "Ms.WATER";//HPtype6
        case 120:
            return "LEN";//HPtype4
        case 121:
            return "NICOLAS";//HPtype3
        case 122:
            return "SEAN";//HPtype5
        case 123:
            return "PHILIP";//HPtype4
        case 124:
            return "DON";//HPtype3
        case 125:
            return "MATTHEW";//HPtype3
        case 126:
            return "ROBERT";//HPtype4
        case 127:
            return "CHUCK";//HPtype2
        case 128:
            return "GINGER";//HPtype4
        case 129:
            return "LAURA";//HPtype2
        case 130:
            return "AMELIA";//HPtype3
        case 131:
            return "ETHAN";//HPtype2
        case 132:
            return "Unknown";//ETHAN:B
        case 133:
            return "HOWARD";//HPtype3
        case 134:
            return "Unknown";//HOWARD:B
        case 135:
            return "ISAAC";//HPtype4
        case 136:
            return "Unknown";//ISAAC:B
        case 137:
            return "KATHY";//HPtype2
        case 138:
            return "Unknown";//KATHY:B
        case 139:
            return "ELENA";//HPtype4
        case 140:
            return "Unknown";//ELENA:B
        case 141:
            return "FRANK";//HPtype4
        case 142:
            return "Unknown";//GOLDEN WOMAN
        case 143:
            return "Unknown";//none
        case 144:
            return "Unknown";//none
        case 145:
            return "Unknown";//none
        case 146:
            return "Unknown";//none
        case 147:
            return "Unknown";//none
        case 148:
            return "Unknown";//none
        case 149:
            return "Unknown";//none
        case 150:
            return "Unknown";//none
        case 151:
            return "RODNEY";//HPtype2
        case 201:
            return "Kevin";//none
        case 202:
            return "Mark";//none
        case 203:
            return "Jim";//none
        case 204:
            return "George";//none
        case 205:
            return "David";//none
        case 206:
            return "Alyssa";//none
        case 207:
            return "Yoko";//none
        case 208:
            return "Cindy";//none
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

char* GetZombieName(int charType)
{
    switch(charType)
    {
        //case 18:
        //    return "Amelia";
        case 31:
            return "G.Zombie";//GreenZombie
        case 70:
            return "Kevin";
        case 71:
            return "Mark";
        case 72:
            return "Jim";
        case 73:
            return "George";
        case 74:
            return "David";
        case 75:
            return "Alyssa";
        case 76:
            return "Yoko";
        case 77:
            return "Cindy";
        case 80:
            return "Bob";
        case 85:
            return "Will";
        default:
            return "Zombie";
    }
}
char* GetDogName(int charType)
{
    switch(charType)
    {
        case 1:
            return "Cerberus";//GreenZombie
        case 4:
            return "Shepherd";//Shepherd Dog
        default:
            return "Dog";
    }
}
char* GetSTName(int charType)
{
    switch(charType)
    {
        case 0:
            return "Sci.Tail";//Scissor Tail
        case 1:
            return "Sci.Tail P";//Scissor Tail Purple
        default:
            return "Sci.Tail";
    }
}
char* GetLionName(int charType)
{
    switch(charType)
    {
        case 0:
            return "Stalker";
        case 1:
            return "Feral";
        default:
            return "Lion";
    }
}
char* GetTyrantName(int charType)
{
    switch(charType)
    {
        case 0:
            return "Tyrant";
        case 1:
            return "Tyrant R";
        case 3:
            return "Tyrant C";
        default:
            return "Tyrant";
    }
}
char* GetThanatosName(int charType)
{
    switch(charType)
    {
        case 0:
            return "Thanatos";//Scissor Tail
        case 1:
            return "Thanatos R";//Scissor Tail Purple
        default:
            return "Thanatos";
    }
}
//dog: White dog4, Cerberus1
//lion: Stalker, Feral
//licker: Licker1
//Thanatos: Thanatos, Thanatos R
//Tyrant: Tyrant, Tyrant R, Tyrant C
//megabyte:0, purple1
//Scissor Tail: 0,purple1
char* GetEnemyName(int nameID)
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
            return "L.Tentacles";//Leech Tentacles
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

char* GetCharacterHP(int charType)
{
    switch(charType)
    {
        case 0:
            return "2300/2300 ";//Kevin
        case 1:
            return "3000/3000 ";//Mark
        case 2:
            return "1800/1800 ";//Jim
        case 3:
            return "2100/2100 ";//George
        case 4:
            return "2200/2200 ";//David
        case 5:
            return "2000/2000 ";//Alyssa
        case 6:
            return "1300/1300 ";//Yoko
        case 7:
            return "1500/1500 ";//Cindy
        default:
            return "Unknown";//Unknown
    }
}

char* GetNPCHP(int charType)
{
    switch (charType)
    {
        case 1:
            return "2000~2500";//110
        case 2:
            return "2600~3000";//118
        case 3:
            return "1300~1600";//100
        case 4:
            return "2000~2500";//130
        case 5:
            return "3100~3500";//130
        case 6:
            return "2000~2500";//130
        case 7:
            return "Unknown";
        case 8:
            return "2600~3000";//110
        case 9:
            return "Unknown";
        case 10:
            return "3100~3500";//122
        case 11:
            return "1300~1600";//97
        case 12:
            return "2000~2500";//82
        case 13:
            return "2000~2500";//90
        case 14:
            return "Unknown";//
        case 15:
            return "Unknown";//HARSH?
        case 16:
            return "Unknown";//zombie?
        case 17:
            return "2000~2500";//118
        case 18:
            return "2000~2500";//100
        case 19:
            return "1300~1600";//100
        case 20:
            return "2000~2500";//83
        case 21:
            return "Unknown";//MARVIN
        case 22:
            return "2600~3000";//92
        case 23:
            return "2600~3000";//91
        case 24:
            return "Unknown";//MAN
        case 25:
            return "2000~2500";//100
        case 26:
            return "2000~2500";//95
        case 27:
            return "2000~2500";//88
        case 28:
            return "2600~3000";//110
        case 29:
            return "1300~1600";//100
        case 30:
            return "3100~3500";//98
        case 31:
            return "Unknown";//MAN
        case 32:
            return "2000~2500";//112
        case 33:
            return "2600~3000";//118
        case 34:
            return "Unknown";//bug
        case 35:
            return "1300~1600";//97
        case 36:
            return "Unknown";//MAN
        case 37:
            return "2000~2500";//100
        case 38:
            return "Unknown";//bug
        case 39:
            return "2000~2500";//92
        case 40:
            return "3600~4000";//85
        case 41:
            return "2600~3000";//96
        case 42:
            return "2000~2500";//100
        case 43:
            return "900~1200";//87
        case 44:
            return "2000~2500";//99
        case 45:
            return "2600~3000";//100
        case 46:
            return "Unknown";//MICK
        case 47:
            return "1300~1600";//93
        case 48:
            return "2000~2500";//87
        case 49:
            return "3100~3500";//138
        case 50:
            return "1300~1600";//114
        case 51:
            return "2000~2500";//107
        case 52:
            return "Unknown";//regan's daughter
        case 53:
            return "2000~2500";//100
        case 54:
            return "2000~2500";//82
        case 55:
            return "1300~1600";//98
        case 56:
            return "1300~1600";//96
        case 57:
            return "2600~3000";//113
        case 58:
            return "Unknown";//bug
        case 59:
            return "2000~2500";//97
        case 60:
            return "2000~2500";//89
        case 61:
            return "Unknown";//bug
        case 62:
            return "Unknown";//bug
        case 63:
            return "2600~3000";//112
        case 64:
            return "3100~3500";//116
        case 65:
            return "1300~1600";//96
        case 66:
            return "2000~2500";//97
        case 67:
            return "Unknown";//none
        case 68:
            return "Unknown";//none
        case 69:
            return "Unknown";//none
        case 70:
            return "Unknown";//docter
        case 71:
            return "Unknown";//none
        case 72:
            return "Unknown";//none
        case 73:
            return "Unknown";//cindy
        case 74:
            return "2600~3000";//92
        case 75:
            return "Unknown";//none
        case 76:
            return "Unknown";//none
        case 77:
            return "Unknown";//none
        case 78:
            return "Unknown";//none
        case 79:
            return "Unknown";//none
        case 80:
            return "Unknown";//none
        case 81:
            return "2000~2500";//100
        case 82:
            return "2000~2500";//97
        case 83:
            return "2000~2500";//100
        case 84:
            return "2000~2500";//100
        case 85:
            return "Unknown";//none
        case 86:
            return "Unknown";//none
        case 87:
            return "3100~3500";//83
        case 88:
            return "Unknown";//none
        case 89:
            return "Unknown";//none
        case 90:
            return "Unknown";//none
        case 91:
            return "2600~3000";//94
        case 92:
            return "Unknown";//none
        case 93:
            return "Unknown";//none
        case 94:
            return "Unknown";//none
        case 95:
            return "Unknown";//none
        case 96:
            return "Unknown";//none
        case 97:
            return "Unknown";//none
        case 98:
            return "Unknown";//none
        case 99:
            return "Unknown";//none
        case 100:
            return "Unknown";//mr.grey
        case 101:
            return "2000~2500";//102
        case 102:
            return "1300~1600";//100
        case 103:
            return "3100~3500";//121
        case 104:
            return "2000~2500";//105
        case 105:
            return "2600~3000";//119
        case 106:
            return "1300~1600";//115
        case 107:
            return "1300~1600";//84
        case 108:
            return "500~800";//150
        case 109:
            return "500~800";//80
        case 110:
            return "3600~4000";//100
        case 111:
            return "3600~4000";//150
        case 112:
            return "3600~4000";//132
        case 113:
            return "3100~3500";//118
        case 114:
            return "2600~3000";//121
        case 115:
            return "Unknown";//UBCS
        case 116:
            return "2000~2500";//109
        case 117:
            return "500~800";//135
        case 118:
            return "3600~4000";//100
        case 119:
            return "3600~4000";//75
        case 120:
            return "2600~3000";//111
        case 121:
            return "2000~2500";//96
        case 122:
            return "3100~3500";//112
        case 123:
            return "2600~3000";//97
        case 124:
            return "2000~2500";//87
        case 125:
            return "2000~2500";//100
        case 126:
            return "2600~3000";//109
        case 127:
            return "1300~1600";//100
        case 128:
            return "2600~3000";//113
        case 129:
            return "1300~1600";//100
        case 130:
            return "2000~2500";//100
        case 131:
            return "1300~1600";//88
        case 132:
            return "Unknown";//ETHAN
        case 133:
            return "2000~2500";//100
        case 134:
            return "Unknown";//HOWARD
        case 135:
            return "2600~3000";//113
        case 136:
            return "Unknown";//ISAAC
        case 137:
            return "1300~1600";//97
        case 138:
            return "Unknown";//KATHY
        case 139:
            return "2600~3000";//84
        case 140:
            return "Unknown";//ELENA
        case 141:
            return "2600~3000";//91
        case 142:
            return "Unknown";//GOLDEN WOMAN
        case 143:
            return "Unknown";//none
        case 144:
            return "Unknown";//none
        case 145:
            return "Unknown";//none
        case 146:
            return "Unknown";//none
        case 147:
            return "Unknown";//none
        case 148:
            return "Unknown";//none
        case 149:
            return "Unknown";//none
        case 150:
            return "Unknown";//none
        case 151:
            return "1300~1600";//94
        case 201:
            return "Unknown";//none
        case 202:
            return "Unknown";//none
        case 203:
            return "Unknown";//none
        case 204:
            return "Unknown";//none
        case 205:
            return "Unknown";//none
        case 206:
            return "Unknown";//none
        case 207:
            return "Unknown";//none
        case 208:
            return "Unknown";//none
        default:
            return NULL;

    }
}

char* GetCharacterPower(int charType)
{
    switch(charType)
    {
        case 0:
            return "100%";//Kevin
        case 1:
            return "100%";//Mark
        case 2:
            return "100%";//Jim
        case 3:
            return "100%";//George
        case 4:
            return "100%";//David
        case 5:
            return "100%";//Alyssa
        case 6:
            return "100%";//Yoko
        case 7:
            return "100%";//Cindy
        default:
            return "Unknown";//Unknown
    }
}

char* GetNPCPower(int charType)
{
    switch (charType)
    {
        case 1:
            return "110%";//110%
        case 2:
            return "118%";//118%
        case 3:
            return "100%";//100%
        case 4:
            return "130%";//130%
        case 5:
            return "130%";//130%
        case 6:
            return "105%";//105%
        case 7:
            return "Unknown";
        case 8:
            return "110%";//110%
        case 9:
            return "Unknown";
        case 10:
            return "122%";//122%
        case 11:
            return "97%";//97%
        case 12:
            return "82%";//82%
        case 13:
            return "90%";//90%
        case 14:
            return "Unknown";//
        case 15:
            return "Unknown";//HARSH?
        case 16:
            return "Unknown";//zombie?
        case 17:
            return "118%";//118%
        case 18:
            return "100%";//100%
        case 19:
            return "100%";//100%
        case 20:
            return "83%";//83%
        case 21:
            return "Unknown";//MARVIN
        case 22:
            return "92%";//92%
        case 23:
            return "91%";//91%
        case 24:
            return "Unknown";//MAN
        case 25:
            return "100%";//100%
        case 26:
            return "95%";//95%
        case 27:
            return "88%";//88%
        case 28:
            return "110%";//110%
        case 29:
            return "100%";//100%
        case 30:
            return "98%";//98%
        case 31:
            return "Unknown";//MAN
        case 32:
            return "112%";//112%
        case 33:
            return "118%";//118%
        case 34:
            return "Unknown";//bug
        case 35:
            return "97%";//97%
        case 36:
            return "Unknown";//MAN
        case 37:
            return "100%";//100%
        case 38:
            return "Unknown";//bug
        case 39:
            return "92%";//92%
        case 40:
            return "85%";//85%
        case 41:
            return "96%";//96%
        case 42:
            return "100%";
        case 43:
            return "87%";
        case 44:
            return "99%";
        case 45:
            return "100%";
        case 46:
            return "Unknown";//MICK
        case 47:
            return "93%";
        case 48:
            return "87%";
        case 49:
            return "138%";
        case 50:
            return "114%";
        case 51:
            return "107%";
        case 52:
            return "Unknown";//regan's daughter
        case 53:
            return "100%";
        case 54:
            return "82%";
        case 55:
            return "98%";
        case 56:
            return "96%";
        case 57:
            return "113%";
        case 58:
            return "Unknown";//bug
        case 59:
            return "97%";
        case 60:
            return "89%";
        case 61:
            return "Unknown";//bug
        case 62:
            return "Unknown";//bug
        case 63:
            return "112%";
        case 64:
            return "116%";
        case 65:
            return "96%";
        case 66:
            return "97%";
        case 67:
            return "Unknown";//none
        case 68:
            return "Unknown";//none
        case 69:
            return "Unknown";//none
        case 70:
            return "Unknown";//docter
        case 71:
            return "Unknown";//none
        case 72:
            return "Unknown";//none
        case 73:
            return "Unknown";//cindy
        case 74:
            return "92%";
        case 75:
            return "Unknown";//none
        case 76:
            return "Unknown";//none
        case 77:
            return "Unknown";//none
        case 78:
            return "Unknown";//none
        case 79:
            return "Unknown";//none
        case 80:
            return "Unknown";//none
        case 81:
            return "100%";
        case 82:
            return "97%";
        case 83:
            return "100%";
        case 84:
            return "100%";
        case 85:
            return "Unknown";//none
        case 86:
            return "Unknown";//none
        case 87:
            return "83%";
        case 88:
            return "Unknown";//none
        case 89:
            return "Unknown";//none
        case 90:
            return "Unknown";//none
        case 91:
            return "94%";
        case 92:
            return "Unknown";//none
        case 93:
            return "Unknown";//none
        case 94:
            return "Unknown";//none
        case 95:
            return "Unknown";//none
        case 96:
            return "Unknown";//none
        case 97:
            return "Unknown";//none
        case 98:
            return "Unknown";//none
        case 99:
            return "Unknown";//none
        case 100:
            return "Unknown";//mr.grey
        case 101:
            return "102%";
        case 102:
            return "100%";
        case 103:
            return "121%";
        case 104:
            return "105%";
        case 105:
            return "119%";
        case 106:
            return "115%";
        case 107:
            return "84%";
        case 108:
            return "150%";
        case 109:
            return "80%";
        case 110:
            return "100%";
        case 111:
            return "150%";
        case 112:
            return "132%";
        case 113:
            return "118%";
        case 114:
            return "121%";
        case 115:
            return "Unknown";//UBCS
        case 116:
            return "109%";
        case 117:
            return "135%";
        case 118:
            return "100%";
        case 119:
            return "75%";
        case 120:
            return "111%";
        case 121:
            return "96%";
        case 122:
            return "112%";
        case 123:
            return "97%";
        case 124:
            return "87%";
        case 125:
            return "100%";
        case 126:
            return "109%";
        case 127:
            return "100%";
        case 128:
            return "113%";
        case 129:
            return "100%";
        case 130:
            return "100%";
        case 131:
            return "88%";
        case 132:
            return "Unknown";//ETHAN
        case 133:
            return "100%";
        case 134:
            return "Unknown";//HOWARD
        case 135:
            return "113%";
        case 136:
            return "Unknown";//ISAAC
        case 137:
            return "97%";
        case 138:
            return "Unknown";//KATHY
        case 139:
            return "84%";
        case 140:
            return "Unknown";//ELENA
        case 141:
            return "91%";
        case 142:
            return "Unknown";//GOLDEN WOMAN
        case 143:
            return "Unknown";//none
        case 144:
            return "Unknown";//none
        case 145:
            return "Unknown";//none
        case 146:
            return "Unknown";//none
        case 147:
            return "Unknown";//none
        case 148:
            return "Unknown";//none
        case 149:
            return "Unknown";//none
        case 150:
            return "Unknown";//none
        case 151:
            return "94%";
        case 201:
            return "Unknown";//none
        case 202:
            return "Unknown";//none
        case 203:
            return "Unknown";//none
        case 204:
            return "Unknown";//none
        case 205:
            return "Unknown";//none
        case 206:
            return "Unknown";//none
        case 207:
            return "Unknown";//none
        case 208:
            return "Unknown";//none
        default:
            return NULL;

    }
}
