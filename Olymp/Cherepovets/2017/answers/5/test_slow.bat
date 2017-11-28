@echo off
fpc test_slow.lpr -otest_slow.exe > test_slow.tmp
test_slow.exe
del *.tmp *.exe *.o