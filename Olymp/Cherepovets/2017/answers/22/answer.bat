@echo off
fpc answer.lpr -oanswer.exe > answer.tmp
answer.exe < 01.in > 01.out
fc /A 01.out 01.a
del *.out *.exe *.tmp *.o
