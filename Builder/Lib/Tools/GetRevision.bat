For /F "Delims=" %%I In ('call "%~dp0..\scripts\call_php.bat" "%~dp0GetRevision.php7"') Do Set SVN_REVISION=%%~I
echo SVN_REVISION=%SVN_REVISION%