@echo off
fpc answer1.lpr -oanswer1.exe > answer1.tmp
answer1.exe < 01.in > 01.out
fc /A 01.out 01.a
del *.out *.exe *.tmp *.o
