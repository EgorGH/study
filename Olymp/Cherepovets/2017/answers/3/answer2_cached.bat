@echo off
fpc answer2_cached.lpr -oanswer2_cached.exe > answer2_cached.tmp
answer2_cached.exe < 01.in > 01.out
fc /A 01.out 01.a
answer2_cached.exe < 02.in > 02.out
fc /A 02.out 02.a
answer2_cached.exe < 03.in > 03.out
fc /A 03.out 03.a
del *.out *.exe *.tmp *.o
