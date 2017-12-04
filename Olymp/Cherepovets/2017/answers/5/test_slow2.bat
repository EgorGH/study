@echo off
fpc test_slow2.lpr -otest_slow2.exe > test_slow2.tmp
test_slow2.exe
del *.tmp *.exe *.o