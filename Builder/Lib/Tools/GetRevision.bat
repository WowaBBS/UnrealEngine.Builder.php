For /F "Delims=" %%I In ('%Call_Php% "%~dp0GetRevision.php7"') Do Set SVN_REVISION=%%~I
echo SVN_REVISION=%SVN_REVISION%