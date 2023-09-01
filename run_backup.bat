REM Get the directory of the current script
set scriptDir=%~dp0

cd %scriptDir%

git pull

./backup.bat