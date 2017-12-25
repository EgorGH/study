@echo off
fpc -MobjFPC %~n0.lpr > %~n0.tmp
for %%i in (tests\*.in) do (%~n0.exe < %%i >tests\%%~ni.out
fc /A tests\%%~ni.out tests\%%~ni.a)
del %~n0.exe %~n0.tmp %~n0.o tests\*.out