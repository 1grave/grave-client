package com.grave.launcher;

import javax.swing.SwingUtilities;

public final class LauncherApp {
    private LauncherApp() {
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            AppConfig config = AppConfig.load();
            LauncherFrame frame = new LauncherFrame(config);
            frame.setVisible(true);
        });
    }
}
