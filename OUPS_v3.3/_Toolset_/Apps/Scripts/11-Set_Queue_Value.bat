@echo off&&title %Name% ^| Set Queue Value For Queue Work
title %Name% ^| Queuing %inpt%
set qval=1
set tval=1
cd %Qdir%
:checkqueue
set qval=0000%tval%
set qval=%qval:~-5%
if not exist "%qval%_*.queue.bat" (goto endq)
if "%qval%"=="09" set tval=10&&goto checkqueue
if "%qval%"=="08" set tval=09&&goto checkqueue
if "%qval%"=="07" set tval=08&&goto checkqueue
set /a tval=%tval%+1
goto checkqueue
:endq
cd %work%