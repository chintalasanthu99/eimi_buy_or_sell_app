import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // static final NotificationService _instance = NotificationService._internal();
  // factory NotificationService() => _instance;
  // NotificationService._internal();
  //
  // final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  // static Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //   _instance._showLocalNotification(message);
  // }
  //
  // Future<void> initialize() async {
  //   // Initialize local notifications
  //   const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  //   const initializationSettings = InitializationSettings(android: androidSettings);
  //   await _localNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse: (NotificationResponse response) {
  //       final payload = response.payload;
  //       debugPrint('Notification tapped with payload: $payload');
  //       // TODO: handle tap logic
  //     },
  //   );
  //
  //
  //   // Create channel (Android 8+)
  //   const androidChannel = AndroidNotificationChannel(
  //     'basic_channel', // id
  //     'Basic Notifications', // title
  //     description: 'Channel for basic notifications',
  //     importance: Importance.high,
  //   );
  //   await _localNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(androidChannel);
  //
  //   // Firebase messaging permissions (esp. for iOS)
  //   await FirebaseMessaging.instance.requestPermission();
  //
  //   // Foreground message listener
  //   FirebaseMessaging.onMessage.listen((message) {
  //     debugPrint('📦 Data: $message');
  //     _showLocalNotification(message);
  //   });
  //
  //   // Tap on notification from terminated state
  //   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  //   if (initialMessage != null) {
  //     _handleNotificationTap(initialMessage.data);
  //   }
  //
  //   // Tap on notification from background
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //     debugPrint('📦 Data: $message');
  //     _handleNotificationTap(message.data);
  //   });
  // }
  //
  // void _showLocalNotification(RemoteMessage message) async {
  //   final notification = message.notification;
  //   final data = message.data;
  //   debugPrint('📩 Received Firebase message:');
  //   debugPrint('🔔 Notification: ${notification?.title} - ${notification?.body}');
  //   debugPrint('📦 Data: $data');
  //
  //
  //   if (notification == null) {
  //     debugPrint('⚠️ No notification payload found. Skipping display.');
  //     return;
  //   }
  //   const androidDetails = AndroidNotificationDetails(
  //     'basic_channel',
  //     'Basic Notifications',
  //     channelDescription: 'Channel for basic notifications',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //   );
  //
  //   const platformDetails = NotificationDetails(android: androidDetails);
  //
  //   await _localNotificationsPlugin.show(
  //     Random().nextInt(100000),
  //     notification.title ?? 'Notification',
  //     notification.body ?? '',
  //     platformDetails,
  //     payload: data.toString(), // You can use jsonEncode(data) if complex
  //   );
  // }
  //
  // void _handleNotificationTap(Map<String, dynamic> payload) {
  //   debugPrint('Tapped notification payload: $payload');
  //   // TODO: Add navigation or custom logic based on payload
  // }

  // Future<String?> getFirebaseToken() async {
  //   return await FirebaseMessaging.instance.getToken();
  // }
}
