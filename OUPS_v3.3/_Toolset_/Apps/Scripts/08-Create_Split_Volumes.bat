@echo off&&title %Name% ^| Creating Split Volumes
title %Name% ^| Packing into %vol% Volumes
if not exist %wrar%   (goto Pack_With_7za)
if /i "%urar%"=="Yes" (goto Pack_With_rar) else (goto Pack_With_7za)
:Pack_With_rar
%wrar% a -hp"%rpwd%" -m%rcom% -vn -v%vol% -ma4 "%Post%\%flnm%\%flnm%.rar" %inpt%
goto endpack
:Pack_With_7za
%Apps%\7za a -v%vol% -mhe=on -mx=%zcom% -p"%rpwd%" "%Post%\%flnm%\%flnm%.7z" %Post%\%flnm%\%inpt%
:endpack