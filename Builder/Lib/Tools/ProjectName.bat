For /F "Delims=" %%I In ('%Call_Php% "%~dp0ProjectName.php7"') Do Set PROJECT_NAME=%%~I
echo PROJECT_NAME=%PROJECT_NAME%