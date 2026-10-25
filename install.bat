@echo off
setlocal

REM Install Java 17 if missing
where java >nul 2>nul
if errorlevel 1 (
  echo Java 17+ was not found. Attempting to install Java 17 via winget...
  winget install --id Microsoft.OpenJDK.17 -e -s winget
  if errorlevel 1 (
    echo Failed to install Java with winget.
    echo Please install Java 17 manually, then rerun this installer.
    pause
    exit /b 1
  )
)

REM Install Maven if missing
where mvn >nul 2>nul
if errorlevel 1 (
  echo Maven was not found. Attempting to install Maven via winget...
  winget install --id Apache.Maven -e -s winget
  if errorlevel 1 (
    echo Failed to install Maven with winget.
    echo Trying alternative via choco...
    choco install maven -y
    if errorlevel 1 (
      echo Failed to install Maven automatically.
      echo Please install Maven manually from https://maven.apache.org/install.html
      echo Then rerun this installer.
      pause
      exit /b 1
    )
  )
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
