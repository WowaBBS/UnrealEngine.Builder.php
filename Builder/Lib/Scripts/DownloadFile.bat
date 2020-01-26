@echo off
setlocal

set FileUrl=%~1
set OutFile=%~2
::set OutFile=%~dp0php.zip
::set FileUrl=https://windows.php.net/downloads/releases/archives/php-7.2.4-Win32-VC15-x64.zip

call %~dp0DownloadFile_WGet.bat "%FileUrl%" "%OutFile%"

if exist "%OutFile%" goto :Finish

call %~dp0DownloadFile_BitsAdmin.bat "%FileUrl%" "%OutFile%"

:Finish

endlocal