#Batch Zip Files
for /d %%X in (*) do 7z a "%%X.zip" "%%X\"


#Batch Unzip Files
for /r %%X in (*) do 7z x "%%X"

pause
