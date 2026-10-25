@echo off
setlocal

where java >nul 2>nul
if errorlevel 1 (
  echo Java 17+ is required but was not found on PATH.
  echo Please install Java 17 or newer and try again.
  pause
  exit /b 1
)

where mvn >nul 2>nul
if errorlevel 1 (
  echo Maven is required but was not found on PATH.
  echo Please install Maven and try again.
  pause
  exit /b 1
)

call mvn -q -DskipTests package
if errorlevel 1 (
  echo Build failed.
  pause
  exit /b 1
)

java -jar target\grave-launcher-1.0.0.jar
if errorlevel 1 (
  echo Launcher failed to start.
  pause
  exit /b 1
)
