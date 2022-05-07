@ECHO OFF
setlocal EnableDelayedExpansion

ECHO Importing Databases

rem echo %1 %2 %3 %4

set HOST=%1 || "localhost"
set PORT=%2 || "27017"

echo %HOST%:%PORT%

set auth=

if not "%3"=="" (
    if not "%4"=="" (
    	set  auth=--authenticationDatabase admin -u %3 -p %4
    )
)

for /D %%s in (*) do (
	rem \r
	for %%t in (%%s\*) do (
		rem echo %%t
		powershell write-host -fore Green Importing Collection %%~nxt for Database %%s  
		set db=%%s
		rem echo mongoimport --drop --host %1 --port %2 --db "!db:sample_=!" --collection "%%~nt" --file %%t !auth!
		mongoimport --drop --host %1 --port %2 --db "!db:sample_=!" --collection "%%~nt" --file %%t !auth!
	) 
) 


