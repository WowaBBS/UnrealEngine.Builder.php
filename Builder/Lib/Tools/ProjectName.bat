For /F "Delims=" %%I In ('call "%~dp0..\scripts\call_php.bat" "%~dp0ProjectName.php7"') Do Set PROJECT_NAME=%%~I
echo PROJECT_NAME=%PROJECT_NAME%