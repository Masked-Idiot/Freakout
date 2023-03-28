@echo off
:FreakCCompiled
set mode=%~1
set pkg=%~2
set curdir=%cd%
set name=%~3
goto main
:Freakout
mkdir "%appdata%/Freakout"
exit /b 0
:install
git clone "https://github.com/%pkg%"
exit /b 0
:update
call uninstall
call install
exit /b 0
:uninstall
rmdir /s "%pkg%"
exit /b 0
:main
if not exist "%appdata%/Freakout" (
call Freakout
)
if not "%mode%" == "create-project"(
cd "%appdata/Freakout%"
)
if "%mode%" == "install" (
call install
)
if "%mode%" == "remove" (
call uninstall
)
if "%mode%" == "update" (
call update
)
if "%mode%" == "create-project" (
set project.name=%pkg*/=%
git clone "%pkg%"
REN "%project.name%" "%name%"
cd "%name%"
if exist "project.fconfig" (
<project.fconfig (
set /p template.name=
set /p template.deps=
if exist "%template.deps%" (
for /f "tokens=* delims=" %%i in ("%template.deps%") do (
if not exist "%appdata%/Freakout/%%i" (
echo."Error: Dependency not found"
echo."Dependency: %%i"
echo."Please install all of the dependencies before creating this project again"
) 
)
)
)
) else (
cd ..
rmdir /s "%name%"
echo."This is not a valid FreakC package"
echo."Missing file: project.fconfig"
)
)
cd %curdir%
exit /b 0
