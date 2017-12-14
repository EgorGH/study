@echo off
fpc answer_slow.lpr -oanswer_slow.exe > answer_slow.tmp
answer_slow.exe < 00.in > 00.out
fc /A 00.a 00.out
answer_slow.exe < 01.in > 01.out
fc /A 01.a 01.out
rem answer_slow.exe < 02.in > 02.out
rem fc /A 02.a 02.out
del *.out *.tmp *.o *.exe