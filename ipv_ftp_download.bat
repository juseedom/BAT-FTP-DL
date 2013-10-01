@ECHO OFF
:: Set the Parameter According Self-Requirement
Set ServerIP=xxx
Set ServerPath=%1
Set LocalPath="E:\TEMP\IPV_Data\"
Set FilterFile=%2

Set "FileList=mget"
Set FtpCommand=ls - %temp%\result.ftp
Call:FTPCmd

:: Filter Target File on FTP
FTP -v -n -s:"%temp%\script.ftp" %ServerIP%
FOR /F "Delims=" %%A IN ('"Findstr %FilterFile% ""%temp%\result.ftp"""') Do (Call Set FileList=%%FileList%% %%A)


IF "%FileList%" == "mget" GOTO End

:: Create Folder according to your filter keyword
mkdir %LocalPath%\%FilterFile%
Set LocalPath=%LocalPath%\%FilterFile%
Set FtpCommand=%FileList%
Call:FTPCmd

:: Download File From FTP
FTP -v -n -s:"%temp%\script.ftp" %ServerIP%

GOTO End

:: Create the temporary script file
:FTPCmd
> "%temp%\script.ftp" ECHO user xxx
>>"%temp%\script.ftp" ECHO xxx
>>"%temp%\script.ftp" ECHO cd %ServerPath%
>>"%temp%\script.ftp" ECHO lcd %LocalPath%
>>"%temp%\script.ftp" ECHO bin
>>"%temp%\script.ftp" ECHO prompt
>>"%temp%\script.ftp" ECHO %FtpCommand%
>>"%temp%\script.ftp" ECHO bye
GOTO:EOF
:End
:: Overwrite the temporary file before deleting it
IF exist "%temp%\script.ftp" (TYPE NUL >"%temp%\script.ftp" & DEL "%temp%\script.ftp")
IF exist "%temp%\result.ftp" (TYPE NUL >"%temp%\result.ftp" & DEL "%temp%\result.ftp")
