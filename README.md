# Grave Client

A dark, purple-themed Minecraft launcher and installer concept built to match the look and feel of a premium client UI.

## What this project includes

- A first-run installer wizard
- A polished launcher UI in a dark purple aesthetic
- Basic configuration management for local install paths
- A launch action that starts a configured game or client jar
- Cross-platform launch scripts

## Project layout

- `src/main/java/com/grave/launcher/...` — launcher and installer code
- `run-launcher.sh` / `run-launcher.bat` — simple launcher entry points
- `pom.xml` — Maven build configuration

## Run it

### macOS / Linux

```bash
chmod +x run-launcher.sh
./run-launcher.sh
```

### Windows

```powershell
run-launcher.bat
```

## Notes

This project is a launcher scaffold for a custom client experience. It is designed to be extended with a custom client jar, Fabric mod, or a custom Minecraft launch workflow.

It does not ship a full Minecraft client by itself. The launcher is ready to point at your installed Minecraft or custom client executable.
