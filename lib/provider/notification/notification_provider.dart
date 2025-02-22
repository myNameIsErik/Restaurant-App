import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:restaurant_app/services/local_notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  NotificationProvider(this.flutterNotificationService) {
    _loadNotificationPreference();
    requestPermissions(); // Panggil otomatis saat provider diinisialisasi
  }

  final int _notificationId = 1;
  bool _isNotificationEnabled = false;
  bool get isNotificationEnabled => _isNotificationEnabled;

  bool? _permission = false;
  bool? get permission => _permission;

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  Future<void> _loadNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isNotificationEnabled = prefs.getBool('notification_enabled') ?? false;
    notifyListeners();
  }

  Future<void> setNotificationEnabled(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_enabled', isEnabled);

    _isNotificationEnabled = isEnabled;
    notifyListeners();

    if (isEnabled) {
      if (_permission == true) {
        await flutterNotificationService.scheduleDailyElevenAMNotification(
          id: _notificationId,
        );
      } else {
        await requestPermissions(); // Minta izin jika belum diberikan
        if (_permission == true) {
          await flutterNotificationService.scheduleDailyElevenAMNotification(
            id: _notificationId,
          );
        }
      }
    } else {
      await flutterNotificationService.cancelNotification(_notificationId);
    }
  }
}
