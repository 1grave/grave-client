@echo off
setlocal enabledelayedexpansion

set TOOL_ROOT=%USERPROFILE%\.grave-client\tools
set JAVA_DIR=%TOOL_ROOT%\jdk-17
set JAVA_EXE=%JAVA_DIR%\bin\java.exe
set BUILD_DIR=%USERPROFILE%\.grave-client\build
set SOURCE_FILES=

if not exist "%JAVA_EXE%" (
  echo Java 17 is required but was not found.
  echo Run install.bat first.
  pause
  exit /b 1
)

mkdir "%BUILD_DIR%" 2>nul

for /r src\main\java %%f in (*.java) do (
  set SOURCE_FILES=!SOURCE_FILES! "%%f"
)

"%JAVA_DIR%\bin\javac.exe" -d "%BUILD_DIR%" %SOURCE_FILES%
if errorlevel 1 (
  echo Compilation failed.
  pause
  exit /b 1
)

"%JAVA_EXE%" -cp "%BUILD_DIR%" com.grave.launcher.LauncherApp
if errorlevel 1 (
  echo Launcher failed to start.
  pause
  exit /b 1
)
