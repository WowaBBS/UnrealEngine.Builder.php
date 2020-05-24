@echo off

call "%~dp0Lib\Init.bat"

set WBuild_Root=%~dp0
set Arg=
set Arg=%Arg% -OutputFolder Build
set Arg=%Arg% -Server
set Arg=%Arg% -CompileMode DebugGame
%Call_Php% "%WBuild_Root%\Lib\Build.php7" %Arg% %*
