@echo off
setlocal

set FileUrl=%~1
set OutFile=%~2
::set FileUrl=https://windows.php.net/downloads/releases/archives/php-7.2.4-Win32-VC15-x64.zip
::set OutFile=%~dp0php.zip
set Message=Loading %FileUrl%

del "%OutFile%" 2>nul
echo Loading %FileUrl%...

start "%Message%" /WAIT powershell.exe -nologo -noprofile -command "WGet -O %OutFile% %FileUrl%"

endlocal