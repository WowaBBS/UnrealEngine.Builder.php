@echo off
echo %1
shift
echo %*

set Args=%1
:Parse
shift
set First=%1
if not defined First goto :EndParse
  set Args=%Args% %First%
  goto :Parse
:EndParse
echo %Args%
