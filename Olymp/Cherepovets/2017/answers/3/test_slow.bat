@echo off
fpc -MobjFPC %~n0.lpr > %~n0.tmp
%~n0.exe
del %~n0.tmp %~n0.exe %~n0.o