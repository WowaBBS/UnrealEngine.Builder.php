For /F "Delims=" %%I In ('%Call_Php% "%~dp0Find7zip.php7"') Do Set SZIP_EXE=%%~I
echo SZIP_EXE=%SZIP_EXE%