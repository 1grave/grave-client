#!/usr/bin/env bash
set -e

if ! command -v java >/dev/null 2>&1; then
  echo "Java 17+ is required but was not found on PATH."
  echo "Please install Java 17 or newer and try again."
  exit 1
fi

if ! command -v mvn >/dev/null 2>&1; then
  echo "Maven is required but was not found on PATH."
  echo "Please install Maven and try again."
  exit 1
fi

mvn -q -DskipTests package
java -jar target/grave-launcher-1.0.0.jar
