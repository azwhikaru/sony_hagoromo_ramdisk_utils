@ECHO OFF

:: Get Label
SET cpioGzPath="%1"

IF NOT EXIST %cpioGzPath% (
	ECHO. && ECHO Please enter the directory of the RAMDISK.GZ
	GOTO :EOF
)

ECHO.

ECHO Creating Temporary Directory...
IF EXIST "%CD%\Temp" (
    RD /S /Q "%CD%\Temp"
)
MKDIR Temp
ECHO Copying RAMDISK...
COPY %cpioGzPath% .\Temp\cpio.gz 1>nul 2>nul
ECHO Checking RAMDISK head...
head.exe .\Temp\cpio.gz
ECHO Decompressing RAMDISK...
gzip.exe -d -f -q .\Temp\cpio.gz
ECHO Creating RAMDISK Directory...
MKDIR .\Temp\ramdisk
CD Temp\ramdisk
..\..\cpio.exe -idm < ..\cpio 1>nul 2>nul
ECHO Copying RAMDISK...
CD .. && CD..
IF EXIST "%CD%\ramdisk" (
    RD /S /Q "%CD%\ramdisk"
)
MOVE /Y Temp\ramdisk %CD% 1>nul 2>nul

:: Clean Up

ECHO Cleaning Up...
RD /S /Q "%CD%\Temp"
ECHO. && ECHO The output file is at %CD%\ramdisk

@ECHO ON