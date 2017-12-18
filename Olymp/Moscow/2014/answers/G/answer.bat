@echo off
fpc -MobjFPC %~n0.lpr > %~n0.tmp
%~n0.exe <tests\02.in >tests\02.out
fc /A tests\02.out tests\02.a
del tests\*.out %~n0.exe %~n0.tmp %~n0.o
