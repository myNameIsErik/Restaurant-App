import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail/favorite_list_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_rating_provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/provider/notification/notification_provider.dart';
import 'package:restaurant_app/provider/review/add_review_provider.dart';
import 'package:restaurant_app/provider/search/search_provider.dart';
import 'package:restaurant_app/provider/style/theme/theme_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/main/main.dart';
import 'package:restaurant_app/screen/search/search_screen.dart';
import 'package:restaurant_app/services/favorite_service.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/app_theme.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Executing Workmanager task: $task");

    try {
      // Pastikan Flutter Binding sudah terhubung ke sistem
      WidgetsFlutterBinding.ensureInitialized();

      // Inisialisasi ulang Notification Service
      final notificationService = LocalNotificationService();
      await notificationService.init(); // 🔥 Panggil init agar tidak late init

      // Jadwalkan notifikasi
      await notificationService.scheduleDailyElevenAMNotification(id: 1);

      print("Notification scheduled successfully!");
      return Future.value(true);
    } catch (e) {
      print("Error in Workmanager task: $e");
      return Future.value(false);
    }
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().cancelAll(); // Hapus semua task sebelum mendaftarkan ulang

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  Workmanager().registerPeriodicTask(
    "uniqueTaskId",
    "dailyReminderTask",
    frequency: const Duration(hours: 24),
  );

  print("Task successfully registered!");

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => FavoriteService(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteListProvider(),
        ),
        Provider(
          create: (context) => ApiServices(),
        ),
        Provider(create: (context) => LocalNotificationService()..init()),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermissions(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantRatingProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AddReviewProvider(
            context.read<ApiServices>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppThemes theme = AppThemes();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.searchRoute.name: (context) => SearchScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
