# Grave Client

A dark, purple-themed Minecraft launcher and installer concept built to match the look and feel of a premium client UI.

## Run it

### Windows

1. Install and compile Java locally with:

```bat
install.bat
```

2. Launch the app:

```bat
run-launcher.bat
```

### macOS / Linux

```bash
chmod +x install.sh run-launcher.sh
./install.sh
./run-launcher.sh
```

## Notes

This project no longer requires Maven.
It uses a local Java 17 installation downloaded into:

- `%USERPROFILE%\.grave-client\tools\jdk-17`
- `$HOME/.grave-client/tools/jdk-17`

Then it compiles the launcher directly with `javac` and runs it with `java`.
This keeps the project portable and removes the Maven dependency entirely.
