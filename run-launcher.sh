#!/usr/bin/env bash
set -euo pipefail

if ! command -v java >/dev/null 2>&1; then
  echo "Java 17+ is required but was not found on PATH."
  echo "Please install Java 17 or newer and then rerun this launcher."
  exit 1
fi

if ! java -version 2>&1 | grep -Eq 'version "1[7-9]|version "[2-9][0-9]'; then
  echo "Java 17+ is required, but a different version was detected."
  exit 1
fi

if ! command -v mvn >/dev/null 2>&1; then
  echo "Maven is required but was not found on PATH."
  echo "Please install Maven and then rerun this launcher."
  exit 1
fi

if [ ! -f "target/grave-launcher-1.0.0.jar" ]; then
  echo "Launcher jar not found. Building it now..."
  mvn -q -DskipTests package
fi

if [ ! -f "target/grave-launcher-1.0.0.jar" ]; then
  echo "Build failed: target/grave-launcher-1.0.0.jar was not created."
  exit 1
fi

java -jar target/grave-launcher-1.0.0.jar
