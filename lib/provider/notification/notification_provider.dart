import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'package:restaurant_app/services/local_notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  NotificationProvider(this.flutterNotificationService);

  final int _notificationId = 1;
  bool _isNotificationEnabled = false;
  bool get isNotificationEnabled => _isNotificationEnabled;

  bool? _permission = false;
  bool? get permission => _permission;

  Future<void> initNotificationState() async {
    await _loadNotificationPreference();
    if (_isNotificationEnabled) {
      await _setupWorkManager(); // <-- WorkManager aktif jika notifikasi dinyalakan
    }
  }

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
        await _setupWorkManager();
      } else {
        await requestPermissions();
        if (_permission == true) {
          await flutterNotificationService.scheduleDailyElevenAMNotification(
            id: _notificationId,
          );
          await _setupWorkManager();
        }
      }
    } else {
      await flutterNotificationService.cancelNotification(_notificationId);
      await Workmanager().cancelByUniqueName(
        "dailyReminderTask",
      ); // <-- Matikan WorkManager
    }
  }

  /// **Inisialisasi WorkManager saat notifikasi diaktifkan**
  Future<void> _setupWorkManager() async {
    Workmanager().initialize(_workManagerCallback, isInDebugMode: false);
    Workmanager().registerPeriodicTask(
      "dailyReminderTask",
      "dailyReminderTask",
      frequency: const Duration(hours: 24),
      existingWorkPolicy: ExistingWorkPolicy.replace,
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
    );
    log("WorkManager task registered!");
  }
}

/// **WorkManager Callback**
@pragma('vm:entry-point')
void _workManagerCallback() {
  Workmanager().executeTask((task, inputData) async {
    log("Executing Workmanager task: $task");

    try {
      final notificationService = LocalNotificationService();
      await notificationService.init();

      if (task == "dailyReminderTask") {
        await notificationService.scheduleDailyElevenAMNotification(id: 1);
      }

      log("Notification scheduled successfully!");
      return Future.value(true);
    } catch (e) {
      log("Error in Workmanager task: $e");
      return Future.value(false);
    }
  });
}
