@echo off

setlocal

set Root=%~dp0
set PHP_Path=%Root%PHP
if not exist "%PHP_Path%\php.exe" if exist "%Root%\_InitPhp.bat" call "%Root%\_InitPhp.bat"
if not exist "%PHP_Path%\php.exe" call "%Root%DownloadPhp.bat"
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

"%PHP_Path%\php.exe" -c "%PHP_Path%" -f "%PHP_File%" -- %Args%

endlocal
