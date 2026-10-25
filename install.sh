#!/usr/bin/env bash
set -e

if ! command -v java >/dev/null 2>&1; then
  echo "Java 17+ is required but was not found on PATH."
  echo "Please install Java 17 or newer, then reopen this installer."
  exit 1
fi

if ! command -v mvn >/dev/null 2>&1; then
  echo "Maven is required but was not found on PATH."
  echo "Please install Maven, then reopen this installer."
  exit 1
fi

mkdir -p "$HOME/.grave-client" "$HOME/.grave-client/mods" "$HOME/.grave-client/config" "$HOME/.grave-client/assets" "$HOME/.grave-client/logs"

echo "Created install folders at $HOME/.grave-client"
echo "Building launcher..."
mvn -q -DskipTests package

echo

echo "Installer finished successfully."
echo "You can now run: ./run-launcher.sh"
