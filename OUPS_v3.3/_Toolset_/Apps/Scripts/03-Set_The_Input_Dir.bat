@echo off&&title %Name% ^| Checing Process Directory
if exist "%Temp%\processdir.txt" (erase /q "%Temp%\processdir.txt")
cd %Proc%
dir /b>>%Temp%\processdir.txt
cd %Work%
echo null>>%Temp%\processdir.txt
< %Temp%\processdir.txt (set /p pnpt=)
if exist "%Temp%\processdir.txt" (erase /q "%Temp%\processdir.txt")
if "%pnpt%"=="null" (goto Set_Input_Directory)
set inpt="%pnpt%"
set nzbc="%nzbd%\%pnpt%.nzb"
move %Proc%\%inpt% %Work%\%inpt%
goto sed
:Set_Input_Directory
echo What is the input file or directory? (Type "a" or "run" to start the queue)
set /p inpt=
:sed
echo %inpt%>>%Temp%\inptfile.txt
%Apps%\sed -i "s/\"//g" %Temp%\inptfile.txt
< %Temp%\inptfile.txt ("set /p inpt=")
cls
if exist %Temp%\inptfile.txt (erase /q %Temp%\inptfile.txt)
if exist %Work%\sed??????    (erase /q    %Work%\sed??????)
if %inpt%==a   (call %Scpt%\14-Run_The_Queue.bat)
if %inpt%==run (call %Scpt%\14-Run_The_Queue.bat)