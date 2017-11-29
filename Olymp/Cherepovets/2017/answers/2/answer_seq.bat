@echo off
fpc answer_seq.lpr -oanswer_seq.exe > answer_seq.tmp
answer_seq.exe < 01.in > 01.out
fc /A 01.out 01.a
answer_seq.exe < 02.in > 02.out
fc /A 02.out 02.a
answer_seq.exe < 03.in > 03.out
fc /A 03.out 03.a
del *.out *.exe *.tmp *.o
