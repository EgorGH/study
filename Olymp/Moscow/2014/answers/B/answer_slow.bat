@echo off
fpc answer_slow.lpr -oanswer_slow.exe > answer_slow.tmp
answer_slow.exe < 00.in > 00.out
fc /A 00.out 00.a
answer_slow.exe < 01.in > 01.out
fc /A 01.out 01.a
del *.out *.exe *.tmp *.o
