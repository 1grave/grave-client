@echo off
setlocal

where java >nul 2>nul
if errorlevel 1 (
  echo Java 17+ is required but was not found on PATH.
  echo Please install Java 17 or newer and try again.
  exit /b 1
)

java -version 2>nul | findstr /R /C:"version \"1[7-9]" /C:"version \"[2-9][0-9]" >nul
if errorlevel 1 (
  echo Java 17+ is required, but a different version was detected.
  exit /b 1
)

where mvn >nul 2>nul
if errorlevel 1 (
  echo Maven is required but was not found on PATH.
  echo Please install Maven and try again.
  exit /b 1
)

if not exist "target\grave-launcher-1.0.0.jar" (
  echo Launcher jar not found. Building it now...
  call mvn -q -DskipTests package
  if errorlevel 1 (
    echo Build failed.
    exit /b 1
  )
)

if not exist "target\grave-launcher-1.0.0.jar" (
  echo Build failed: target\grave-launcher-1.0.0.jar was not created.
  exit /b 1
)

java -jar target\grave-launcher-1.0.0.jar
