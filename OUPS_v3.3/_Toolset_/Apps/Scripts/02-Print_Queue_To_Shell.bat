@echo off&&title %Name% ^| Printing Queue to Shell
if exist %Temp%\queue.txt (erase /q %Temp%\queue.txt)
cd %Qdir%
dir /b>>%Temp%\queue.txt
%Apps%\fart %Temp%\queue.txt .queue.bat --remove
sort %Temp%\queue.txt /o %Temp%\queue1.txt
if exist %Temp%\queue.txt (erase /q %Temp%\queue.txt)
cls&&echo The Current Queue Is:&&echo ---
type %Temp%\queue1.txt
if exist %Temp%\queue1.txt (erase /q %Temp%\queue1.txt)
echo ---
cd %work%