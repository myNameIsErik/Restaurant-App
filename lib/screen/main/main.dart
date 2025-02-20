import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/widgets/drawer/setting_drawer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('main_screen'),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomeScreen(),
            _ => const FavoriteScreen(),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Theme.of(context).colorScheme.primary,
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (index) {
          if (index == 2) {
            // menampilkan drawer dari bawah saat Settings dipilih
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                final theme = Theme.of(context);
                return Theme(
                  data: theme,
                  child: const SettingDrawer(),
                );
              },
            );
          } else {
            context.read<IndexNavProvider>().setIndextBottomNavBar = index;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Favorit",
            tooltip: "Favorit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Pengaturan",
            tooltip: "Pengaturan",
          ),
        ],
      ),
    );
  }
}
