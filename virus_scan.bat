@ECHO OFF
echo [32m---Defender Signature Update---[0m
"%ProgramFiles%\WINDOW~1\MpCmdRun.exe" /signatureupdate

echo.
echo [32m---Scan Browser Caches---[0m
IF EXIST %localappdata%\Microsoft\Windows\ (
echo [36m--Edge--[0m
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Microsoft\Windows\
) ELSE ECHO Edge not installed

echo.
IF EXIST %localappdata%\Mozilla\ (
echo [36m--FireFox--[0m
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Mozilla\
) ELSE ECHO Firefox not installed
echo.
IF EXIST %localappdata%\Google\ (
echo [36m--Chrome--[0m
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Google\
) ELSE ECHO Chrome not installed
::stub
::echo.
::IF EXIST %localappdata%\some_browser\ (
::echo [36m--some_browser--[0m
::"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\some_browser
::) ELSE ECHO some other browser not installed

echo.
echo [32m---Scan Temp---[0m
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Temp\

echo.
echo [32m---Scan email temp folders---[0m
IF EXIST %localappdata%\Packages\microsoft.windowscommunicationsapps_8wekyb3d8bbwe\LocalState\Files\ (
echo [36m--UWP Mail--[0m
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Packages\microsoft.windowscommunicationsapps_8wekyb3d8bbwe\LocalState\Files\
) ELSE ECHO UWP Mail not installed
echo.
IF EXIST %localappdata%\Microsoft\Windows\INetCache\Content.Outlook\ (
echo [36m--Outlook--[0m
:: alternate method using powershell
powershell 'Start-MpScan -ScanPath "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\Content.Outlook\" -ScanType CustomScan'
) ELSE ECHO Outlook not installed.

echo.
echo [32m---Image Health Checkup---[0m
dism /online /cleanup-image /checkhealth
echo.
echo [32m---System File Check---[0m (CTRL^+C to quit)
PAUSE
sfc /scannow
REM dism /online /cleanup-image /startcomponentcleanup
REM could use ::
REM C:\Users\***REMOVED***\AppData\Locallow\sun\java\Deployment\cache
PAUSE