@echo off
fpc answer_slow.lpr -oanswer_slow.exe > answer_slow.tmp
answer_slow.exe < 01.in > 01.out
fc /A 01.out 01.a            
del *.out *.tmp *.exe *.o
