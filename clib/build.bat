cd build
gcc -m32 -shared -L./lib -I./include -llua51 ../main.c -o ./luaoutbreaktracker.dll
cd ..