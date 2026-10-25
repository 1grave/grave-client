package com.grave;

import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.client.rendering.v1.HudRenderCallback;
import net.minecraft.client.MinecraftClient;
import net.minecraft.client.font.TextRenderer;
import net.minecraft.text.Text;

public class ClientMain implements ClientModInitializer {
    @Override
    public void onInitializeClient() {
        HudRenderCallback.EVENT.register((drawContext, tickDelta) -> {
            MinecraftClient client = MinecraftClient.getInstance();
            TextRenderer renderer = client.textRenderer;

            drawContext.drawText(renderer, Text.literal("GRAVE CLIENT"), 12, 12, 0xFFD1FF, false);
            drawContext.drawText(renderer, Text.literal("fabric 1.20.4"), 12, 28, 0xA78BFA, false);
        });
    }
}
