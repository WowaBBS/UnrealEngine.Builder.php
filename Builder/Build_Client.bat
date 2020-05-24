@echo off

call "%~dp0Lib\Init.bat"

set WBuild_Root=%~dp0
set Arg=
set Arg=%Arg% -OutputFolder Build
::set Arg=%Arg% -CompileMode Development
%Call_Php% "%WBuild_Root%\Lib\Build.php7" %Arg% %*
