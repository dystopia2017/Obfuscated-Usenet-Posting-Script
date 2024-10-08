**Obfuscated Usenet Posting Script
by dystopia2017**
 
**About:** <br>
OUPS is a simple Windows batch script that ties together a few CLI applications and makes Obfuscated posting to usenet simple. Each post will have a random and unique file name, directory name, poster name and subject. Each post will have a random and unique 127 character password with encrypted filenames. The usenet group that will be used for posting will be a random choice from the ten largest groups. After posting the only way you can access the content of the posts is with the nzb as this is the only place the password is stored, so keep them safe. 7zip is the default tool for creating the split volume archives, but rar is supported if WinRAR is installed on your system. Upto 99,999 files or directories can be queued up for posting.
 
**Setup:** <br>
Firstly download the release as it has the files and folder structure set up correctly, Then the only thing to configure is your usenet server, port, username and password, these need to be entered into the `Usenet_Login.bat` file located in the Apps dir. `X:\_OUPS_\_Toolset_\Apps` below is an example, make sure you put your entries between the " " double quotes and do not remove them.
 
`set serv="news.newsserver.com"` <br>
`set port="563"` <br>
`set user="my_username"` <br>
`set pass="my_password"` <br>
 
**Normal Usage:** <br>
OUPS accepts either a file or a directory as an input. Place your input in the same directory as the script e.g. `X:\_OUPS_\` and then Double click the script to open it. With the script open type in the name of the input file or directory to be posted. You can type a few letters of the input name then hit tab to auto complete the name. 
 
**Automated Usage:** <br>
If you have lots of files or directories to post, you can place them all in the `_Process_` directory. Then when you open the script, each item in the `_Process_` directory will be used. 
 
**Process:** <br>
In both Normal and Automated usage the input file or directory is first moved to a directory with a random unique name in `X:\_OUPS_\_Toolset_\Posting` then this directory is added to a split volume archive with a random filename, the archive has filename encryption, and uses a 127 character password (This is the max password length supported by WinRAR). Then 10% par2 parity files are created with Multipar. Then this directory will be added to a numbered queue file in `X:\_OUPS_\_Toolset_\Queue`. You can then add more files or directories to the queue following the above steps. When you are ready to post the queue you type `a` or `run` in the script. It will then begin the posting process using nyuu. Each post has a random poster name. As the files are being posted nyuu checks the posts are ok, and will repost any damaged or incomplete articles it sees. After a post is finnished the files will be moved from `X:\_OUPS_\_Toolset_\Posting` to `X:\_OUPS_\_Toolset_\Posted` as will the queue file that was in use. Finally an nzb with the password used will be output in `X:\_OUPS_\_Toolset_\NZBs` The script will then post the next item in the queue, or announce that posting is complete if no more items exist in the queue.
 
**Settings:** <br>
If you open the script in a text editor you will see this section
 
`:Set_Script_Variables` <br>
`set urar=No` <br>
`set rcom=0` <br>
`set zcom=0` <br>
 
These three vars can be changed, If you change `set urar=No` to `set urar=Yes` It will enable using WinRAR's rar.exe cli tool, This functionality requires you to have WinRAR installed on your system for it to work. It will check if it's installed in `%PROGRAMFILES%\WinRAR\rar.exe` If it's found rar will be used for the split volume archive. If it's not found, then 7zip will be used regardless of what you `set urar=` to. 
 
`set rcom=0` and `set zcom=0` are compression levels for rar and 7zip. They default to 0 which is no compression. This is the fastest way to create an archive and usually what you want if you are posting non compressable content like video or audio. You can change these values, The higher values have diminishing returns and longer processing time. <br>
`The values for rcom are: 0 (No Compression) to 5 (Best Compression)` <br>
`The values for zcom are: 0 (No Compression) to 9 (Best Compression)` <br>
 
**License:** <br>
Obfuscated Usenet Posting Script by dystopia2017 is marked with CC0 1.0 Universal.

**Credits:** <br>
Program Used: 7za.exe is the 7zip CLI from Igor Pavlov <br>
Project Page: https://www.7-zip.org/<br>
License Used: "GNU LGPL" as main license for most of the code <br>
License Used: "BSD 3-clause License" for some code <br>
License Used: "BSD 2-clause License" for some code <br>
 
Program Used: bw.exe is the Bitwarden CLI client from Bitwarden. <br>
Project Page: https://github.com/bitwarden <br>
License Used: GPLv3 <br>
 
Program Used: du.exe, sed.exe, sort.exe, touch.exe are cli apps from GNU. <br>
Project Page: https://www.gnu.org/software/coreutils/ <br>
License Used: GPLv3 <br>
 
Program Used: fart.exe (Find and Replace Text) a CLI app from Lionello Lunesu. <br>
Project Page: https://github.com/lionello/fart-it <br>
License Used: GPLv2 <br>
 
Program Used: nyuu.exe is a CLI binary usenet poster by Anime Tosho <br>
Project Page: https://github.com/animetosho/Nyuu <br>
License Used: CC0 <br>
 
Program Used: par2j64.exe is a CLI parity file tool from Yutaka Sawada. <br>
Project Page: https://hp.vector.co.jp/authors/VA021385/ <br>
License Used: GPLv3 <br>
