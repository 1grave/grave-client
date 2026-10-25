#!/usr/bin/env bash
set -e

TOOL_ROOT="$HOME/.grave-client/tools"
JAVA_DIR="$TOOL_ROOT/jdk-17"
JAVA_EXE="$JAVA_DIR/bin/java"
BUILD_DIR="$HOME/.grave-client/build"

if [ ! -x "$JAVA_EXE" ]; then
  echo "Java 17 not found. Downloading local JDK..."
  mkdir -p "$TOOL_ROOT"

  if [ "$(uname -s)" = "Darwin" ]; then
    JDK_URL="https://aka.ms/download-jdk/microsoft-jdk-17-macOS-x64.tar.gz"
  else
    JDK_URL="https://aka.ms/download-jdk/microsoft-jdk-17-linux-x64.tar.gz"
  fi

  curl -L "$JDK_URL" -o "/tmp/grave-jdk17.tar.gz"
  tar -xzf "/tmp/grave-jdk17.tar.gz" -C "$TOOL_ROOT"
  mv "$TOOL_ROOT"/jdk-* "$JAVA_DIR"
fi

if [ ! -x "$JAVA_EXE" ]; then
  echo "Failed to install local Java 17."
  exit 1
fi

mkdir -p "$HOME/.grave-client" "$HOME/.grave-client/mods" "$HOME/.grave-client/config" "$HOME/.grave-client/assets" "$HOME/.grave-client/logs" "$BUILD_DIR"

echo "Created install folders at $HOME/.grave-client"
echo "Compiling launcher with local JDK..."
"$JAVA_EXE" -version
"$JAVA_DIR/bin/javac" -d "$BUILD_DIR" -sourcepath src/main/java $(find src/main/java -name "*.java")

echo

echo "Installer finished successfully."
echo "You can now run: ./run-launcher.sh"
