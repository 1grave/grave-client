package com.grave.launcher;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Installer {
    private final AppConfig config;

    public Installer(AppConfig config) {
        this.config = config;
    }

    public void install() throws IOException {
        Path installDir = Paths.get(config.getInstallDir());
        Files.createDirectories(installDir);
        Files.createDirectories(installDir.resolve("mods"));
        Files.createDirectories(installDir.resolve("config"));
        Files.createDirectories(installDir.resolve("assets"));
        Files.createDirectories(installDir.resolve("logs"));

        Path versionFile = installDir.resolve("grave-client.version");
        Files.writeString(versionFile, "1.0.0\n");

        Path settingsFile = installDir.resolve("settings.json");
        Files.writeString(settingsFile, "{\n  \"clientName\": \"Grave Client\",\n  \"theme\": \"dark-purple\",\n  \"version\": \"1.0.0\"\n}\n");

        config.setFirstRun(false);
        config.save();
    }
}
