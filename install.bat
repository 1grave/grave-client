@echo off
setlocal enabledelayedexpansion

set TOOL_ROOT=%USERPROFILE%\.grave-client\tools
set JAVA_DIR=%TOOL_ROOT%\jdk-17
set JAVA_EXE=%JAVA_DIR%\bin\java.exe
set BUILD_DIR=%USERPROFILE%\.grave-client\build
set SOURCE_FILES=

if not exist "%JAVA_EXE%" (
  echo Java 17 not found. Downloading local JDK...
  mkdir "%TOOL_ROOT%" 2>nul
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; $url='https://aka.ms/download-jdk/microsoft-jdk-17-windows-x64.zip'; $zip='%TEMP%\grave-jdk17.zip'; Invoke-WebRequest -Uri $url -OutFile $zip; $dest='%TOOL_ROOT%'; Expand-Archive -Path $zip -DestinationPath $dest -Force; Get-ChildItem -Path $dest | Where-Object { $_.Name -match 'jdk' } | ForEach-Object { Rename-Item -Path $_.FullName -NewName 'jdk-17' }"
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

for /r src\main\java %%f in (*.java) do (
  set SOURCE_FILES=!SOURCE_FILES! "%%f"
)

echo Compiling launcher with local JDK...
"%JAVA_DIR%\bin\javac.exe" -d "%BUILD_DIR%" %SOURCE_FILES%
if errorlevel 1 (
  echo Compilation failed.
  pause
  exit /b 1
)

echo.
echo Installer finished successfully.
echo You can now run: run-launcher.bat
pause
