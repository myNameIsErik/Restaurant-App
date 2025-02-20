import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/main.dart';
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
import 'package:restaurant_app/services/favorite_service.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'robot/detail_robot.dart';
import 'robot/home_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Navigasi dari HomeScreen ke DetailScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          Provider(
            create: (context) => FavoriteService(),
          ),
          ChangeNotifierProvider(
            create: (context) => FavoriteProvider(),
          ),
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

    await tester.pumpAndSettle();

    // Inisialisasi robot
    final homeRobot = HomeRobot(tester);
    final detailRobot = DetailRobot(tester);

    // 1. Verifikasi halaman home tampil
    await homeRobot.verifyHomeScreen();

    // 2. Pilih restoran pertama dari daftar
    await homeRobot.tapFirstRestaurant();

    // 3. Verifikasi halaman detail tampil
    await detailRobot.verifyDetailScreen();
  });
}
