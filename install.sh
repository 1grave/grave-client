#!/usr/bin/env bash
set -euo pipefail

ensure_java() {
  if command -v java >/dev/null 2>&1; then
    if java -version 2>&1 | grep -Eq 'version "1[7-9]|version "[2-9][0-9]'; then
      return 0
    fi
  fi

  echo "Java 17+ was not found. Attempting to install it..."

  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y openjdk-17-jdk
  elif command -v brew >/dev/null 2>&1; then
    brew install openjdk@17
    export PATH="/opt/homebrew/opt/openjdk@17/bin:/usr/local/opt/openjdk@17/bin:$PATH"
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y java-17-openjdk
  else
    echo "Could not find a supported package manager to install Java 17+ automatically."
    echo "Please install Java 17 or newer manually, then rerun this installer."
    exit 1
  fi

  if ! command -v java >/dev/null 2>&1; then
    echo "Java is still not available after installation. Please restart your terminal and rerun this installer."
    exit 1
  fi

  if ! java -version 2>&1 | grep -Eq 'version "1[7-9]|version "[2-9][0-9]'; then
    echo "Java 17+ was installed, but the version is too old or not on PATH."
    echo "Please verify the Java installation and rerun this installer."
    exit 1
  fi
}

ensure_maven() {
  if command -v mvn >/dev/null 2>&1; then
    return 0
  fi

  echo "Maven was not found. Attempting to install it..."

  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y maven
  elif command -v brew >/dev/null 2>&1; then
    brew install maven
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y maven
  else
    echo "Could not find a supported package manager to install Maven automatically."
    echo "Please install Maven manually, then rerun this installer."
    exit 1
  fi

  if ! command -v mvn >/dev/null 2>&1; then
    echo "Maven is still not available after installation. Please restart your terminal and rerun this installer."
    exit 1
  fi
}

ensure_java
ensure_maven

mkdir -p "$HOME/.grave-client" "$HOME/.grave-client/mods" "$HOME/.grave-client/config" "$HOME/.grave-client/assets" "$HOME/.grave-client/logs"

echo "Created install folders at $HOME/.grave-client"

echo "Building launcher..."
mvn -q -DskipTests package

if [ ! -f "target/grave-launcher-1.0.0.jar" ]; then
  echo "Build completed, but the jar was not created at target/grave-launcher-1.0.0.jar"
  exit 1
fi

echo

echo "Installer finished successfully."
echo "You can now run: ./run-launcher.sh"
