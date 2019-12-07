@echo off

setlocal

set Root=%~dp0
set PHP_Path=%~dp0..\..\..\Build\Tools\PHP
if not exist "%PHP_Path%/php.exe" if exist "%~dp0../_InitPhp.bat" call "%~dp0../_InitPhp.bat"
if not exist "%PHP_Path%/php.exe" call "%~dp0DownloadPhp.bat" "%PHP_Path%"
if not exist "%PHP_Path%/php.exe" echo %PHP_Path%/php.exe not found
set PHP_File=%~1
shift

set Args=%1
:Parse
shift
set First=%1
if not defined First goto :EndParse
  set Args=%Args% %First%
  goto :Parse
:EndParse

"%PHP_Path%\php.exe" -d memory_limit=256M -c "%PHP_Path%" -f "%PHP_File%" -- %Args%

endlocal
