@echo off
setlocal

set PhpDir=%~1
if "%PhpDir%"=="" set PhpDir=%~dp0../../../Build/Tools/PHP
set PhpZip=%~dp0php.zip
set UrlPhp=https://windows.php.net/downloads/releases/archives/php-7.2.4-Win32-VC15-x64.zip
::TODO: set UrlPhp=https://windows.php.net/downloads/releases/archives/php-7.3.7-Win32-VC15-x64.zip

call %~dp0DownloadFile.bat "%UrlPhp%" "%PhpZip%"
call %~dp0UnZipFile.bat "%PhpZip%" "%PhpDir%"
del "%PhpZip%" 2>nul

endlocal