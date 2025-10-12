@echo off&&set Name=OUPS v3.8

:News_Server_Login_Details
set serv="null"
set port="null"
set user="null"
set pass="null"
:: serv is your news server address  e.g. "news.usenet.farm"                   
:: port is your port you wish to use e.g. "563" for ssl.                       
:: user is your username to login to your news server.                         
:: pass is your password to login to your news server.                         

:General_Settings
set urar=Yes
set rcom=0
set zcom=0
set parp=10
set asze=7000
set conn=10
set keep=No
:: urar is the "Use Rar" option, set to Yes to use rar.exe to handle packing.  
:: rcom is rar  compression level. 0 (No Compression) to 5 (Best Compression)  
:: zcom is 7zip compression level. 0 (No Compression) to 9 (Best Compression)  
:: parp is the percentage of par2 to create (recovery rate) default is 10.     
:: asze is the article size in kb, default is 700, Max on some hosts is 2000.  
:: conn is the ammount of connections to your news server, default is 10.
:: keep is a decision to keep posted files "Yes" or delete them "No".                

:Indexer_Support
set omgu=null
set omga=null
set omgc=null
set omgl=null
:: omgu is your username on a popular indexer. nzb won't be uploaded if null.  
:: omga is your api key  on a popular indexer. nzb won't be uploaded if null.  
:: omgc is the cat id    on a popular indexer. nzb won't be uploaded if null.  
:: omgl is the url of the popular indexer in the format https://name.org/      

:Check_News_Server_Has_Been_Set
if not %serv%=="null" (goto Run)
echo Error: You did not set your usenet login details. You need to right click 
echo        this script file and select "edit" from the context menu. Then set 
echo        your News Server Address, Posting Port, Username and Password.     
echo        -                                                                  
echo        Press any key to exit&&pause>nul&&exit                             

:Run
call %CD%\_Toolset_\Apps\Scripts\01-Set_Script_Paths.bat
call %Scpt%\02-Print_Queue_To_Shell.bat
call %Scpt%\03-Set_The_Input_Dir.bat
call %Scpt%\04-String_Gen.bat
call %Scpt%\05-Create_Output_Dir.bat
call %Scpt%\06-Pick_Random_Group.bat
call %Scpt%\07-Set_Split_Volume_Size.bat
call %Scpt%\08-Create_Split_Volumes.bat
call %Scpt%\09-Create_Parity_Files.bat
call %Scpt%\10-Check_For_Nfo.bat
call %Scpt%\11-Set_Queue_Value.bat
call %Scpt%\12-Queue_The_Job.bat
call %Scpt%\13-Clear_All_Variables.bat
goto Run