@ECHO OFF
echo ---Defender Signature Update---
"%ProgramFiles%\WINDOW~1\MpCmdRun.exe" /signatureupdate

echo.
echo ---Scan Browser Cache---
echo --Edge--
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Microsoft\Windows
echo.
echo --FireFox--
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Mozilla
echo.
echo --Chrome--
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Google

echo.
echo --Scan Temp--
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File "%localappdata%\Temp"

echo.
echo ---Scan email temp folders---
echo --UWP Mail--
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File %localappdata%\Packages\microsoft.windowscommunicationsapps_8wekyb3d8bbwe\LocalState\Files
echo --Outlook--
powershell 'Start-MpScan -ScanPath "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\Content.Outlook\OIR8G0L6\" -ScanType CustomScan'

echo.
echo ---System File Check---
sfc /scannow
echo.
echo ---Image Cleanup---
dism /online /cleanup-image /checkhealth
REM dism /online /cleanup-image /startcomponentcleanup
REM could use ::
REM C:\Users\***REMOVED***\AppData\Locallow\sun\java\Deployment\cache
pause