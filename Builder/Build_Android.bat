@echo off

call "%~dp0Lib\Init.bat"

set WBuild_Root=%~dp0
set Arg=
set Arg=%Arg% -OutputFolder Build
set Arg=%Arg% -Platform Android
set Arg=%Arg% -CookFlavor ETC2
set Arg=%Arg% -CompileMode Development
::set Arg=%Arg% -Server
%Call_Php% "%WBuild_Root%\Lib\Build.php7" %Arg% %*
