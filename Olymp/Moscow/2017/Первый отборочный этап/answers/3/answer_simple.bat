@echo off
set dst=tests
fpc -MobjFPC %~n0.lpr > %~n0.tmp
for %%i in (%dst%\0*. %dst%\1*. %dst%\2*. %dst%\3*.) do (%~n0.exe < %%i >%dst%\%%~ni.out
fc /A %dst%\%%~ni.out %dst%\%%~ni.a)
del %~n0.exe %~n0.tmp %~n0.o %dst%\*.out
