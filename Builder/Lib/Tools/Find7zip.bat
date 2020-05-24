For /F "Delims=" %%I In ('call "%~dp0..\scripts\call_php.bat" "%~dp0Find7zip.php7"') Do Set SZIP_EXE=%%~I
echo SZIP_EXE=%SZIP_EXE%