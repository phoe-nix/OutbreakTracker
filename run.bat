cd love2d
del luaoutbreaktracker.dll
cd ..
cd clib/build
gcc -m32 -shared -L./lib -I./include -llua51 ../main.c -o ../../love2d/luaoutbreaktracker.dll
cd ../../love2d
love ../lua
