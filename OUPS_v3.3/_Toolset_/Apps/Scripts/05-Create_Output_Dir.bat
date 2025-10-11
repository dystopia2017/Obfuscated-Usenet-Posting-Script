@echo off&&title %Name% ^| Creating Job Directories
cd %Post%
mkdir %flnm%
cd %Work%
move %inpt% %Post%\%flnm%\%inpt%
cd %Post%\%flnm%