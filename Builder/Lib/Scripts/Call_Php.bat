@echo off

setlocal

set Root=%~dp0
::set PHP_Path=%~dp0..\..\..\Build\Tools\PHP
set PHP_Path=%~dp0..\..\..\Build\Tools\Php74
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

set Arg=
set Arg=%Arg% -d memory_limit=256M
set Arg=%Arg% -d "extension_dir=%PHP_Path%/ext"
set Arg=%Arg% -c "%PHP_Path%"
set Arg=%Arg% -f "%PHP_File%"

"%PHP_Path%\php.exe" %Arg% -- %Args%

endlocal
