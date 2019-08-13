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
	unsigned int GasTime;
	unsigned int GasFlag;
	unsigned char GasRandom;
	unsigned char ItemRandom;
	unsigned char P1Coin;
	unsigned char P2Coin;
	unsigned char P3Coin;
	unsigned char P4Coin;
	unsigned char KilledZombie;
	unsigned char PlayerNum;
	unsigned char Pass1;
	unsigned char Pass2;
	unsigned char Pass3;
	unsigned short PassUB1;
	unsigned char PassUB2;
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
    unsigned char ID;
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
    unsigned short HP;
    unsigned short MaxHP;
    unsigned char EnemyType;
    unsigned char NameID;
} Enemy2;

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
            return "凯文 ";//Kevin
        case 1:
            return "马克 ";//Mark
        case 2:
            return "吉姆 ";//Jim
        case 3:
            return "乔治 ";//George
        case 4:
            return "大卫 ";//David
        case 5:
            return "艾丽莎 ";//Alyssa
        case 6:
            return "洋子 ";//Yoko
        case 7:
            return "辛迪 ";//Cindy
        default:
            return "未知";//未知
    }
}

char* GetCharacterName(int charType)
{
    switch(charType)
    {
        case 0:
            return "凯文";//Kevin
        case 1:
            return "马克";//Mark
        case 2:
            return "吉姆";//Jim
        case 3:
            return "乔治";//George
        case 4:
            return "大卫";//David
        case 5:
            return "艾丽莎";//Alyssa
        case 6:
            return "洋子";//Yoko
        case 7:
            return "辛迪";//Cindy
        default:
            return "未知";//未知
    }
}

char* GetNPCName(int nameID)
{
    switch (nameID)
    {
        case 1:
            return "麦克道尔";
        case 2:
            return "罗德里格斯";
        case 3:
            return "康拉德";
        case 4:
            return "汉克:B";
        case 5:
            return "汉克";
        case 6:
            return "米格尔";
        case 7:
            return "未知";
        case 8:
            return "卢克";
        case 9:
            return "未知";
        case 10:
            return "阿诺德";
        case 11:
            return "马特";
        case 12:
            return "比利";
        case 13:
            return "赫什";
        case 14:
            return "未知";
        case 15:
            return "未知";
        case 16:
            return "未知";
        case 17:
            return "彼得";
        case 18:
            return "马文";
        case 19:
            return "弗雷德";
        case 20:
            return "安迪";
        case 21:
            return "未知";
        case 22:
            return "吉恩";
        case 23:
            return "托尼";
        case 24:
            return "未知";
        case 25:
            return "帕特里克";
        case 26:
            return "劳埃德";
        case 27:
            return "奥斯汀";
        case 28:
            return "克林特";
        case 29:
            return "波恩";
        case 30:
            return "鲍勃";
        case 31:
            return "未知";
        case 32:
            return "内森";
        case 33:
            return "塞缪尔";
        case 34:
            return "未知";
        case 35:
            return "威尔";
        case 36:
            return "未知";
        case 37:
            return "罗杰";
        case 38:
            return "未知";
        case 39:
            return "卡特";
        case 40:
            return "格雷格";
        case 41:
            return "弗罗斯特";
        case 42:
            return "弗罗斯特:B";
        case 43:
            return "杰克";
        case 44:
            return "加里";
        case 45:
            return "理查德";
        case 46:
            return "未知";
        case 47:
            return "米奇";
        case 48:
            return "阿尔";
        case 49:
            return "斧男";
        case 50:
            return "阿尔:B";
        case 51:
            return "本";
        case 52:
            return "未知";
        case 53:
            return "瑞根";
        case 54:
            return "瑞根:B";
        case 55:
            return "莫妮卡";
        case 56:
            return "琳达";
        case 57:
            return "瑞塔";
        case 58:
            return "未知";
        case 59:
            return "玛丽";
        case 60:
            return "凯特";
        case 61:
            return "未知";
        case 62:
            return "未知";
        case 63:
            return "丹尼";
        case 64:
            return "丹尼:B";
        case 65:
            return "基尔";
        case 66:
            return "基尔:B";
        case 67:
            return "未知";
        case 68:
            return "未知";
        case 69:
            return "未知";
        case 70:
            return "未知";
        case 71:
            return "未知";
        case 72:
            return "未知";
        case 73:
            return "未知";
        case 74:
            return "基思";
        case 75:
            return "未知";
        case 76:
            return "未知";
        case 77:
            return "未知";
        case 78:
            return "未知";
        case 79:
            return "未知";
        case 80:
            return "未知";
        case 81:
            return "科特";
        case 82:
            return "科特:B";
        case 83:
            return "加里:B";
        case 84:
            return "阿尔:C";
        case 85:
            return "未知";
        case 86:
            return "未知";
        case 87:
            return "桃乐丝";
        case 88:
            return "未知";
        case 89:
            return "未知";
        case 90:
            return "未知";
        case 91:
            return "洋子:Z";
        case 92:
            return "未知";
        case 93:
            return "未知";
        case 94:
            return "未知";
        case 95:
            return "未知";
        case 96:
            return "未知";
        case 97:
            return "未知";
        case 98:
            return "未知";
        case 99:
            return "未知";
        case 100:
            return "未知";
        case 101:
            return "雷蒙德";
        case 102:
            return "亚瑟";
        case 103:
            return "亚伦";
        case 104:
            return "多里安";
        case 105:
            return "埃利奥特";
        case 106:
            return "埃里克";
        case 107:
            return "哈里";
        case 108:
            return "红先生";
        case 109:
            return "蓝先生";
        case 110:
            return "绿先生";
        case 111:
            return "金先生";
        case 112:
            return "黑先生";
        case 113:
            return "卡尔";
        case 114:
            return "达斯汀";
        case 115:
            return "未知";
        case 116:
            return "德里克";
        case 117:
            return "白女士";
        case 118:
            return "桃女士";
        case 119:
            return "水女士";
        case 120:
            return "莱恩";
        case 121:
            return "尼古拉斯";
        case 122:
            return "肖恩";
        case 123:
            return "菲利普";
        case 124:
            return "唐";
        case 125:
            return "马修斯";
        case 126:
            return "罗伯特";
        case 127:
            return "查克";
        case 128:
            return "金杰";
        case 129:
            return "劳拉";
        case 130:
            return "阿米莉亚";
        case 131:
            return "伊森";
        case 132:
            return "未知";
        case 133:
            return "霍华德";
        case 134:
            return "未知";
        case 135:
            return "艾萨克";
        case 136:
            return "未知";
        case 137:
            return "凯茜";
        case 138:
            return "未知";
        case 139:
            return "艾伦娜";
        case 140:
            return "未知";
        case 141:
            return "弗兰克";
        case 142:
            return "未知";
        case 143:
            return "未知";
        case 144:
            return "未知";
        case 145:
            return "未知";
        case 146:
            return "未知";
        case 147:
            return "未知";
        case 148:
            return "未知";
        case 149:
            return "未知";
        case 150:
            return "未知";
        case 151:
            return "罗德尼";

        default:
            return NULL;//未知

    }
}

char* GetDifficultyName(unsigned short Difficulty)
{
    switch (Difficulty)
    {
        case 0:
            return "简单";
        case 1:
            return "普通";
        case 2:
            return "困难";
        case 3:
            return "极难";

        default:
            return "";
    }
}

char* GetF1LobScenarioFullName(unsigned short F1LobScenarioID)
{
    switch (F1LobScenarioID)
    {
        case 0:
            return "发生　outbreak";
        case 1:
            return "零下　below freezing point";
        case 2:
            return "巢窟　the hive";
        case 3:
            return "狱炎　hellfire";
        case 4:
            return "决议　decisions,decisions";
        default:
            return "";
    }
}

char* GetF2LobScenarioFullName(unsigned short F2LobScenarioID)
{
    switch (F2LobScenarioID)
    {
        case 0:
            return "初心　training ground";
        case 1:
            return "咆哮　wild things";
        case 2:
            return "异界underbelly";
        case 3:
            return "记忆　flashback";
        case 4:
            return "死守　desperate times";
        case 5:
            return "突破　end of the road";
        case 6:
            return "歼灭1　elimination 1";
        case 7:
            return "歼灭2　elimination 2";
        case 8:
            return "歼灭3　elimination 3";
        case 9:
            return "对峙1　showdown 1";
        case 10:
            return "对峙2　showdown 2";
        case 11:
            return "对峙3　showdown 3";
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
            return "未知";//未知
    }
}

char* GetEnemyName2(int nameID)
{
    switch (nameID)
    {
		case 0:
            return "舔食者";
        case 1:
            return "丧尸";
        case 2:
            return "狗";
        case 3:
            return "虫";
        case 4:
            return "老鼠";
        case 5:
            return "乌鸦";
        case 6:
            return "巨型黄蜂";
        case 7:
            return "大蜘蛛";
        case 8:
            return "ID:8";
        case 9:
            return "飞蛾";
        case 10:
            return "蠕虫";
        case 11:
            return "藤蔓";
        case 12:
            return "藤蔓";
        case 13:
            return "花";
        case 14:
            return "藤蔓";
        case 15:
            return "夜之女神暴君";
        case 16:
            return "鳄鱼";
        case 17:
            return "ID:17";//f1 outbreak
        case 18:
            return "跳蚤";
        case 19:
            return "水蛭Boss";
        case 20:
            return "舔食者Boss";
        case 21:
            return "ID:21";
        case 22:
            return "猎杀";
        case 23:
            return "青蛙";
        case 24:
            return "ID:24";
        case 25:
            return "ID:25";
        case 26:
            return "鲨鱼";
        case 27:
            return "水蛭人";
        case 28:
            return "ID:28";
        case 29:
            return "G突变体";
        case 30:
            return "G幼体";
        case 31:
            return "ID:31";
        case 32:
            return "大象";
        case 33:
            return "狮子";
        case 34:
            return "触手";
        case 35:
            return "触手";
        case 36:
            return "剪刀尾";//Scissor Tail
        case 37:
            return "ID:37";//f1 outbreak
        case 38:
            return "ID:38";
        case 39:
            return "ID:39";
        case 40:
            return "暴君?";
        case 41:
            return "暴君";
        case 42:
            return "夜之女神";
        case 43:
            return "死神暴君";
        case 44:
            return "夜之女神核心";
        case 45:
            return "斧男";
        case 46:
            return "大王花";
        case 47:
            return "多萝西";
        case 48:
            return "飞虫";
        case 49:
            return "犀鸟";
        case 50:
            return "ID:50";
        case 51:
            return "植物BOSS";
        case 52:
            return "车";
        case 53:
            return "箱子";
        case 54:
            return "地雷";
        case 55:
            return "小水蛭";
        case 56:
            return "ID:56";
        case 57:
            return "狙击手";
        case 58:
            return "汽油罐";//Gasoline Tank
        case 59:
            return "丧尸手";//Zombie Hands
        case 60:
            return "火柱";
        case 61:
            return "打字机";
        case 62:
            return "ID:62";
        case 63:
            return "跳蚤军团";
        case 64:
            return "跳蚤BOSS";
        case 65:
            return "鬣狗";
        default:
            return "未知";

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
            return "130%";//130%
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
        default:
            return NULL;

    }
}
