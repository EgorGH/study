@echo off
fpc answer_slow.lpr -oanswer_slow.exe > answer_slow.tmp
for %%i in (tests\*.in) do (answer_slow.exe <%%i >tests\%%~ni.out
fc /A tests\%%~ni.out tests\%%~ni.a)
del tests\*.out *.exe *.tmp *.o
