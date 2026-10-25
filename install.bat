@echo off
setlocal

where java >nul 2>nul
if errorlevel 1 (
  echo Java 17+ is required but was not found on PATH.
  echo Please install Java 17 or newer, then reopen this installer.
  pause
  exit /b 1
)

where mvn >nul 2>nul
if errorlevel 1 (
  echo Maven is required but was not found on PATH.
  echo Please install Maven, then reopen this installer.
  pause
  exit /b 1
)

mkdir "%USERPROFILE%\.grave-client" 2>nul
mkdir "%USERPROFILE%\.grave-client\mods" 2>nul
mkdir "%USERPROFILE%\.grave-client\config" 2>nul
mkdir "%USERPROFILE%\.grave-client\assets" 2>nul
mkdir "%USERPROFILE%\.grave-client\logs" 2>nul

echo Created install folders at %USERPROFILE%\.grave-client

echo Building launcher...
call mvn -q -DskipTests package
if errorlevel 1 (
  echo Build failed.
  pause
  exit /b 1
)

echo.
echo Installer finished successfully.
echo You can now run: run-launcher.bat
pause
