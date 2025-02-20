import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeRobot {
  final WidgetTester tester;
  HomeRobot(this.tester);

  Future<void> verifyHomeScreen() async {
    expect(find.byKey(const Key('main_screen')), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsWidgets);
  }

  Future<void> tapFirstRestaurant() async {
    final Finder restaurantItem = find.byKey(const Key('restaurant_0'));
    expect(restaurantItem, findsOneWidget);
    await tester.tap(restaurantItem);
    await tester.pumpAndSettle();
  }
}
