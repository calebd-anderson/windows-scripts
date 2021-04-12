@ECHO OFF
cls
echo [101;93m NORMAL FOREGROUND COLORS [0m
echo ^<ESC^>[30m [30mBlack[0m (black)
echo ^<ESC^>[31m [31mRed[0m
echo ^<ESC^>[32m [32mGreen[0m
echo ^<ESC^>[33m [33mYellow[0m
echo ^<ESC^>[34m [34mBlue[0m
echo ^<ESC^>[35m [35mMagenta[0m
echo ^<ESC^>[36m [36mCyan[0m
echo ^<ESC^>[37m [37mWhite[0m
::ask user for drive letter
echo [32mThis program unmounts a volume at the drive letter of your choice[0m
echo.
set /p drive=[36mEnter the drive letter you wish to forcefully unmount('X'):[0m 
SET drive=%drive%:\
::parse the mountvol command for the volume of the drive chosen
FOR /F %%G IN ('mountvol ^| findstr /n %drive%') DO SET _line=%%G 
SET /A LINE = %_line%
SET /A LINE -= 1
FOR /F "tokens=2" %%G IN ('mountvol ^| findstr /n ^^^^ ^| findstr "^%LINE%"') DO SET _vol=%%G
echo.
:: show the result 
echo [32mThe volume for[0m [33m%drive%[0m [32mis:[0m [33m%_vol%[0m
echo.
::ask user to enter any key to unmount
echo [34mPress any key to unmount the volume[0m [31m(CTRL^+C to terminate)[0m [34m. . .[0m & PAUSE >NUL
::unmount volume
echo [31mUnmounting[0m [33m%drive%[0m [31m. . .[0m
mountvol %drive% /p
echo.
:: ask user to enter any key to re-mount the volume
echo [34mPress any key to re-mount the volume (CTRL^+C to terminate) . . .[0m & PAUSE >NUL
echo [31mRe-mounting[0m [33m%drive%[0m [31m. . .[0m
mountvol %drive% %_vol%
echo.
pause
