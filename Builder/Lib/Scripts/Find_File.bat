@echo off

if "%~$PATH:1"=="" goto NotFound

::echo %~1 found

exit /b
:NotFound

::echo %~1 not found

exit /b 1
