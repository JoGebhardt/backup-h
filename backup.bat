@echo off
REM This script is designed for managing file transfers.
REM Initialize to run the script in minimized mode if not already so.
if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min "%~dpnx0" %* && exit

SETLOCAL ENABLEDELAYEDEXPANSION

REM Get the directory of the current script
set scriptDir=%~dp0

REM Check if the Logs folder exists; if not, create it
if not exist "%scriptDir%Logs\" (
    mkdir "%scriptDir%Logs"
)

for %%D in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    call :loopBody %%D
)
goto endScript

:loopBody
REM Check if drive exists
if not exist %1:\ exit /b

for /F "skip=1 delims=" %%F in ('wmic PATH Win32_LocalTime GET Day^,Month^,Year /FORMAT:TABLE') do (
    for /F "tokens=1-3" %%L in ("%%F") do (
        set currDay=0%%L 
        set currMonth=0%%M
        set currYear=%%N
    )
)
set currDay=%currDay:~-2%
set currMonth=%currMonth:~-2%
set currHour=%time:~0,2%
if %currHour% lss 10 (set currHour=0%time:~1,1%)
set currMinute=%time:~3,2%
set currSecond=%time:~6,2%

set filename=Netzfestplatte_to_%1_Logs_%currDay%-%currMonth%-%currYear%_%currHour%-%currMinute%-%currSecond%.txt
set directory=%scriptDir%Logs\

@REM findstr /m "Netzfestplatte" Z:\NetzfestplatteHalle\name.txt >Nul
@REM if !errorlevel!==1 exit /b

findstr /m "Sicherung" %1:\name.txt >Nul 2>&1
if !errorlevel!==1 exit /b

Robocopy Z:\NetzfestplatteHalle\NetzfestplatteHalle %1:\Dokumente /mir /unilog+:"%directory%%filename%"
exit /b

:endScript