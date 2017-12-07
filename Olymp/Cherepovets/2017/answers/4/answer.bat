@echo off
fpc answer.lpr -oanswer.exe > answer.tmp
for %%i in (tests\*.in) do (answer.exe <%%i >tests\%%~ni.out
fc /A tests\%%~ni.out tests\%%~ni.a)
del tests\*.out *.exe *.tmp *.o
