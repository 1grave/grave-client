@echo off
setlocal enabledelayedexpansion

set TOOL_ROOT=%USERPROFILE%\.grave-client\tools
set JAVA_DIR=%TOOL_ROOT%\jdk-17
set JAVA_EXE=%JAVA_DIR%\bin\java.exe
set JDK_ZIP=%TEMP%\grave-jdk17.zip
set BUILD_DIR=%USERPROFILE%\.grave-client\build

if not exist "%JAVA_EXE%" (
  echo Java 17 not found. Downloading local JDK...
  mkdir "%TOOL_ROOT%" 2>nul
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; $url='https://aka.ms/download-jdk/microsoft-jdk-17-windows-x64.zip'; Invoke-WebRequest -Uri $url -OutFile '%JDK_ZIP%'; Expand-Archive -Path '%JDK_ZIP%' -DestinationPath '%TOOL_ROOT%' -Force; Get-ChildItem -Path '%TOOL_ROOT%' | Where-Object { $_.Name -match 'jdk' } | ForEach-Object { Rename-Item -Path $_.FullName -NewName 'jdk-17' }"
)

if not exist "%JAVA_EXE%" (
  echo Failed to install local Java 17.
  pause
  exit /b 1
)

mkdir "%USERPROFILE%\.grave-client" 2>nul
mkdir "%USERPROFILE%\.grave-client\mods" 2>nul
mkdir "%USERPROFILE%\.grave-client\config" 2>nul
mkdir "%USERPROFILE%\.grave-client\assets" 2>nul
mkdir "%USERPROFILE%\.grave-client\logs" 2>nul
mkdir "%BUILD_DIR%" 2>nul

echo Created install folders at %USERPROFILE%\.grave-client

echo Compiling launcher with local JDK...
"%JAVA_EXE%" -version
"%JAVA_DIR%\bin\javac.exe" -d "%BUILD_DIR%" -sourcepath src/main/java src/main/java/com/grave/launcher/*.java
if errorlevel 1 (
  echo Compilation failed.
  pause
  exit /b 1
)

echo.
echo Installer finished successfully.
echo You can now run: run-launcher.bat
pause
