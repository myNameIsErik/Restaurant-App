import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/notification/notification_provider.dart';
import 'package:restaurant_app/provider/style/theme/theme_provider.dart';

class SettingDrawer extends StatefulWidget {
  const SettingDrawer({super.key});

  @override
  State<SettingDrawer> createState() => _SettingDrawerState();
}

class _SettingDrawerState extends State<SettingDrawer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Settings",
            style: theme.textTheme.titleLarge,
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Restaurant Notification",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              "Enable Notification",
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
          ListTile(
            title: Text(
              "Theme Mode",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              "Choose App Theme",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            trailing: DropdownButton<ThemeMode>(
              value: Provider.of<ThemeProvider>(context).themeMode,
              onChanged: (mode) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setThemeMode(mode!);
              },
              items: [
                DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(
                      "Light",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(
                      "Dark",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text(
                      "System",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
