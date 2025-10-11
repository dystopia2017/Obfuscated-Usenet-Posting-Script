@echo off&&title %Name% ^| Queuing The Job
title %Name% ^| Queuing %inpt%
echo @echo off>>%Qdir%\%qval%_%inpt%.queue.bat
echo set Apps=%Apps%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set Nzbc=%Nzbc%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set Nzbd=%Nzbd%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set Post=%Post%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set Done=%Done%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set inpt=%inpt%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set rpwd="%rpwd%">>%Qdir%\%qval%_%inpt%.queue.bat
echo set from=%from%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set grps=%grps%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set suba=-F --subject>>%Qdir%\%qval%_%inpt%.queue.bat
echo set rand=%rand:~-20%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set subb=%subb%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set flnm=%flnm%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set asze=%asze%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set conn=%conn%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set nfop=%nfop%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set serv=%serv%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set port=%port%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set user=%user%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set pass=%pass%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set omgu=%omgu%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set omga=%omga%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set omgc=%omgc%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set omgl=%omgl%>>%Qdir%\%qval%_%inpt%.queue.bat
echo set chek=--check-connections=1 --check-tries 2 --check-delay 5 --check-post-tries 10 >>%Qdir%\%qval%_%inpt%.queue.bat
echo cls^&^&title %Name% ^^^| Posting %inpt%>>%Qdir%\%qval%_%inpt%.queue.bat
echo echo -^&^&echo Posting %inpt%^&^&echo ->>%Qdir%\%qval%_%inpt%.queue.bat
echo %%Apps%%\nyuu -M password=%%rpwd%% -h %%serv%% --port %%port%% --ssl -u %%user%% -p %%pass%% -f %%from%% -g %%grps%% %%suba%% "%%rand%% %%subb%%" -a %%asze%%K -n %%conn%% -o %%Nzbc%% "%%Post%%\%%flnm%%">>%Qdir%\%qval%_%inpt%.queue.bat
echo move %%Post%%\%%flnm%% %%Done%%\%%flnm%%>>%Qdir%\%qval%_%inpt%.queue.bat
if %omgu%==null (goto jump)
if %omga%==null (goto jump)
if %omgc%==null (goto jump)
if %omgl%==null (goto jump)
echo %%Apps%%\curl -k -L -m 60 -F rlsname=%%inpt%% -F "catid=%%omgc%%" -F nzb=@%%Nzbd%%\%%inpt:~1,-1%%.nzb %%nfop%% "upload=upload" "%%omgl%%api-upload?user=%%omgu%%&api=%%omga%%"^>^>%%Done%%\%%inpt%%.txt>>%Qdir%\%qval%_%inpt%.queue.bat
:jump
echo %%Apps%%\7za a -mx=9 %%Nzbd%%\%%inpt:~1,-1%%.zip %%Nzbd%%\%%inpt:~1,-1%%.nzb>>%Qdir%\%qval%_%inpt%.queue.bat
echo if exist "%%Nzbd%%\%%inpt:~1,-1%%.nzb" (erase /q "%%Nzbd%%\%%inpt:~1,-1%%.nzb")>>%Qdir%\%qval%_%inpt%.queue.bat
echo timeout 3 >>%Qdir%\%qval%_%inpt%.queue.bat