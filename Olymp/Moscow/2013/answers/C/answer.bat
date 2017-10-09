@echo off
fpc answer.lpr -oanswer.exe > answer.tmp
answer.exe < 02.in > 02.out
fc /A 02.out 02.a
del *.out *.tmp *.exe *.o