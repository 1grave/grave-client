# Grave Client

A dark, purple-themed Minecraft launcher and client project built around a Lunar-style layout and Fabric-based UI/HUD approach.

## What is in this repo

- Java launcher shell for Minecraft detection and launch
- dark purple launcher interface
- local JDK bootstrapping without Maven
- Fabric client starter project under `fabric-client/`
- custom HUD groundwork for a premium client look

## Launcher

- `install.bat` / `install.sh` downloads a local Java 17 if needed
- `run-launcher.bat` / `run-launcher.sh` compiles and launches the launcher
- the launcher auto-detects the Minecraft folder and launcher executable when present

## Fabric client

The folder `fabric-client/` contains the start of a Fabric client mod:
- custom HUD rendering
- client entrypoint
- Fabric config
- dark purple themed overlay

### Run the Fabric client

```bash
cd fabric-client
./gradlew build
```

Then install the generated jar into your Minecraft instance's `mods` directory.

## Important note

This is still a foundation, not a full commercial client like Lunar. It is a playable starter architecture for a custom dark purple Minecraft client, with the launcher and Fabric client layers separated cleanly.
