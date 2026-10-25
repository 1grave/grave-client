package com.grave.launcher;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;
import java.awt.Color;
import java.awt.Cursor;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.RenderingHints;
import java.awt.event.ActionEvent;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class LauncherFrame extends JFrame {
    private static final Color BG = new Color(11, 9, 18);
    private static final Color BORDER = new Color(164, 103, 255);
    private static final Color TEXT = new Color(245, 240, 255);
    private static final Color MUTED = new Color(170, 155, 200);

    private final AppConfig config;

    public LauncherFrame(AppConfig config) {
        this.config = config;
        setTitle("Grave Client Launcher");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(1100, 700);
        setLocationRelativeTo(null);
        setResizable(false);
        setLayout(null);
        setUndecorated(true);

        buildUI();
    }

    private void buildUI() {
        JPanel root = new JPanel(null) {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                Graphics2D g2 = (Graphics2D) g.create();
                g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

                g2.setColor(new Color(18, 10, 28));
                g2.fillRect(0, 0, getWidth(), getHeight());

                g2.setColor(new Color(203, 94, 255, 70));
                g2.fillOval(-120, 80, 500, 500);
                g2.fillOval(600, -140, 500, 500);
                g2.setColor(new Color(255, 110, 166, 80));
                g2.fillOval(250, 250, 500, 260);

                g2.setColor(new Color(164, 103, 255, 180));
                g2.fillRoundRect(70, 120, 350, 420, 18, 18);

                g2.dispose();
            }
        };
        root.setBackground(BG);
        root.setBounds(0, 0, getWidth(), getHeight());
        setContentPane(root);

        JLabel title = new JLabel("GRAVE");
        title.setFont(new Font("Monospaced", Font.BOLD, 78));
        title.setForeground(TEXT);
        title.setBounds(90, 90, 450, 90);
        title.setHorizontalAlignment(SwingConstants.LEFT);
        root.add(title);

        JLabel subtitle = new JLabel("CLIENT");
        subtitle.setFont(new Font("Monospaced", Font.BOLD, 20));
        subtitle.setForeground(MUTED);
        subtitle.setBounds(110, 170, 180, 30);
        root.add(subtitle);

        JButton installButton = createButton("INSTALL");
        installButton.setBounds(90, 250, 240, 48);
        installButton.addActionListener(this::runInstallerWizard);
        root.add(installButton);

        JButton launchButton = createButton("LAUNCH");
        launchButton.setBounds(90, 318, 240, 48);
        launchButton.addActionListener(e -> launchClient());
        root.add(launchButton);

        JButton settingsButton = createButton("SETTINGS");
        settingsButton.setBounds(90, 386, 240, 48);
        settingsButton.addActionListener(e -> openSettingsPanel());
        root.add(settingsButton);

        JButton exitButton = createButton("EXIT");
        exitButton.setBounds(90, 454, 240, 48);
        exitButton.addActionListener(e -> System.exit(0));
        root.add(exitButton);

        JPanel panel = new JPanel(null);
        panel.setBackground(new Color(16, 14, 26, 210));
        panel.setBorder(new javax.swing.BorderFactory.createLineBorder(BORDER, 2));
        panel.setBounds(540, 120, 440, 470);
        root.add(panel);

        JLabel avatar = new JLabel("◈");
        avatar.setFont(new Font("Monospaced", Font.BOLD, 180));
        avatar.setForeground(new Color(223, 220, 245));
        avatar.setBounds(150, 60, 150, 180);
        panel.add(avatar);

        JLabel infoHeader = new JLabel("SYSTEM STATUS");
        infoHeader.setFont(new Font("Monospaced", Font.BOLD, 16));
        infoHeader.setForeground(BORDER);
        infoHeader.setBounds(40, 220, 200, 30);
        panel.add(infoHeader);

        JLabel statusText = new JLabel(config.isFirstRun() ? "READY TO INSTALL" : "CONFIGURED");
        statusText.setFont(new Font("Monospaced", Font.BOLD, 22));
        statusText.setForeground(TEXT);
        statusText.setBounds(40, 258, 320, 30);
        panel.add(statusText);

        JLabel installPath = new JLabel("Install: " + config.getInstallDir());
        installPath.setFont(new Font("Monospaced", Font.PLAIN, 12));
        installPath.setForeground(MUTED);
        installPath.setBounds(40, 310, 340, 24);
        panel.add(installPath);

        JLabel gamePath = new JLabel("Game: " + config.getGameDir());
        gamePath.setFont(new Font("Monospaced", Font.PLAIN, 12));
        gamePath.setForeground(MUTED);
        gamePath.setBounds(40, 338, 340, 24);
        panel.add(gamePath);

        JLabel clientPath = new JLabel("Client: " + (config.getClientExecutable().isBlank() ? "not set" : config.getClientExecutable()));
        clientPath.setFont(new Font("Monospaced", Font.PLAIN, 12));
        clientPath.setForeground(MUTED);
        clientPath.setBounds(40, 366, 340, 24);
        panel.add(clientPath);
    }

    private JButton createButton(String text) {
        JButton button = new JButton(text);
        button.setFont(new Font("Monospaced", Font.BOLD, 18));
        button.setForeground(TEXT);
        button.setBackground(new Color(31, 22, 42));
        button.setBorder(new javax.swing.BorderFactory.createLineBorder(BORDER, 2));
        button.setFocusPainted(false);
        button.setCursor(new Cursor(Cursor.HAND_CURSOR));
        button.setOpaque(true);
        button.setContentAreaFilled(true);
        return button;
    }

    private void runInstallerWizard(ActionEvent e) {
        try {
            Installer installer = new Installer(config);
            installer.install();
            JOptionPane.showMessageDialog(this, "Install complete. You can now launch the client.", "Installer", JOptionPane.INFORMATION_MESSAGE);
            config.setFirstRun(false);
            config.save();
            dispose();
            new LauncherFrame(config).setVisible(true);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Installation failed: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void launchClient() {
        try {
            String executable = config.getClientExecutable();
            String jar = config.getClientJar();
            List<String> command = new ArrayList<>();

            if (jar != null && !jar.isBlank() && Files.exists(Path.of(jar))) {
                command.add(config.getJavaExecutable());
                command.add("-jar");
                command.add(jar);
                command.addAll(Arrays.asList(config.getLaunchArgs()));
            } else if (executable != null && !executable.isBlank() && Files.exists(Path.of(executable))) {
                command.add(executable);
            } else {
                String detected = AppConfig.detectMinecraftLauncher();
                if (!detected.isBlank() && Files.exists(Path.of(detected))) {
                    config.setClientExecutable(detected);
                    config.save();
                    command.add(detected);
                } else {
                    JOptionPane.showMessageDialog(this, "No Minecraft launcher was found. Please set the path in Settings.", "Launcher", JOptionPane.WARNING_MESSAGE);
                    return;
                }
            }

            ProcessBuilder pb = new ProcessBuilder(command);
            pb.directory(new FileFromPath(config.getInstallDir()));
            pb.inheritIO();
            Process process = pb.start();
            if (process.isAlive()) {
                System.out.println("Minecraft launcher started successfully.");
            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Launch failed: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void openSettingsPanel() {
        JTextField installField = new JTextField(config.getInstallDir(), 28);
        JTextField gameField = new JTextField(config.getGameDir(), 28);
        JTextField javaField = new JTextField(config.getJavaExecutable(), 28);
        JTextField executableField = new JTextField(config.getClientExecutable(), 28);
        JTextField jarField = new JTextField(config.getClientJar(), 28);

        JPanel panel = new JPanel(new GridBagLayout());
        GridBagConstraints gc = new GridBagConstraints();
        gc.insets = new Insets(5, 5, 5, 5);
        gc.fill = GridBagConstraints.HORIZONTAL;

        gc.gridx = 0; gc.gridy = 0; panel.add(new JLabel("Install Dir:"), gc);
        gc.gridx = 1; panel.add(installField, gc);

        gc.gridx = 0; gc.gridy = 1; panel.add(new JLabel("Game Dir:"), gc);
        gc.gridx = 1; panel.add(gameField, gc);

        gc.gridx = 0; gc.gridy = 2; panel.add(new JLabel("Java:"), gc);
        gc.gridx = 1; panel.add(javaField, gc);

        gc.gridx = 0; gc.gridy = 3; panel.add(new JLabel("Launcher EXE:"), gc);
        gc.gridx = 1; panel.add(executableField, gc);

        gc.gridx = 0; gc.gridy = 4; panel.add(new JLabel("Client Jar:"), gc);
        gc.gridx = 1; panel.add(jarField, gc);

        int result = JOptionPane.showConfirmDialog(this, panel, "Settings", JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
        if (result == JOptionPane.OK_OPTION) {
            config.setInstallDir(installField.getText());
            config.setGameDir(gameField.getText());
            config.setJavaExecutable(javaField.getText());
            config.setClientExecutable(executableField.getText());
            config.setClientJar(jarField.getText());
            config.save();
            JOptionPane.showMessageDialog(this, "Settings saved.");
        }
    }

    private static final class FileFromPath extends java.io.File {
        private FileFromPath(String path) {
            super(path);
        }
    }
}
