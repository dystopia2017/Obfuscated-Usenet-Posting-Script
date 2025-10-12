@echo off&&title %Name% ^| Queuing %inpt%

:Nyuu_Posting_Command
echo @echo off^&^&title %Name% ^^^| Posting %inpt%>>%Qdir%\%qval%_%inpt%.queue.bat
echo echo -^&^&echo Posting %inpt%^&^&echo ->>%Qdir%\%qval%_%inpt%.queue.bat
echo %Apps%\nyuu -M password="%rpwd%" -h %serv% --port %port% --ssl -u %user% -p %pass% -f %from% -g %grps% -F --subject "%rand:~-20% %subb%" -a %asze%K -n %conn% -o %Nzbc% "%Post%\%flnm%">>%Qdir%\%qval%_%inpt%.queue.bat

:Indexer_Checks_And_Work
if %omgu%==null (goto NZB_Zip)
if %omga%==null (goto NZB_Zip)
if %omgc%==null (goto NZB_Zip)
if %omgl%==null (goto NZB_Zip)
echo echo -^&^&echo Posting NZB to Indexer^&^&echo ->>%Qdir%\%qval%_%inpt%.queue.bat
echo %Apps%\curl -k -L -m 60 -F rlsname=%inpt% -F "catid=%omgc%" -F nzb=@%Nzbd%\%inpt:~1,-1%.nzb %nfop% "upload=upload" "%omgl%api-upload?user=%omgu%&api=%omga%"^>^>%Done%\%inpt%.txt>>%Qdir%\%qval%_%inpt%.queue.bat

:NZB_Zip
echo echo -^&^&echo Zipping NZB^&^&echo ->>%Qdir%\%qval%_%inpt%.queue.bat
echo %Apps%\7za a -mx=9 %Nzbd%\%inpt:~1,-1%.zip %Nzbd%\%inpt:~1,-1%.nzb>>%Qdir%\%qval%_%inpt%.queue.bat
echo if exist "%Nzbd%\%inpt:~1,-1%.nzb" (erase /q "%Nzbd%\%inpt:~1,-1%.nzb")>>%Qdir%\%qval%_%inpt%.queue.bat

:Clean_Up
if /I "%keep%"=="Yes" (goto Keep) else (goto Clear)
:Keep
echo echo -^&^&echo Moving Temp Files To %Done%^&^&echo ->>%Qdir%\%qval%_%inpt%.queue.bat
echo move %Post%\%flnm% %Done%\%flnm%>>%Qdir%\%qval%_%inpt%.queue.bat
goto End_Job_Queue
:Clear
echo echo -^&^&echo Erasing Temp Files^&^&echo ->>%Qdir%\%qval%_%inpt%.queue.bat
echo rmdir /s /q "%Post%\%flnm%">>%Qdir%\%qval%_%inpt%.queue.bat
echo if exist "%Done%\%inpt%.txt" (erase /q %Done%\%inpt%.txt)>>%Qdir%\%qval%_%inpt%.queue.bat
:End_Job_Queue