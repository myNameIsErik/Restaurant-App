import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class DetailRobot {
  final WidgetTester tester;
  DetailRobot(this.tester);

  Future<void> verifyDetailScreen() async {
    expect(find.byKey(const Key('detail_screen')), findsOneWidget);
    expect(find.byKey(const Key('body_detail')), findsOneWidget);
  }
}
