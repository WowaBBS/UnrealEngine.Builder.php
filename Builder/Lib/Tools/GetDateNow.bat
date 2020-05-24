@echo off
set Now_Var=%1
set Now_Format=%~2
if "%Now_Var%"=="" set Now_Var=COMPILE_TIME
if "%Now_Format%"=="" set Now_Format=Y-m-d H:i:s
::echo Now_Var    =%Now_Var%
::echo Now_Format =%Now_Format%
For /F "Delims=" %%I In ('call "%~dp0..\scripts\call_php.bat" "%~dp0GetDateNow.php7" "%Now_Format%"') Do Set %Now_Var%=%%~I
setlocal enableDelayedExpansion
echo %Now_Var%=!%Now_Var%!
endlocal
