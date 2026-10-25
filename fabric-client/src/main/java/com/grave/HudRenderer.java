package com.grave;

import net.minecraft.client.MinecraftClient;
import net.minecraft.client.gl.ShaderStage;
import net.minecraft.client.gui.DrawContext;

public final class HudRenderer {
    private HudRenderer() {}

    public static void render(DrawContext context) {
        MinecraftClient client = MinecraftClient.getInstance();
        if (client == null) return;

        context.drawCenteredTextWithShadow(
            client.textRenderer,
            "GRAVE",
            context.getScaledWindowWidth() / 2,
            20,
            0xD9A5FF
        );
    }
}
