@echo off
:Run_The_Queue
title %Name% ^| Running The Queue
cls&&set newval=00001&&set oldval=00002
cd %Qdir%
if not exist "00001_*.queue.bat" (echo -&&echo Posting Complete. Press any key to exit&&echo -&&pause>nul&&exit)
dir /b /o:n>>%Temp%\listqueue.txt
< %Temp%\listqueue.txt (set /p "oldvar=")
set newvar=_PROCESSING_%oldvar:~6%
set donvar=_DONE_%oldvar:~6%
ren "%oldvar%" "%newvar%"
:resortqueue
if not exist "%oldval%*.queue.bat" (erase /q "%Temp%\listqueue.txt")
if not exist "%oldval%*.queue.bat" (call "%Qdir%\%newvar%")
if not exist "%oldval%*.queue.bat" (move "%Qdir%\%newvar%" "%Done%\%donvar%")
if not exist "%oldval%*.queue.bat" (goto Run_The_Queue)
if exist "%oldval%*" (ren "%oldval%*" "%newval%*")
set newval=%oldval%
if "%oldval:~0,1%"=="0"   (set oldval=%oldval:~-4%)
if "%oldval:~0,1%"=="0"   (set oldval=%oldval:~-3%)
if "%oldval:~0,1%"=="0"   (set oldval=%oldval:~-2%)
if "%oldval:~0,1%"=="0"   (set oldval=%oldval:~-1%)
if "%oldval%"=="9" (set oldval=10&&goto ovdone)
if "%oldval%"=="8" (set oldval=9&&goto  ovdone)
if "%oldval%"=="7" (set oldval=8&&goto  ovdone)
set /a oldval=%oldval%+1
:ovdone
set oldval=0000%oldval%
set oldval=%oldval:~-5%
goto resortqueue