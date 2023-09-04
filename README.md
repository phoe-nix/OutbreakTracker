# OutbreakTracker
Tracker program for the ps2 Outbreak games.

![image](https://github.com/madgamer98/OutbreakTracker/assets/20719536/0d36d1f3-9e2f-403a-a3b1-a69766fe4ce9)


## How to use releases

Download the lastest love2d 64bit

https://love2d.org/

extract the release zip into the love2d folder

Run OutbreakTracker.exe

if can't see anything in the program, you need update video card driver.

## How to build
1. Clone luaJIT: https://github.com/LuaJIT/LuaJIT/ and extract it to a folder
2. Open up the Outbreak Tracker.sln file
3. Tools -> Command Line -> Developer Command Prompt
4. You might need to configure the Developer Command Prompt to compile to 64bit. You will want to run the vcvars64.bat inside the Developer Command Prompt. It's default location for Visual Studio 2022 is here: C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat
6. cd into the luaJIT/src folder and run msvcbuild.bat
7. Copy the newly created lua51.lib into the OutbreakTracker/Outbreak Tracker/lib/x64/
8. You should now be able to compile the DLL in Visual Studio with Build -> Build Solution. The DLL will be located in OutbreakTracker\Build\Release\x64\luaoutbreaktracker.dll
9. Place the DLL and the OutbreakTracker/Outbreak Tracker/lua folder into your love2d folder and run `love lua` or alternatively build an exe with love2d's instructions here: https://love2d.org/wiki/Game_Distribution

## Credits
Program: Fothsid, killme, phoe-nix, madgamer98

Thanks: morshi, alyssaprimp
