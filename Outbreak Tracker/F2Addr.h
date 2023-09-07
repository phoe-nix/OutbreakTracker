// I'm way too lazy to f&@! with defines lol.

const int F2_P1Start = 0x47BD30; // 0x2047C23C Not the actual start, but used as anchor point.
const int F2_P2Start = 0x47CE30;
const int F2_P3Start = 0x47DF30;
const int F2_P4Start = 0x47F030;
const int F2_PickupSpaceStart = 0x397B7C; // 1 item - 60 bytes // settings byte on offset ITEM_PTR+37?
const int F2_DeadInventoryStart = 0x491146;
const int F2_VirusMaxStart = 0x728500;
const int F2_ScenarioIDAddr = 0x3137BA;
const int F2_FrameCounter = 0x4912B8;
const int F2_RoomPriorty = 0x007d7a90;

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
const int F2_AntiVirusTimeOffset = 0xBCA;//anti-virus time
const int F2_HerbTimeOffset = 0xBCE;//herb time

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

const int F2_RoomItem = 0x24AF48;//room item pointer 0x24AF48 387CB0
int F2_GetItemAddress(int characterID)
{
    switch (characterID)
    {
        case 0:
            return 0x3BA200;
        case 1:
            return 0x3B9B40;
        case 2:
            return 0x3B9B40;
        case 3:
            return 0x3B9B40;
        default:
            return -1;
    }
}

const int F2_Pointer = 0x388314;//enemy HP
const int F2_EHPOffset = 0x540;
const int F2_EMaxHPOffset = 0x542;
const int F2_E1Start = 0x4245D0;
const int F2_E2Start = 0x425380;
const int F2_E3Start = 0x426130;
const int F2_E4Start = 0x426EE0;
const int F2_E5Start = 0x427C90;
const int F2_E6Start = 0x428A40;
const int F2_E7Start = 0x4297F0;
const int F2_E8Start = 0x42A5A0;
const int F2_E9Start = 0x42B350;
const int F2_E10Start = 0x42C100;
const int F2_E11Start = 0x42CEB0;
const int F2_E12Start = 0x42DC60;
const int F2_EnemyEnabled = 0;
const int F2_EnemyInGame = 1;
const int F2_EnemyNameIDOffset = 3;
const int F2_EnemyTypeOffset = 0xBD2;
const int F2_EnemyStatusOffset = 0x32;//8,32,cb0,1F3
const int F2_EnemyListOffset = 0x760630;//760712;

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

const int F2_Coin = 0x491188;//wild things
const int F2_KilledZombie = 0x491268;//47ca64,49010c,491268,desperate times
//const int F2_MaxZombie = 0x2179464a;
const int F2_DTStart = 0x490f6c;
const int F2_PlayerNum =  0x24AFCC;
const int F2_HostStatus =  0x62DDF0;
const int F2_HostPlayer =  0x6411E6;//number of players
const int F2_HostMaxPlayer =  0x5FF77A;//number of players
const int F2_HostScenarioID =  0x62DDF6;
const int F2_HostTime =  0x62E768;
const int F2_HostDifficulty = 0x6020CA;
const int F2_DoorHP = 0x477722;//4776E0
const int F2_DoorFlag = 0x49021C;//lock flag

const int F2_Door1HP = 0x477762;//4777A2 后巷门
const int F2_Door2HP = 0x477720;//477760 餐厅后门
const int F2_Door3HP = 0x477724;//餐厅厨房S
const int F2_Door4HP = 0x477726;//餐厅厨房W
const int F2_Door5HP = 0x4777E4;//477820 园内南>东门
const int F2_Door6HP = 0x4777E0;//477864 园内南>北门
const int F2_Door7HP = 0x477824;//477860 园内东>北门
const int F2_Door8HP = 0x4779E2;//477A66 大象舞台
const int F2_Door9HP = 0x4778AE;//477B64 异界 东侧
const int F2_Door10HP = 0x4777A4;//4778A0 异界 西侧
const int F2_Door11HP = 0x4778AC;//4779A0 休息室右
const int F2_Door12HP = 0x4778AA;//4779A2 休息室左
const int F2_Door13HP = 0x477B26;//477BE0 记忆203房
const int F2_Door14HP = 0x477724;//4777E0 大厅>1楼大堂
const int F2_Door15HP = 0x477824;//477920 办公室>1楼东侧
const int F2_Door16HP = 0x4777E4;//477BE0 1楼大堂>U走廊
const int F2_Door17HP = 0x4779A0;//4779E0 停尸房
const int F2_Door18HP = 0x477A62;//477AA0 狗屋
const int F2_Door19HP = 0x477B00;//eotr hole hp

int F2_GetDoorHP(int doorID)
{
    switch (doorID)
    {
        case 0:return F2_Door1HP;
        case 1:return F2_Door2HP;
        case 2:return F2_Door3HP;
        case 3:return F2_Door4HP;
        case 4:return F2_Door5HP;
        case 5:return F2_Door6HP;
        case 6:return F2_Door7HP;
        case 7:return F2_Door8HP;
        case 8:return F2_Door9HP;
        case 9:return F2_Door10HP;
        case 10:return F2_Door11HP;
        case 11:return F2_Door12HP;
        case 12:return F2_Door13HP;
        case 13:return F2_Door14HP;
        case 14:return F2_Door15HP;
        case 15:return F2_Door16HP;
        case 16:return F2_Door17HP;
        case 17:return F2_Door18HP;
        case 18:return F2_Door19HP;
        default:return -1;
    }
}
const int F2_Door1Flag = 0x490234;//490228/490234 后巷门
const int F2_Door2Flag = 0x490228;//49021C/490228 餐厅后门
const int F2_Door3Flag = 0x49021C;//餐厅厨房S
const int F2_Door4Flag = 0x49021C;//餐厅厨房W
const int F2_Door5Flag = 0x490240;//490240/49024C 园内南>东门
const int F2_Door6Flag = 0x490240;//490240/490258 园内南>北门
const int F2_Door7Flag = 0x490258;//49024C/490258 园内东>北门
const int F2_Door8Flag = 0x4902B8;//4902A0/4902B8 大象舞台
const int F2_Door9Flag = 0x4902E8;//490264/4902E8 异界 东侧
const int F2_Door10Flag = 0x490234;//490234/490264 异界 西侧
const int F2_Door11Flag = 0x490294;//490264/490294 休息室右
const int F2_Door12Flag = 0x490294;//490264/490294 休息室左
const int F2_Door13Flag = 0x490300;//490300 4902DC 记忆203房
const int F2_Door14Flag = 0x49021C;//49021C/490240 大厅>1楼大堂
const int F2_Door15Flag = 0x49027C;//49024C/49027C 办公室>1楼东侧
const int F2_Door16Flag = 0x490300;//490240/490300 1楼大堂>U走廊
const int F2_Door17Flag = 0x490294;//490294/4902A0 停尸房
const int F2_Door18Flag = 0x4902C4;//4902B8/4902C4 狗屋
const int F2_Door19Flag = 0x48FFF4;//eotr hole hp

int F2_GetDoorFlag(int doorID)
{
    switch (doorID)
    {
        case 0:return F2_Door1Flag;
        case 1:return F2_Door2Flag;
        case 2:return F2_Door3Flag;
        case 3:return F2_Door4Flag;
        case 4:return F2_Door5Flag;
        case 5:return F2_Door6Flag;
        case 6:return F2_Door7Flag;
        case 7:return F2_Door8Flag;
        case 8:return F2_Door9Flag;
        case 9:return F2_Door10Flag;
        case 10:return F2_Door11Flag;
        case 11:return F2_Door12Flag;
        case 12:return F2_Door13Flag;
        case 13:return F2_Door14Flag;
        case 14:return F2_Door15Flag;
        case 15:return F2_Door16Flag;
        case 16:return F2_Door17Flag;
        case 17:return F2_Door18Flag;
        case 18:return F2_Door19Flag;
        default:return -1;
    }
}

/*
咆哮 8个门
异界 4个门
记忆 1个门
死守 5个门
突破 1个洞
wt door 0x477762 0x4777A2 flag 490234 first locked door 3BC2C0
49021C 餐厅S FLAG>=4 and flag<8 lock;unlock: >=8 and <= 0x0C 
49021C 餐厅W FLAG>=8 lock unlock: <8 and
490234 后巷门FLAG 02=lock 00=unlock
490228 餐厅后门FLAG 03=lock 02=unlock
490240 园区东门I lock:>=04 and <8 unlock:<4
490240 园区南门P lock:%2=0 unlock:%2=1
49024C 园区北门I 07=lock 03=unlock
4902A0 大象舞台P 03=lock 01=unlock

突破
477B00 hole hp
48FFF5 (490035) flag 20=broke, 00= block
//dt unlock door 3BC0E4 door flag 49021C
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
*/
const int F2_SlotP1Start = 0x630D40;
const int F2_SlotP2Start = 0x6310E8;
const int F2_SlotP3Start = 0x631490;
const int F2_SlotP4Start = 0x631838;

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
const int F2_Slot1 = 0x628DA0;
const int F2_Slot2 = 0x628EFC;
const int F2_Slot3 = 0x629058;
const int F2_Slot4 = 0x6291B4;
const int F2_Slot5 = 0x629310;
const int F2_Slot6 = 0x62946C;
const int F2_Slot7 = 0x6295C8;
const int F2_Slot8 = 0x629724;
const int F2_Slot9 = 0x629880;
const int F2_Slot10 = 0x6299DC;
const int F2_Slot11 = 0x629B38;
const int F2_Slot12 = 0x629C94;
const int F2_Slot13 = 0x629DF0;
const int F2_Slot14 = 0x629F4C;
const int F2_Slot15 = 0x62A0A8;
const int F2_Slot16 = 0x62A204;
const int F2_Slot17 = 0x62A360;
const int F2_Slot18 = 0x62A4BC;
const int F2_Slot19 = 0x62A618;
const int F2_Slot20 = 0x62A774;

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

const int F2_WTTime = 0x491248;//咆哮
const int F2_PassWT = 0x48FE7B;//咆哮
const int F2_PassDT1 = 0x490070;//死守
const int F2_PassDT2 = 0x490072;//死守
const int F2_PassDT3 = 0x48FE70;//死守 adlib 48FE70
const int F2_PassUB1 = 0x490073;//异界
const int F2_PassUB2 = 0x490075;//异界
const int F2_PassUB3 = 0x48FE76;//异界 adlib 48FE76
const int F2_EscapeTime = 0x491256;//异界
const int F2_FBTime = 0x491254;//记忆
const int F2_Pass4 = 0x491268;//突破
const int F2_Difficulty = 0x49135A;
const int F2_DTGasRandom = 0x24ADB0;//24ADB0(offline) 491338(online)
const int F2_DTGasFlag = 0x48FFFC;
const int F2_DTGasTime = 0x491278;
const int F2_DTFightTime = 0x49126C;
const int F2_DTFightTime2 = 0x49124E;
const int F2_DTGarageTime = 0x491270;//48FE71 switch
const int F2_ItemRandom = 0x24AD30;//
const int F2_ItemRandom2 = 0x24ADB1;//DE C2
const int F2_PuzzleRandom = 0x24ADB0;// puzzle set
const int F2_Cleared = 0x4912A0;//4912A0 4912C9
/*clear 4912A0
24AD31 item set in next game
112334
112334
112344
122344
122344
123344
112334
112344
122344
122344
12334

[0x40]
112334
112344

[0x80]
112334
122344

00 1 random B0 00
01 1 random 00 B0
02 2 random AD 60
03 3 random 5A 11
04 3 random 5A C1
05 4 random 07 72
06 1 random B4 22
07 1 random B4 D2
08 2 random 61 83
09 3 random 0E 34
0A 3 random 0E E4
0B 4 random BB 94
0C 1 random 68 45
0D 1 random 68 F5
0E 2 random 15 A6
0F 3 random C2 56
10 4 random 6F 07
11 4 random 6F B7
12 1 random 1C 68
13 2 random C9 18
14 2 random C9 C8
15 3 random 76 79
16 4 random 23 2A
17 4 random 23 DA
18 1 random D0 8A
19 2 random 7D 3B
1A 2 random 7D EB
1B 3 random 2A 9C
1C 4 random D7 4C
1D 4 random D7 FC
1E 1 random 84 AD
1F 2 random 31 5E
20 3 random DE 0E
21 3 random DE BE
22 4 random 8B 6F
23 1 random 38 20
24 1 random 38 D0
25 2 random E5 80
26 3 random 92 31
27 3 random 92 E1
28 4 random 3F 92
29 1 random EC 42
2A 1 random EC F2
2B 2 random 99 A3
2C 3 random 46 54
2D 4 random F3 04
2E 4 random F3 B4
2F 1 random A0 65
30 2 random 4D 16
31 2 random 4D C6
32 3
33 4
34 4
35 1
36 2
37 2
38 3
39 4
3A 4
3B 1
3C 2
3D 3
3E 3
3F 4
40 1
41 1
42 2
43 3
44 3
45 4
46 1
47 1
48 2
49 3
4A 4
4B 4
4C 1
4D 2
4E 2
4F 3
50 4
51 4
52 1
53 2
54 2
55 3
56 4
57 4
58 1
59 2
5A 3
5B 3
5C 4
5D 1
5E 1
5F 2
60 3
61 3
62 4
63 1
64 1
65 2
66 3
67 3
68 4
69 1
6A 2
6B 2
6C 3
6D 4
6E 4
6F 1
70 2
71 2
72 3
73 4
74 4
75 1
76 2
77 3
78 3
79 4
7A 1
7B 1
7C 2
7D 3
7E 3
7F 4
80 1
81 1
82 2
83 3
84 3
85 4
86 1
87 2
88 2
89 3
8A 4
8B 4
8C 1
8D 2
8E 2
8F 3
90 4
91 4
92 1
93 2
94 3
95 3
96 4
97 1
98 1
99 2
9A 3
9B 3
9C 4
9D 1
9E 1
9F 2
A0 3
A1 3
A2 4
A3 1
A4 2
A5 2
A6 3
A7 4
A8 4
A9 1
AA 2
AB 2
AC 3
AD 4
AE 4
AF 1
B0 2
B1 3
B2 3
B3 4
B4 1
B5 1
B6 2
B7 3
B8 3
B9 4
BA 1
BB 1
BC 2
BD 3
BE 3
BF 4
C0 1
C1 2
C2 2
C3 3
C4 4
C5 4
C6 1
C7 2
C8 2
C9 3
CA 4
CB 4
CC 1
CD 2
CE 2
CF 3
D0 4
D1 1	18 D1
D2 1
D3 2
D4 3
D5 3
D6 4
D7 1
D8 1
D9 2
DA 3
DB 3
DC 4
DD 1
DE 2
DF 2
E0 3
E1 4
E2 4
E3 1
E4 2
E5 2
E6 3
E7 4
E8 4
E9 1
EA 2
EB 2
EC 3
ED 4
EE 1
EF 1
F0 2
F1 3
F2 3
F3 4
F4 1
F5 1
F6 2
F7 3
F8 3
F9 4
FA 1
FB 2
FC 2
FD 3
FE 4
FF 4

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
//490071 		39DJ LV4U EXP2 E67C 6SR2 Q898 44V7 K3G6 SW4D FM54 5TF3 4NZH B37B LYNX 9AAA YTY7
//490070 74EE70 2236 1587 2994 3048 4425 5170 6703 7312 8669 9851 0764 3516 5835 6249 7177 9408
//490073 750BB0 2916 3719 0154 6443 7688 1812 5551 6010 0652 6234 0533 9439 1421 1127 7840 6910
//490070 		DESK MISS FREE JUNK NEWS CARD DIET POEM BEER LOCK TEST SOFA WINE TAPE GOLF PLAN

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