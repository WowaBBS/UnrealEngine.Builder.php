@echo off
setlocal

set ZipFile=%~1
set OutDir=%~f2

if "%ZipFile%"=="" set ZipFile=%~dp0php.zip
if "%OutDir%"=="" set OutDir=%~dp0PHP

if not exist "%ZipFile%" goto :Failed

rmdir /S /Q "%OutDir%" 2>nul
mkdir "%OutDir%" 2>nul

powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%OutDir%'); $zip = $shell.NameSpace('%ZipFile%'); $target.CopyHere($zip.Items(), 16); }"

:Failed

endlocal