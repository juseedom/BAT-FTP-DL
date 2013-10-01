@echo off
rem Set today=%date:~6,4%%date:~3,2%%date:~0,2%
Set today=20131001
>  %temp%\folder.ftp ECHO."/export/home/omc/var/prs/result_file/IPV_Scheduled_Per_Night_Hour" 
>> %temp%\folder.ftp ECHO."/export/home/omc/var/prs/result_file/3G_traffic_perhour" 
>> %temp%\folder.ftp ECHO."/export/home/omc/var/prs/result_file/IPV_Schedule_Daily" 
>> %temp%\folder.ftp ECHO."/export/home/omc/var/prs/result_file/IPV_Scheduled_Hourly" 
>> %temp%\folder.ftp ECHO."/export/home/omc/var/prs/result_file/IPV_Scheduled_per_night"
FOR /F %%A IN (%temp%\folder.ftp) Do ((Set ftp_path=%%A)&(Call:FTPDF))

:: Zip the files for email attachment
7z a %temp%\IPV_DATA%today%.zip "E:\TEMP\IPV_Data\%today%"

:: Send the email
Call "email.bat" IPV_DATA %temp%\IPV_DATA%today%.zip %today%

IF exist "%temp%\folder.ftp" (TYPE NUL >"%temp%\folder.ftp" & DEL "%temp%\folder.ftp")
goto:eof

:FTPDF
echo.%ftp_path%
call "ftp_download.bat" %ftp_path% %today%
goto:eof
