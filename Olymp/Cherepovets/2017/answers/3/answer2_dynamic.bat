@echo off
fpc answer2_dynamic.lpr -oanswer2_dynamic.exe > answer2_dynamic.tmp
answer2_dynamic.exe < 01.in > 01.out
fc /A 01.out 01.a
answer2_dynamic.exe < 02.in > 02.out
fc /A 02.out 02.a
answer2_dynamic.exe < 03.in > 03.out
fc /A 03.out 03.a
del *.out *.exe *.tmp *.o
