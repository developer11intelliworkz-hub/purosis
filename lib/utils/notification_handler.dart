import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// 🔥 INIT
  static Future<void> init() async {
    await _initLocalNotifications();
    await _requestPermission();
    await _setupFCM();
  }

  /// 🔔 Request Permission (iOS + Android 13+)
  static Future<void> _requestPermission() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);
  }

  /// 📲 Setup FCM listeners
  static Future<void> _setupFCM() async {
    String? token = await _messaging.getToken();
    print("FCM TOKEN: $token");

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground message");

      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });

    // Background click
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("👉 Notification clicked (background)");
      _handleMessage(message);
    });

    // Terminated
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();

    if (initialMessage != null) {
      print("🚀 Opened from terminated");
      _handleMessage(initialMessage);
    }
  }

  /// 🔔 Local Notification (Foreground UI)
  static Future<void> _initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(settings: settings);
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      id: 0,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: details,
    );
  }

  /// 🎯 Handle click navigation
  static void _handleMessage(RemoteMessage message) {
    final data = message.data;

    if (data['type'] == 'chat') {
      print("Open Chat Screen");
    } else if (data['type'] == 'order') {
      print("Open Order Screen");
    }
  }
}
