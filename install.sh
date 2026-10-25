#!/usr/bin/env bash
set -e

if ! command -v java >/dev/null 2>&1; then
  echo "Java 17+ is required but was not found on PATH."
  echo "Attempting to install OpenJDK 17 via apt..."
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y openjdk-17-jdk
  elif command -v brew >/dev/null 2>&1; then
    brew install openjdk@17
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y java-17-openjdk
  else
    echo "Could not find a supported package manager to install Java 17."
    echo "Please install Java 17 manually, then rerun this installer."
    exit 1
  fi
fi

if ! command -v mvn >/dev/null 2>&1; then
  echo "Maven was not found. Attempting to install Maven via apt..."
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y maven
  elif command -v brew >/dev/null 2>&1; then
    brew install maven
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y maven
  else
    echo "Could not find a supported package manager to install Maven."
    echo "Please install Maven manually, then rerun this installer."
    exit 1
  fi
fi

mkdir -p "$HOME/.grave-client" "$HOME/.grave-client/mods" "$HOME/.grave-client/config" "$HOME/.grave-client/assets" "$HOME/.grave-client/logs"

echo "Created install folders at $HOME/.grave-client"
echo "Building launcher..."
mvn -q -DskipTests package

echo

echo "Installer finished successfully."
echo "You can now run: ./run-launcher.sh"
