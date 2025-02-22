import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/provider/notification/notification_provider.dart';
import 'package:restaurant_app/provider/style/theme/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "CariIn Restaurant",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pengaturan", style: theme.textTheme.titleLarge),
            const SizedBox(height: 10),
            const Divider(),
            ListTile(
              title: Text(
                "Notifikasi",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: Text(
                "Izinkan Notifikasi",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              trailing: Switch(
                // value: false,
                value: notificationProvider.isNotificationEnabled,
                onChanged: (bool value) {
                  notificationProvider.setNotificationEnabled(value);
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: Text("Tema", style: Theme.of(context).textTheme.bodyLarge),
              subtitle: Text(
                "Pilih Tema Aplikasi",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              trailing: DropdownButton<ThemeMode>(
                value: Provider.of<ThemeProvider>(context).themeMode,
                onChanged: (mode) {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).setThemeMode(mode!);
                },
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(
                      "Terang",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(
                      "Gelap",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text(
                      "Sistem",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
