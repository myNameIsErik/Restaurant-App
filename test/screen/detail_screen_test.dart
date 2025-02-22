import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_provider.dart';
import 'package:restaurant_app/screen/detail/body_of_detail_screen_widget.dart';
import 'package:restaurant_app/screen/detail/menu_list.dart';
import 'package:restaurant_app/widgets/card/review/add_review_form.dart';
import 'package:restaurant_app/widgets/card/review/review_list.dart';
import 'package:restaurant_app/screen/detail/favorite_icon_widget.dart';

import '../mock_api_service.mocks.dart';

void main() {
  late MockApiServices mockApiServices;
  late Restaurant testRestaurant;
  late FavoriteProvider favoriteProvider;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    HttpOverrides.global = null;
  });

  setUp(() {
    mockApiServices = MockApiServices();
    testRestaurant = Restaurant(
      id: "rqdv5juczeskfw1e867",
      name: "Melting Pot",
      description: "A great place to eat",
      pictureId: "14",
      city: "Medan",
      address: "Jln. Pandeglang no 19",
      rating: 4.2,
      categories: [],
      menus: Menus(drinks: [], foods: []),
      customerReviews: [],
    );

    final response = RestaurantDetailResponse(
      error: false,
      message: "Success",
      restaurant: testRestaurant,
    );

    when(
      mockApiServices.getRestaurantDetail(any),
    ).thenAnswer((_) async => response);

    favoriteProvider = FavoriteProvider();
  });

  Widget createTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create:
              (_) =>
                  RestaurantDetailProvider(mockApiServices)
                    ..fetchRestaurantDetail("1"),
        ),
        ChangeNotifierProvider<FavoriteProvider>(
          create: (_) => favoriteProvider,
        ),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('Detail Screen Widget Tests', () {
    testWidgets('Menampilkan widget pada halaman body detail', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestableWidget(
          BodyOfDetailScreenWidget(restaurant: testRestaurant),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(BodyOfDetailScreenWidget), findsOneWidget);
      expect(find.byType(Hero), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(FavoriteIconWidget), findsOneWidget);
      expect(find.byType(MenuList), findsOneWidget);
      expect(find.byType(ReviewList), findsOneWidget);
      expect(find.byType(AddReviewForm), findsOneWidget);
    });

    testWidgets('Image.network dimuat dengan benar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestableWidget(
          BodyOfDetailScreenWidget(restaurant: testRestaurant),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);
      final image = tester.widget<Image>(find.byType(Image));
      expect(
        (image.image as NetworkImage).url,
        "https://restaurant-api.dicoding.dev/images/large/${testRestaurant.pictureId}",
      );
    });
  });
}
