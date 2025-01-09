@echo off
chcp 65001 >nul
color 5
cls
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
setlocal enabledelayedexpansion

: success = Main
: menu = Password Menu
:UpdateCheck
set "currentVersion=1.0.0"  REM Set your current script version here
set "versionUrl=https://github.com/MichaelServices/QuantumMutitool/blob/main/Version"  REM URL to fetch the latest version

for /f "delims=" %%i in ('curl -s %versionUrl%') do set "latestVersion=%%i"

if "%latestVersion%" GTR "%currentVersion%" (
    echo A new version (%latestVersion%) is available! You are currently using version %currentVersion%.
    set /p updateChoice="Would you like to download the latest version? (Y/N): "
    if /i "%updateChoice%"=="Y" (
        echo Downloading the latest version...
        curl -O https://example.com/your_script.bat 
        echo Update complete! Please restart the script.
        exit /b
    ) else (
        echo You chose not to update. Continuing with the current version.
    )
) else (
    echo You are using the latest version (%currentVersion%).
)

goto menu

:menu
cls
echo.
echo                Made By Michael Services
title Password System V1
echo.
echo           ▒█▀▀█ █░░█ █▀▀█ █▀▀▄ ▀▀█▀▀ █░░█ █▀▄▀█ 
echo           ▒█░▒█ █░░█ █▄▄█ █░░█ ░░█░░ █░░█ █░▀░█ 
echo           ░▀▀█▄ ░▀▀▀ ▀░░▀ ▀░░▀ ░░▀░░ ░▀▀▀ ▀░░░▀
echo.
echo.
set /p pass=Password: 
echo.

if "%pass%"=="QuantumToolV1" goto success

echo [!] Invalid Login. Please try again... [!]
pause >nul
goto menu

:success
title Quantum Tool - Currently Logged in as [%user%]
cls
echo ▒█▀▀█ █░░█ █▀▀█ █▀▀▄ ▀▀█▀▀ █░░█ █▀▄▀█ 
echo ▒█░▒█ █░░█ █▄▄█ █░░█ ░░█░░ █░░█ █░▀░█ 
echo ░▀▀█▄ ░▀▀▀ ▀░░▀ ▀░░▀ ░░▀░░ ░▀▀▀ ▀░░░▀
echo -----------------------
echo [0] Settings
echo [1] WebhookSpammer
echo [2] Website Info Grab
echo [3] WindowCleaner (Messes with your menu)
echo [4] BSOD
echo [5] HTTPS Lagger
echo -----------------------

set /p a=Select an option [%user%]: 
if "%a%"=="0" goto Settings
if "%a%"=="1" goto WebhookSpam
if "%a%"=="2" goto website
if "%a%"=="3" goto WindowCleaner
if "%a%"=="4" goto BSOD
if "%a%"=="5" goto HTTPSLag


echo [!] Invalid Choice. Please try again... [!]
pause >nul
goto success

:WebhookSpam
cls
set /p "webhook_url=Enter your webhook URL: "
set /p "message=Enter your message: "
set /p "count=How many times do you want to send the message?: "

set "payload={\"content\": \"%message%\"}"
curl -H "Content-Type: application/json" -d "%payload%" "%webhook_url%"
for /L %%i in (1,1,%count%) do (
    curl -H "Content-Type: application/json" -d "%payload%" "%webhook_url%"
    echo Message sent %%i of %count%
)
goto success


:Website
cls
set /p website="Enter the website URL (e.g., example.com): "
echo Retrieving IP address for %website%...
cls
nslookup %website%
pause >nul
goto success



:WindowCleaner
cls
echo Cleaning up temporary files...
echo.
del /q /f "%TEMP%\*.*"
echo Deleted temporary files from %TEMP%.
del /q /f "C:\Windows\Temp\*.*"
echo Deleted temporary files from C:\Windows\Temp.
echo Clearing Recycle Bin...
PowerShell -Command "Clear-RecycleBin -Confirm:$false"
echo Recycle Bin cleared.
echo Clearing Windows Update Cache...
net stop wuauserv
del /q /f "C:\Windows\SoftwareDistribution\Download\*.*"
net start wuauserv
echo Windows Update Cache cleared.
echo Clearing browser cache...
del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*"
del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*"
echo Browser cache cleared.
echo Cleaning up other common locations...
del /q /f "C:\Users\%USERNAME%\AppData\Local\Temp\*.*"
del /q /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\INetCache\*.*"
echo Other common locations cleaned.
echo.
echo Cleanup complete!
cls
echo Your non needed files are now gone! ( Click enter to return to the main menu )
pause >nul
goto success


:Settings
cls
title Settings
echo.
echo ▒█▀▀█ █░░█ █▀▀█ █▀▀▄ ▀▀█▀▀ █░░█ █▀▄▀█ 
echo ▒█░▒█ █░░█ █▄▄█ █░░█ ░░█░░ █░░█ █░▀░█ 
echo ░▀▀█▄ ░▀▀▀ ▀░░▀ ▀░░▀ ░░▀░░ ░▀▀▀ ▀░░░▀
echo.
echo. 
echo This is a work in progress
echo [1] Red
echo [2] Yellow
echo [3] Blue
echo [4] Green

set /p a=Select an option [%user%]: 
if "%a%"=="1" goto Red


:Red
cls
color 4
goto success


:Yellow
cls
color 6
goto success


:Blue
cls
color 1
goto success


:Green
cls
color 2
goto success


:Aqua
cls
color 3
goto success


:ReturnColor
cls
echo Changing color ....
timeout /t 3
color 5
goto success

:BSOD

  REM
  >nul 2>&1 \"%SYSTEMROOT%\system32\cacls.exe\" \"%SYSTEMROOT%\system32\config\system\"
  
  REM
if '%errorlevel%' NEQ '0' (
    goto UACPrompt
  ) else ( goto gotAdmin )
  
:UACPrompt
echo Set UAC = CreateObject^(\"Shell.Application\"^) > \"%temp%\getadmin.vbs\"
echo UAC.ShellExecute \"%~s0\", \"\", \"\", \"runas\", 1 >> \"%temp%\getadmin.vbs\"
  
\"%temp%\getadmin.vbs\"
exit /B
  
:gotAdmin
if exist \"%temp%\getadmin.vbs\" ( del \"%temp%\getadmin.vbs\" )
pushd \"%CD%\"
CD /D \"%~dp0\"
taskkill /f /im ntoskrnl.exe
    goto success



:ENCRYPT
set "word="
set "shift=3"
echo Enter the word to encrypt:
set /p word=

set "encryptedWord="
for /l %%i in (0,1,31) do (
    set "char=!word:~%%i,1!"
    if "!char!"=="" goto ENCRYPT_DONE
    set /a "ascii=0"
    for /f %%j in ('echo "!char!" ^| cmd /u /c findstr /n "^"') do (
        set /a "ascii=%%j + 0"
    )
    set /a "newAscii=ascii + shift"
    set "newChar=!newAscii!"
    for /f %%k in ('cmd /u /c echo !newChar! ^| findstr /n "^"') do (
        set "encryptedWord=!encryptedWord!!newChar!"
    )
)

:HTTPSLag
setlocal
set /p "count=How many times do you want to send the message?: "
set /p "url=URL to send the message to: "
echo Sending GET request to %url%
curl -X GET "%url%"
set "jsonData={\"title\":\"foo\",\"body\":\"bar\",\"userId\":1}"
echo Sending POST request to %url%
curl -X POST "%url%" -H "Content-Type: application/json" -d "%jsonData%"

for /L %%i in (1,1,%count%) do (

    echo Message sent %%i of %count%
)
goto success