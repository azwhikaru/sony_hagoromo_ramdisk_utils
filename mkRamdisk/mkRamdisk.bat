@ECHO OFF

:: Get Label
SET ramdiskPath="%1"

IF NOT EXIST %ramdiskPath% (
	ECHO. && ECHO Please enter the directory of the RAMDISK
	GOTO :EOF
)

:: Start Repack

ECHO.

ECHO Compressing RAMDISK...
mkbootfs.exe %ramdiskPath% | minigzip.exe > .\ramdisk.gz
ECHO Checking CPIOGZ head...
head.exe .\ramdisk.gz

:: Clean Up

ECHO Cleaning Up...
ECHO. && ECHO The output file is at %CD%\ramdisk.gz

@ECHO ON