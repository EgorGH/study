@echo off
fpc test1.lpr -otest1.exe > test1.tmp
test1.exe
del *.tmp *.exe *.o