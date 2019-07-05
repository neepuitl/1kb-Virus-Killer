@echo off
echo -------------------------------------------------------
echo.
echo          1KB lnks Virus Killer for Windows
echo.
echo -------------------------------------------------------

rem kill the virus procession

echo Killing virus procession...
echo.

taskkill /f /im wscript.exe

echo Success!
echo.

rem access U disk directory
for /f "skip=1" %%i in ('wmic logicaldisk where "drivetype=2" get caption') do %%i

rem list all the hiding files

dir /a:h /b >hfiles.txt 
for /f "tokens=* delims= " %%a in (hfiles.txt) do (
    if %%~xa==.vbe (
	rem %%a points to the virus
	call :killv "%%a"
    ) else (
	rem %%a points to the hiding directory
	call :recover "%%a"
    )
)
del hfiles.txt

rem Delete all the Inks

del *.lnk

echo.
echo All done!

pause

:killv
set var=%1
echo Find virus %var%
echo.
rem remove hiding attributes
attrib -a -s -h -r %var%
echo Killing virus %var%...
echo.
del %var%

:recover
set var=%1
echo Recovering %var%...
echo.
rem remove hiding attributes
attrib -a -s -h -r %var%