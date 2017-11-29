@echo off
fpc test2_dynamic.lpr -otest2_dynamic.exe > test2_dynamic.tmp
test2_dynamic.exe
del *.tmp *.exe *.o