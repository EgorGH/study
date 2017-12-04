@echo off
fpc answer_slow2.lpr -oanswer_slow2.exe > answer_slow2.tmp
answer_slow2.exe < 01.in > 01.out
fc /A 01.out 01.a   
answer_slow2.exe < 02.in > 02.out
fc /A 02.out 02.a          
del *.out *.tmp *.exe *.o
