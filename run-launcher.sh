#!/usr/bin/env bash
set -e

TOOL_ROOT="$HOME/.grave-client/tools"
JAVA_DIR="$TOOL_ROOT/jdk-17"
JAVA_EXE="$JAVA_DIR/bin/java"
BUILD_DIR="$HOME/.grave-client/build"

if [ ! -x "$JAVA_EXE" ]; then
  echo "Java 17 is required but was not found."
  echo "Run ./install.sh first."
  exit 1
fi

mkdir -p "$BUILD_DIR"
"$JAVA_DIR/bin/javac" -d "$BUILD_DIR" -sourcepath src/main/java $(find src/main/java -name "*.java")
"$JAVA_EXE" -cp "$BUILD_DIR" com.grave.launcher.LauncherApp
