@echo off
fpc answer_slow.lpr -oanswer_slow.exe > answer_slow.tmp
answer_slow.exe < 01.in > 01.out
fc /A 01.out 01.a
answer_slow.exe < 02.in > 02.out
fc /A 02.out 02.a
answer_slow.exe < 03.in > 03.out
fc /A 03.out 03.a
del *.out *.exe *.tmp *.o
