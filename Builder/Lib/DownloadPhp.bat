@echo off
cls

setlocal

set PhpDir=%~dp0PHP

if not exist "%PhpDir%\php.exe" goto :DownloadPhp
rem TODO: Test valid php

goto :SkipDownloading
:DownloadPhp

set PhpZip=%~dp0php.zip
set UrlPhp=https://windows.php.net/downloads/releases/archives/php-7.2.4-Win32-VC15-x64.zip

del "%PhpZip%" 2>nul
echo Loading PHP...
start "Downloading PHP" /WAIT bitsadmin.exe /transfer "Downloading PHP" "%UrlPhp%" "%PhpZip%"
mkdir "%PhpDir%" 2>nul
powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%PhpDir%'); $zip = $shell.NameSpace('%PhpZip%'); $target.CopyHere($zip.Items(), 16); }"

:SkipDownloading

endlocal