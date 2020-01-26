@echo off
if not "%2"=="" goto skip
choice /m %1
if %errorlevel% equ 2 exit
:skip
