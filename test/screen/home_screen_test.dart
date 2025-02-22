import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_rating_provider.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';

import '../mock_api_service.mocks.dart';

defaultStub() {
  return RestaurantListResponse(
    error: false,
    message: "success",
    count: 0,
    restaurants: [],
  );
}

void main() {
  late MockApiServices mockApiServices;

  setUp(() {
    mockApiServices = MockApiServices();
    when(
      mockApiServices.getRestaurantList(),
    ).thenAnswer((_) async => defaultStub());
  });

  Widget createTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) => RestaurantListProvider(mockApiServices),
        ),
        ChangeNotifierProvider<RestaurantRatingProvider>(
          create: (_) => RestaurantRatingProvider(mockApiServices),
        ),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('HomeScreen Widget Tests', () {
    testWidgets('Menampilkan AppBar dengan judul yang benar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(const HomeScreen()));

      expect(find.text('CariIn Restaurant'), findsOneWidget);
    });

    testWidgets('Menampilkan tombol pencarian', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const HomeScreen()));

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('Menampilkan ikon pencarian di dalam tombol', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(const HomeScreen()));

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('Menampilkan SingleChildScrollView', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(const HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('Menampilkan daftar restoran dalam ListView.builder', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(const HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsWidgets);
    });
  });
}
