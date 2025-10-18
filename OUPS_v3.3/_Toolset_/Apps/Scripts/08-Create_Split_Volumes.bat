@echo off&&title %Name% ^| Creating Split Volumes
title %Name% ^| Packing into %vol% Volumes

:Rar_Check
if /i not "%urar%"=="Yes" (goto Pack_With_7za)
if exist %orar% (goto PaPack_With_RAR_Four) else (goto Pack_With_RAR_Five)

:Pack_With_RAR_Four
if not exist %orar%   (goto Pack_With_7za)
%orar% a -hp"%rpwd%" -m%rcom% -vn -v%vol% -ma4 "%Post%\%flnm%\%flnm%.rar" %inpt%
goto endpack

:Pack_With_RAR_Five
if not exist %wrar%   (goto Pack_With_7za)
%wrar% a -hp"%rpwd%" -m%rcom% -vn -v%vol% -m5 "%Post%\%flnm%\%flnm%.rar" %inpt%
goto endpack

:Pack_With_7za
%Apps%\7za a -v%vol% -mhe=on -mx=%zcom% -p"%rpwd%" "%Post%\%flnm%\%flnm%.7z" %Post%\%flnm%\%inpt%
goto endpack

:endpack
