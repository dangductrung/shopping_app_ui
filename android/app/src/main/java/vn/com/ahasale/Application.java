package vn.com.ahasale;

import io.flutter.app.FlutterApplication;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;

public class Application extends FlutterApplication implements PluginRegistrantCallback {
    @Override
    public void onCreate() {
        super.onCreate();
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }

    private String key = "io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin";

    @Override
    public void registerWith(PluginRegistry registry) {
        register(registry);
    }

    private void register(PluginRegistry registry) {
        if (alreadyRegisteredWith(registry)) {
            return;
        }
        FirebaseMessagingPlugin.registerWith(registry.registrarFor(key));
    }

    private boolean alreadyRegisteredWith(PluginRegistry registry) {
        if (registry.hasPlugin(key)) {
            return true;
        }
        return false;
    }
}