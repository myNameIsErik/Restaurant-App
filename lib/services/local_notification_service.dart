import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LocalNotificationService {
  bool _isRequestingPermission = false;
  final ApiServices _apiServices = ApiServices(); // Tambahkan API Services

  Future<void> init() async {
    await configureLocalTimeZone();
    const initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );
    const initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<bool?> requestPermissions() async {
    if (_isRequestingPermission) return null; // Cegah multiple request
    _isRequestingPermission = true;

    bool? permissionGranted;

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iOSImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >();
      permissionGranted = await iOSImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final notificationEnabled = await _isAndroidPermissionGranted();
      permissionGranted =
          notificationEnabled
              ? true
              : await _requestAndroidNotificationsPermission();
    } else {
      permissionGranted = false;
    }

    _isRequestingPermission = false;
    return permissionGranted;
  }

  Future<bool> _isAndroidPermissionGranted() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.areNotificationsEnabled() ??
        false;
  }

  Future<bool> _requestAndroidNotificationsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission() ??
        false;
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  tz.TZDateTime _nextInstanceOfElevenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      11,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /// Ambil restoran random dari API
  Future<Restaurant?> _fetchRandomRestaurant() async {
    try {
      final restaurantResponse = await _apiServices.getRestaurantList();
      final List<Restaurant> restaurants = restaurantResponse.restaurants;

      if (restaurants.isNotEmpty) {
        final randomIndex = Random().nextInt(restaurants.length);
        return restaurants[randomIndex];
      }
    } catch (e) {
      developer.log("Error fetching restaurant: $e");
    }
    return null;
  }

  /// Jadwalkan Notifikasi dengan Rekomendasi Restoran
  Future<void> scheduleDailyElevenAMNotification({
    required int id,
    String channelId = "1",
    String channelName = "Schedule Notification",
  }) async {
    final restaurant = await _fetchRandomRestaurant();
    String title = "WAKTUNYA MAKAN SIANG!!";
    String body = "Jangan lupakan makan siangmu!";

    if (restaurant != null) {
      title = "Coba makan di ${restaurant.name}!";
      body =
          "Tempat yang bagus untuk makan siangmu, dengan berbagai menu yang lezat!";
    }

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      sound: const RawResourceAndroidNotificationSound('notification'),
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: 'slow_spring_board.aiff',
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final datetimeSchedule = _nextInstanceOfElevenAM();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      datetimeSchedule,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
