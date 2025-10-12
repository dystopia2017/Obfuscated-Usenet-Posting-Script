**Obfuscated Usenet Posting Script v3.8
by dystopia2017**

**About**
OUPS is a simple Windows batch script that ties together a few CLI applications and makes obfuscated posting to Usenet simple. Each post will have a random and unique file name, directory name, poster name, and subject. Each post will have a random and unique 40-character password with obfuscated filenames. The newsgroup that will be used for posting will be a random choice from the sixty largest groups. After posting the only way you can access the content of the posts is with the NZB as this is the only place the password is stored, so keep it safe. `7-Zip` is the default tool for creating the split-volume archives. `RAR` is supported if WinRAR is installed on your system. Up to 99,999 files or directories can be queued up for posting. As of version 3.3 basic indexer api support has been added for a popular indexer.

https://github.com/user-attachments/assets/f1e5fc27-e1be-4ad3-9ae5-369f26e35c40

**Setup**
First, download the release, as it has the files and folder structure set up correctly. The only thing you must configure is your news server, port, username, and password. These need to be entered into the main script `oups_v3.8.bat`. Below is an example, make sure you put your entries between the " " double quotes and do not remove them.<br>

set serv="news.newsserver.com"<br>
set port="563"<br>
set user="my_username"<br>
set pass="my_password"<br>

**Optional Settings**
You can optionally configure the following variables in `oups_v3.8.bat`

`urar`<br>
Is the "Use Rar" option, set to `Yes` to use `rar.exe` to handle packing. If WinRAR is not installed on the system in %PROGRAMFILES%\WinRAR then packing will fall back `7-Zip` regardless what you set the `urar` variable to.

`rcom`<br>
Is the `RAR` Compression Level, the default is `0`, which is `m0` or `store` You can change it to any value up to `5`, which is `m5` or `best`. Keep in mind using compression will slow down the process and will offer no benefit for media files such as videos and music.

`zcom`<br>
Is the `7-Zip` Compression Level the default is `0`, which is no compression. You can change it to any value up to `9`, which is the best compression. Keep in mind using compression will slow down the process and will offer no benefit for media files such as videos and music.

`parp`<br>
Is the "Par2 Percentage" aka "Recovery Rate" the default value is `10%`. You can change this to anything you want, but anything above `20%` may not be sensible and will increase process time and posting time.

`asze`<br>
Is the "Article Size" in Kilobytes. The default value for posting is `700` Increasing the size will result in smaller output `NZBs` it's worth increasing it for large posts of `500 GB` or greater otherwise I would leave it alone. Keep in mind the maximum article size supported by many news servers is `2000` so do not go above this.                    

`conn`<br>
Is the number of connections that will be made to your news server when posting. The default value is `10` increasing the value can dramatically increase posting speed, but your news server will have a limit so check what it is before changing this value.

`keep`<br>
This variable is a choice for you to keep `yes` or erase `no` the temporary files after a post is done. The default behavior is to erase these files. If you choose to keep them they will be moved to \_Toolset_\Posted\ after a post is complete.

**Indexer Settings**
I have added support for a popular indexer, If you use this functionality then the script will use `cURL` to upload the NZB to the indexer via its api after a post is complete, I am not naming the indexer but you should be able to work it out or modify these settings to match the indexers you use.

`omgu` Is your user    on a popular indexer. The NZB won't be uploaded if null.<br>
`omga` Is your api key on a popular indexer. The NZB won't be uploaded if null.<br>
`omgc` Is the  Cat ID  on a popular indexer. The NZB won't be uploaded if null.<br>
`omgl` Is the  URL     of a popular indexer. The format is https://name.org/ <br>

**Usage**
OUPS accepts either files or directories as inputs. Place your input files and  directories into the _Process_ directory. Then Double click the script to open it. The script will then begin, packaging up the files and directories ready to post. Your source directories and files will be moved to `_Source_` after processing is complete.<br>

**License**
`Obfuscated Usenet Posting Script` by dystopia2017 is marked with `CC0 1.0 Universal`. This license applies to every .bat script file included in this project. All other included binaries have their own licenses and are documented below.<br>

**Credits**
Program Used: 7za.exe is the 7-Zip CLI from Igor Pavlov.<br>
Project Page: https://www.7-Zip.org/<br>
License Used: "GNU LGPL" as main license for most of the code.<br>
License Used: "BSD 3-clause License" for some code.<br>
License Used: "BSD 2-clause License" for some code.<br>

Program Used: curl.exe is a networking tools by Daniel Stenberg.<br>
Project Page: https://curl.se/<br>
License Used: Custom License inspired by MIT/X<br>

Program Used: du.exe, sed.exe, sort.exe, touch.exe are CLI apps from GNU.<br>
Project Page: https://www.gnu.org/software/coreutils/<br>
License Used: GPLv3<br>

Program Used: libiconv2.dll, libintl3.dll and regex2.dll are DLLs from GNU.<br>
Project Page: https://www.gnu.org/software/coreutils/<br>
License Used: GPLv3<br>

Program Used: fart.exe (Find and Replace Text) a CLI app from Lionello Lunesu.<br>
Project Page: https://github.com/lionello/fart-it<br>
License Used: GPLv2<br>

Program Used: nyuu.exe is a CLI binary Usenet poster by Anime Tosho.<br>
Project Page: https://github.com/animetosho/Nyuu<br>
License Used: CC0 1.0<br>

Program Used: par2.exe is a CLI parity file tool by Anime Tosho.<br>
Project Page: https://github.com/animetosho/par2cmdline-turbo/<br>
License Used: GPLv2<br>
