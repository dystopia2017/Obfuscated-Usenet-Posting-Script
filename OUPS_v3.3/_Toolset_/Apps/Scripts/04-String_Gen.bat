@echo off&&set valu=1&&title %Name% ^| Generating Random Strings for %inpt%

:Clear_Variables_Before_Starting
set rnum=
set rpwd=
set flnm=
set rand=

:Generate_Password
call :Random_Number
call :LUNS_Characters rnum
set rpwd=%rpwd%%rnum%
if "%valu%"=="40" (set valu=1&&goto Generate_Filename) else (set /a valu=valu+1&&goto Generate_Password)

:Generate_Filename
call :Random_Number
if not %rnum% LEQ 71 (goto Generate_Filename)
call :LN_Characters rnum
set flnm=%flnm%%rnum%
if "%valu%"=="8" (set valu=1&&goto Generate_Random_String) else (set /a valu=valu+1&&goto Generate_Filename)

:Generate_Random_String
call :Random_Number
if not %rnum% LEQ 62 (goto Generate_Random_String)
call :LUN_Characters rnum
set rand=%rand%%rnum%
if "%valu%"=="40" (set valu=1&&goto Generation_Done) else (set /a valu=valu+1&&goto Generate_Random_String)


:FUNCTIONS
:Random_Number
set rnum=0%random%
set rnum=%rnum:~-2%
GOTO:EOF
:LUNS_Characters
for %%i in ("00=\" "01=a" "02=b" "03=c" "04=d" "05=e" "06=f" "07=g" "08=h" "09=i" "10=j" "11=k" "12=l" "13=m" "14=n" "15=o" "16=p" "17=q" "18=r" "19=s" "20=t" "21=u" "22=v" "23=w" "24=x" "25=y" "26=z" "27=A" "28=B" "29=C" "30=D" "31=E" "32=F" "33=G" "34=H" "35=I" "36=J" "37=K" "38=L" "39=M" "40=N" "41=O" "42=P" "43=Q" "44=R" "45=S" "46=T" "47=U" "48=V" "49=W" "50=X" "51=Y" "52=Z" "53=0" "54=1" "55=2" "56=3" "57=4" "58=5" "59=6" "60=7" "61=8" "62=9" "63=#" "64=$" "65=." "66=." "67=@" "68=-" "69=@" "70=_" "71=!" "72=+" "73=[" "74=]" "75={" "76=}" "77=\" "78=/" "79=:" "80=;" "81=," "82='" "83=`" "84=!" "85=~" "86=#" "87=$" "88=." "89=." "90=+" "91=-" "92=@" "93=_" "94=!" "95=+" "96=[" "97=]" "98={" "99=}") DO CALL set "%1=%%%1:%%~i%%"
GOTO:EOF
:LN_Characters
for %%i in ("00=0" "01=1" "02=2" "03=3" "04=4" "05=5" "06=6" "07=7" "08=8" "09=9" "10=a" "11=b" "12=c" "13=d" "14=e" "15=f" "16=g" "17=h" "18=i" "19=j" "20=k" "21=l" "22=m" "23=n" "24=o" "25=p" "26=q" "27=r" "28=s" "29=t" "30=u" "31=v" "32=w" "33=x" "34=y" "35=z" "36=0" "37=1" "38=2" "39=3" "40=4" "41=5" "42=6" "43=7" "44=8" "45=9" "46=a" "47=b" "48=c" "49=d" "50=e" "51=f" "52=g" "53=h" "54=i" "55=j" "56=k" "57=l" "58=m" "59=n" "60=o" "61=p" "62=q" "63=r" "64=s" "65=t" "66=u" "67=v" "68=w" "69=x" "70=y" "71=z") DO CALL set "%1=%%%1:%%~i%%"
GOTO:EOF
:LUN_Characters
for %%i in ("00=0" "01=1" "02=2" "03=3" "04=4" "05=5" "06=6" "07=7" "08=8" "09=9" "10=a" "11=b" "12=c" "13=d" "14=e" "15=f" "16=g" "17=h" "18=i" "19=j" "20=k" "21=l" "22=m" "23=n" "24=o" "25=p" "26=q" "27=r" "28=s" "29=t" "30=u" "31=v" "32=w" "33=x" "34=y" "35=z" "36=A" "37=B" "38=C" "39=D" "40=E" "41=F" "42=G" "43=H" "44=I" "45=J" "46=K" "47=L" "48=M" "49=N" "50=O" "51=P" "52=Q" "53=R" "54=S" "55=T" "56=U" "57=V" "58=W" "59=X" "60=Y" "61=Z" "62=9") DO CALL set "%1=%%%1:%%~i%%"
GOTO:EOF


:Generation_Done
set from="%rand:~0,4% %rand:~4,4%@%rand:~8,4%.%rand:~12,4%"

set subb=- {%rand:~-20%} yEnc ({part}/{parts})
