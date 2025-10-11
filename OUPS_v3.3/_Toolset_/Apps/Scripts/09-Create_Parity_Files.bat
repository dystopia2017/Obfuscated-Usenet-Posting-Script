@echo off&&title %Name% ^| Creating Parity Files And Touch All Files
move %inpt% %Srce%\%inpt%
%Apps%\par2 c -r%parp% "%flnm%.par2" "*"
%Apps%\touch -t 200001011337.00 %Post%\%flnm%\*