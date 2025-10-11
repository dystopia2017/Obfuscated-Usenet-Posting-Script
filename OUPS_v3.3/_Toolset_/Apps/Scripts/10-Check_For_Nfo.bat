@echo off&&title %Name% ^| Checking If Nfo Exists And Setting Its Path If It Does
set nfo=null
if exist "%Temp%\nfoname.txt" (erase /q "%Temp%\nfoname.txt")
cd %Srce%\%inpt%
dir *.nfo /b>>"%Temp%\nfoname.txt"
< "%Temp%\nfoname.txt" (set /p nfo=)
if "%nfo%"=="null" (set nfop=-F) else (set nfop=-F nfo=@%Srce%\%inpt:~1,-1%\%nfo% -F)
if exist "%Temp%\nfoname.txt" (erase /q "%Temp%\nfoname.txt")