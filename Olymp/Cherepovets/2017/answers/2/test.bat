@echo off
fpc test.lpr -otest.exe > test.tmp
test.exe
del *.tmp *.exe *.o