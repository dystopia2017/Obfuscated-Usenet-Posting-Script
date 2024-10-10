@echo off&&set Name=OUPS v0.5

:Set_Script_Variables
set urar=No
set rcom=0
set zcom=0

:: urar is the "Use Rar" option, set to Yes to use rar.exe to handle packing.
:: Winrar needs to be installed on your system for this to work, if Winrar is
:: not found on the system, the script will fall back to packing with 7zip.

:: rcom and zcom are compression levels for Winrar and 7zip.
:: The values for rcom are: 0 (No Compression) to 5 (Best Compression)
:: The values for zcom are: 0 (No Compression) to 9 (Best Compression)

:Set_Script_Paths
set Work=%CD%
set Srce=%CD%\_Source_
set Tool=%CD%\_Toolset_
set Proc=%CD%\_Process_
set Apps=%Tool%\Apps
set Nzbd=%Tool%\Nzbs
set Done=%Tool%\Posted
set Post=%Tool%\Posting
set Qdir=%Tool%\Queue
set Temp=%Tool%\Temp
set wrar="%PROGRAMFILES%\WinRAR\rar.exe"

:Print_Queue_To_Shell
title %Name% ^| Printing Queue to Shell
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

:Check_If_There_Is_Anything_In_The_Process_Directory
title %Name% ^| Checing Process Directory
if exist "%Temp%\processdir.txt" (erase /q "%Temp%\processdir.txt")
cd %Proc%
dir /b>>%Temp%\processdir.txt
cd %Work%
echo null>>%Temp%\processdir.txt
< %Temp%\processdir.txt (set /p pnpt=)
if exist "%Temp%\processdir.txt" (erase /q "%Temp%\processdir.txt")
if "%pnpt%"=="null" (goto Set_Input_Directory)
set inpt=%pnpt%
move "%Proc%\%inpt%" "%Work%\%inpt%"
goto sed

:Set_Input_Directory
title %Name% ^| Setting Input File or Directory
echo What is the input file or directory? (Type "a" or "run" to start the queue)
set /p inpt=
:sed
echo "%inpt%">>%Temp%\inptfile.txt
%Apps%\sed -i "s/\"//g" %Temp%\inptfile.txt
< %Temp%\inptfile.txt (set /p inpt=)
if exist %Temp%\inptfile.txt (erase /q %Temp%\inptfile.txt)
if exist %Work%\sed??????    (erase /q    %Work%\sed??????)
if "%inpt%"=="a"   (goto Run_The_Queue)
if "%inpt%"=="run" (goto Run_The_Queue)

:Generate_Random_Strings_For_Password_Filename_Poster_And_Subject
title %Name% ^| Generating Random Strings for %inpt%
%Apps%\bw generate -lun --length 127>>%Temp%\password.txt
%Apps%\bw generate -ln   --length 20>>%Temp%\filename.txt
%Apps%\bw generate -lun  --length 40>>%Temp%\randomst.txt
< %Temp%\password.txt (set /p rpwd=)
< %Temp%\filename.txt (set /p flnm=)
< %Temp%\randomst.txt (set /p rand=)
set from="%rand:~0,4% %rand:~4,4%@%rand:~8,4%.%rand:~12,4%"
set subb=- {%rand:~-20%} yEnc ({part}/{parts})

:Pick_A_Random_Usenet_Group
title %Name% ^| Picking A Random Usenet Group
if "%time:~7,1%"=="0" (set grps=alt.binaries.boneless&&   goto Erase_Old_Temp_Files)
if "%time:~7,1%"=="1" (set grps=alt.binaries.bloaf&&      goto Erase_Old_Temp_Files)
if "%time:~7,1%"=="2" (set grps=alt.binaries.ath&&        goto Erase_Old_Temp_Files)
if "%time:~7,1%"=="3" (set grps=alt.binaries.mom&&        goto Erase_Old_Temp_Files)
if "%time:~7,1%"=="4" (set grps=alt.binaries.frogs&&      goto Erase_Old_Temp_Files)
if "%time:~7,1%"=="5" (set grps=alt.binaries.hdtv&&       goto Erase_Old_Temp_Files)
if "%time:~7,1%"=="6" (set grps=alt.binaries.multimedia&& goto Erase_Old_Temp_Files)
if "%time:~7,1%"=="7" (set grps=alt.binaries.nl&&         goto Erase_Old_Temp_Files)
if "%time:~7,1%"=="8" (set grps=alt.binaries.warez&&      goto Erase_Old_Temp_Files)
if "%time:~7,1%"=="9" (set grps=alt.binaries.etc&&        goto Erase_Old_Temp_Files)

:Erase_Old_Temp_Files
title %Name% ^| Erasing Any Old Temp Files
if exist %Temp%\password.txt (erase /q %Temp%\password.txt)
if exist %Temp%\filename.txt (erase /q %Temp%\filename.txt)
if exist %Temp%\randomst.txt (erase /q %Temp%\randomst.txt)

:Create_Output_Directory_And_Move_Input_To_It
title %Name% ^| Creating Job Directories
cd %Post%
mkdir %flnm%
cd %Work%
move "%inpt%" "%Post%\%flnm%\%inpt%"
cd %Post%\%flnm%

:Calc_Source_Size_and_Volume_Size
for /f "tokens=1" %%a in ('%Apps%\du.exe --block-size=1M -c "%Post%\%flnm%\%inpt%" ^| findstr /R "^[0-9]"') do (set size=%%a)
if %size% LSS 100000 (set vol=2000m)&&if %size% LSS 95000 (set vol=1900m)&&if %size% LSS 90000 (set vol=1800m)
if %size% LSS 85000  (set vol=1700m)&&if %size% LSS 80000 (set vol=1600m)&&if %size% LSS 75000 (set vol=1500m)
if %size% LSS 70000  (set vol=1400m)&&if %size% LSS 65000 (set vol=1300m)&&if %size% LSS 60000 (set vol=1200m)
if %size% LSS 55000  (set vol=1100m)&&if %size% LSS 50000 (set vol=1000m)&&if %size% LSS 45000  (set vol=900m)
if %size% LSS 40000   (set vol=800m)&&if %size% LSS 35000  (set vol=700m)&&if %size% LSS 30000  (set vol=600m)
if %size% LSS 25000   (set vol=500m)&&if %size% LSS 20000  (set vol=400m)&&if %size% LSS 15000  (set vol=300m)
if %size% LSS 10000   (set vol=200m)&&if %size% LSS  5000  (set vol=100m)&&if %size% LSS 2000    (set vol=40m)
if %size% LSS 1000     (set vol=20m)&&if %size% LSS   500   (set vol=10m)&&if %size% LSS 100      (set vol=2m)

:Pack_With_rar_or_7zip
title %Name% ^| Packing into %vol% Volumes
if not exist %wrar%   (goto Pack_With_7za)
if /i "%urar%"=="Yes" (goto Pack_With_rar) else (goto Pack_With_7za)
:Pack_With_rar
%wrar% a -hp"%rpwd%" -ep -m%rcom% -vn -v%vol% -ma4 "%Post%\%flnm%\%flnm%.rar" "%Post%\%flnm%\%inpt%"
goto endpack
:Pack_With_7za
%Apps%\7za a -v%vol% -mhe=on -mx=%zcom% -p"%rpwd%" "%Post%\%flnm%\%flnm%.7z" "%Post%\%flnm%\%inpt%"
:endpack

:Create_Ten_Percent_Par_And_Touch_Files
move "%inpt%" "%Srce%\%inpt%"
%Apps%\par2j64 c /rr10 /rd2 "%flnm%.par2" "*"
%Apps%\touch -t 200001011337.00 %Post%\%flnm%\*

:Get_Queue_Value_For_Queue_Work
title %Name% ^| Queuing %inpt%
set qval=1&&set tval=1
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

:Queue_Up
title %Name% ^| Queuing %inpt%
echo @echo off>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo call "%Apps%\Usenet_Login.bat">>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set Nzbd=%Nzbd%>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set Post=%Post%>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set Done=%Done%>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set inpt=%inpt%>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set rpwd="%rpwd%">>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set from=%from%>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set grps=%grps%>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set suba=-F --subject>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set rand=%rand:~-20%>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set subb=%subb%>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set flnm=%flnm%>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo set chek=--check-connections=1 --check-tries 2 --check-delay 5 --check-post-tries 10 >>"%Qdir%\%qval%_%inpt%.queue.bat"
echo cls^&^&title %Name% ^^^| Posting %inpt%>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo echo -^&^&echo Posting %inpt%^&^&echo ->>"%Qdir%\%qval%_%inpt%.queue.bat"
echo %%Apps%%\nyuu -M password=%%rpwd%% -h %%serv%% --port %%port%% --ssl -u %%user%% -p %%pass%% -f %%from%% -g %%grps%% %%suba%% "%%rand%% %%subb%%" -n 38 %%chek%% -o "%%Nzbd%%\%%inpt%%.nzb" "%%Post%%\%%flnm%%">>"%Qdir%\%qval%_%inpt%.queue.bat"
echo move %%Post%%\%%flnm%% %%Done%%\%%flnm%%>>"%Qdir%\%qval%_%inpt%.queue.bat"
echo timeout 3 >>"%Qdir%\%qval%_%inpt%.queue.bat"

:Clear_All_Variables_And_Reload_Script
title %Name% ^| Clearing Job Variables
set Tool=null&&set Apps=null&&set Nzbd=null&&set Done=null&&set Post=null
set Temp=null&&set Work=null&&set serv=null&&set grps=null&&set suba=null
set user=null&&set pass=null&&set inpt=null&&set rpwd=null&&set flnm=null
set rand=null&&set from=null&&set subb=null&&set size=null&&set pnpt=null
cls&&goto Set_Script_Variables

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
