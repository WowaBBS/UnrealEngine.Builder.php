For /F "Delims=" %%I In ('%Call_Php% "%~dp0UnrealPath.php7"') Do Set UNREAL_PATH=%%~I
echo UNREAL_PATH=%UNREAL_PATH%