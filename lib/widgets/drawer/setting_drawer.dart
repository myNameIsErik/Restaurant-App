import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/style/theme/theme_provider.dart';

class SettingDrawer extends StatelessWidget {
  const SettingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            title: const Text("Theme Mode"),
            subtitle: const Text("Choose App Theme"),
            trailing: DropdownButton<ThemeMode>(
              value: Provider.of<ThemeProvider>(context).themeMode,
              onChanged: (mode) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setThemeMode(mode!);
              },
              items: const [
                DropdownMenuItem(value: ThemeMode.light, child: Text("Light")),
                DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark")),
                DropdownMenuItem(
                    value: ThemeMode.system, child: Text("System")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
