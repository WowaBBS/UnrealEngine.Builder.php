@echo off
set Now_Var=%1
set Now_Format=%~2
set Now_Time=%~3
if "%Now_Var%"=="" set Now_Var=COMPILE_TIME
if "%Now_Format%"=="" set Now_Format=Y-m-d H:i:s
if "%Now_Time%"=="" set Now_Format=now
::echo Now_Var    =%Now_Var%
::echo Now_Format =%Now_Format%
For /F "Delims=" %%I In ('call "%~dp0..\scripts\call_php.bat" "%~dp0GetDate.php7" "%Now_Format%" "%Now_Time%"') Do Set %Now_Var%=%%~I
setlocal enableDelayedExpansion
echo %Now_Var%=!%Now_Var%!
endlocal
