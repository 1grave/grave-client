package com.grave.launcher;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Properties;

public class AppConfig {
    private static final String CONFIG_FILE = "grave-client.properties";
    private static final String DEFAULT_INSTALL_DIR = System.getProperty("user.home") + "/.grave-client";

    private String installDir = DEFAULT_INSTALL_DIR;
    private String gameDir = Paths.get(System.getProperty("user.home"), ".minecraft").toString();
    private String javaExecutable = "java";
    private String clientExecutable = "";
    private String clientJar = "";
    private String[] launchArgs = new String[0];
    private boolean firstRun = true;

    public static AppConfig load() {
        AppConfig config = new AppConfig();
        Path configPath = Paths.get(System.getProperty("user.home"), ".grave-client", CONFIG_FILE);

        if (!Files.exists(configPath)) {
            return config;
        }

        Properties props = new Properties();
        try {
            props.load(Files.newInputStream(configPath));
            config.installDir = props.getProperty("installDir", config.installDir);
            config.gameDir = props.getProperty("gameDir", config.gameDir);
            config.javaExecutable = props.getProperty("javaExecutable", config.javaExecutable);
            config.clientExecutable = props.getProperty("clientExecutable", config.clientExecutable);
            config.clientJar = props.getProperty("clientJar", config.clientJar);
            config.firstRun = Boolean.parseBoolean(props.getProperty("firstRun", "true"));

            String rawArgs = props.getProperty("launchArgs", "");
            if (!rawArgs.isBlank()) {
                config.launchArgs = rawArgs.split("\\s+");
            }
        } catch (IOException e) {
            System.err.println("Unable to load config: " + e.getMessage());
        }

        return config;
    }

    public void save() {
        Path configDir = Paths.get(System.getProperty("user.home"), ".grave-client");
        try {
            Files.createDirectories(configDir);
            Path configPath = configDir.resolve(CONFIG_FILE);
            Properties props = new Properties();
            props.setProperty("installDir", installDir);
            props.setProperty("gameDir", gameDir);
            props.setProperty("javaExecutable", javaExecutable);
            props.setProperty("clientExecutable", clientExecutable);
            props.setProperty("clientJar", clientJar);
            props.setProperty("firstRun", String.valueOf(firstRun));
            props.setProperty("launchArgs", String.join(" ", launchArgs));
            props.store(Files.newOutputStream(configPath), "Grave Client Launcher");
        } catch (IOException e) {
            throw new IllegalStateException("Unable to save configuration", e);
        }
    }

    public String getInstallDir() {
        return installDir;
    }

    public void setInstallDir(String installDir) {
        this.installDir = installDir;
    }

    public String getGameDir() {
        return gameDir;
    }

    public void setGameDir(String gameDir) {
        this.gameDir = gameDir;
    }

    public String getJavaExecutable() {
        return javaExecutable;
    }

    public void setJavaExecutable(String javaExecutable) {
        this.javaExecutable = javaExecutable;
    }

    public String getClientExecutable() {
        return clientExecutable;
    }

    public String getClientJar() {
        return clientJar;
    }

    public void setClientJar(String clientJar) {
        this.clientJar = clientJar;
    }

    public String[] getLaunchArgs() {
        return launchArgs;
    }

    public void setLaunchArgs(String[] launchArgs) {
        this.launchArgs = launchArgs == null ? new String[0] : launchArgs;
    }

    public boolean isFirstRun() {
        return firstRun;
    }

    public void setFirstRun(boolean firstRun) {
        this.firstRun = firstRun;
    }
}
