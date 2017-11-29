@echo off
fpc test3.lpr -otest3.exe > test3.tmp
test3.exe
del *.tmp *.exe *.o