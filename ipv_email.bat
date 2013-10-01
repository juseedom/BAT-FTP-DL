@echo off
Set today=%3

Call:%1
cd /D "C:\Program Files\Microsoft Office\Office12\"
Outlook.exe /c ipm.note /a %2 /m ^%tolist%^&cc=^%cclist%^&subject=^%subcont%^&body=fyi
GoTo:EOF

:IPV_DATA
Set tolist=xxx
Set cclist=xxx
Set subcont=IPV_DATA_%today%
GoTo:EOF

:Cell_Status
Set tolist=xxx@gmail.com;xxx@rfoptim.com
Set cclist=
Set subcont=%today%_Daily_Cell_Unavailable_Rate
GoTo:EOF
