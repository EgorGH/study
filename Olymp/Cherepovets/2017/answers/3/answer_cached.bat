@echo off
fpc -MobjFPC %~n0.lpr > %~n0.tmp
for %%i in (tests\0*.in tests\1*.in tests\2*.in) do (%~n0.exe <%%i >tests\%%~ni.out
fc /A tests\%%~ni.out tests\%%~ni.a)
del tests\*.out %~n0.exe %~n0.tmp %~n0.o
