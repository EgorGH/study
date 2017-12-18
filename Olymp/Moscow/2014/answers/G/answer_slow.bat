@echo off
fpc -MobjFPC %~n0.lpr > %~n0.tmp
%~n0.exe <tests\01.in >tests\01.out
fc /A tests\01.out tests\01.a
del tests\*.out %~n0.exe %~n0.tmp %~n0.o
