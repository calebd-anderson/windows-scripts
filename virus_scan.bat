@ECHO OFF
call :ProgressMeter 0
echo [32m---Defender Signature Update---[0m
"%ProgramFiles%\WINDOW~1\MpCmdRun.exe" /signatureupdate
call :ProgressMeter 10
echo.
echo [32m---Scan Browser Caches---[0m
IF EXIST %localappdata%\Microsoft\Windows\ (
echo [36m--Edge--[0m
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Microsoft\Windows\
call :ProgressMeter 20
) ELSE ECHO Edge not installed

echo.
IF EXIST %localappdata%\Mozilla\ (
echo [36m--FireFox--[0m
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Mozilla\
call :ProgressMeter 30
) ELSE ECHO Firefox not installed
echo.
IF EXIST %localappdata%\Google\ (
echo [36m--Chrome--[0m
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Google\
call :ProgressMeter 40
) ELSE ECHO Chrome not installed

echo.
echo [32m---Scan Temp---[0m
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Temp\
call :ProgressMeter 50

echo.
echo [32m---Scan email temp folders---[0m
IF EXIST %localappdata%\Packages\microsoft.windowscommunicationsapps_8wekyb3d8bbwe\LocalState\Files\ (
echo [36m--UWP Mail--[0m
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Packages\microsoft.windowscommunicationsapps_8wekyb3d8bbwe\LocalState\Files\
call :ProgressMeter 70
) ELSE ECHO UWP Mail not installed
echo.
IF EXIST %localappdata%\Microsoft\Windows\INetCache\Content.Outlook\ (
echo [36m--Outlook--[0m
:: alternate method using powershell
powershell 'Start-MpScan -ScanPath "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\Content.Outlook\" -ScanType CustomScan'
call :ProgressMeter 80
) ELSE ECHO Outlook not installed.

echo.
echo [32m---Image Health Checkup---[0m
dism /online /cleanup-image /checkhealth
echo.
echo [32m---System File Check---[0m (CTRL^+C to quit)
call :ProgressMeter 90
PAUSE
sfc /scannow
call :ProgressMeter 100
echo.
REM dism /online /cleanup-image /startcomponentcleanup
echo.
PAUSE
exit /b
:ProgressMeter
SETLOCAL ENABLEDELAYEDEXPANSION
SET ProgressPercent=%1
SET /A NumBars=%ProgressPercent%/2
SET /A NumSpaces=50-%NumBars%

SET Meter=

FOR /L %%A IN (%NumBars%,-1,1) DO SET Meter=!Meter!I
FOR /L %%A IN (%NumSpaces%,-1,1) DO SET Meter=!Meter!

TITLE Overall Progress:  [%Meter%]  %ProgressPercent%%%
ENDLOCAL
GOTO :EOF