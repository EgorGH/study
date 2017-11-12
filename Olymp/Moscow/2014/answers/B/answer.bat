@echo off
fpc answer.lpr -oanswer.exe > answer.tmp
answer.exe < 02.in > 02.out
fc /A 02.out 02.a
answer.exe < 03.in > 03.out
fc /A 03.out 03.a
answer.exe < 04.in > 04.out
fc /A 04.out 04.a
del *.out *.exe *.tmp *.o
