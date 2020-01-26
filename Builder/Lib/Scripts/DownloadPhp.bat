@echo off
setlocal

set PhpDir=%~1
if "%PhpDir%"=="" set PhpDir=%~dp0../../../Build/Tools/Php74
set PhpZip=%~dp0php.zip
::set UrlPhpFile=php-7.2.4-Win32-VC15-x64.zip
set UrlPhpFile=php-7.4.1-Win32-vc15-x64.zip
set UrlPhp=https://windows.php.net/downloads/releases/archives/%UrlPhpFile%

call %~dp0DownloadFile.bat "%UrlPhp%" "%PhpZip%"
if exist "%PhpZip%" goto skip
set UrlPhp=https://windows.php.net/downloads/releases/%UrlPhpFile%
call %~dp0DownloadFile.bat "%UrlPhp%" "%PhpZip%"
:skip
call %~dp0UnZipFile.bat "%PhpZip%" "%PhpDir%"
del "%PhpZip%" 2>nul

endlocal