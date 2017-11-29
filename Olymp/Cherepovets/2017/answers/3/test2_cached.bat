@echo off
fpc test2_cached.lpr -otest2_cached.exe > test2_cached.tmp
test2_cached.exe
del *.tmp *.exe *.o