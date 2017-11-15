@echo off
fpc answer.lpr -oanswer.exe > answer.tmp
answer.exe < 00.in > 00.out
fc /A 00.a 00.out
answer.exe < 01.in > 01.out
fc /A 01.a 01.out
answer.exe < 02.in > 02.out
fc /A 02.a 02.out
del *.out *.tmp *.o *.exe