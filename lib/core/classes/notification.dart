import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_application_1/core/ui/screens/splash_screen.dart';
import 'keys.dart';

class FireBaseNotification {
  final firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          handleNotificationClick(response.payload!);
        }
      },
    );

    String? token = await firebaseMessaging.getToken();
    if (kDebugMode) {
      print("++++++++++++++++++++++++++++++++++");
      print(token);
      print("++++++++++++++++++++++++++++++++++");
    }

    await firebaseMessaging.subscribeToTopic("all");

    handleBackgroundNotification();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleForegroundNotification(message);
    });
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }

    Keys.navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    );
  }

  Future<void> handleBackgroundNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  void handleForegroundNotification(RemoteMessage message) async {
    if (message.notification != null) {
      final title = message.notification!.title ?? "No Title";
      final body = message.notification!.body ?? "No Body";
      final imageUrl = message.notification!.android?.imageUrl ??
          message.notification!.apple?.imageUrl;

      AndroidNotificationDetails androidNotificationDetails;

      if (imageUrl != null) {
        final bigPictureStyleInformation = BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(
            await _downloadAndConvertImage(imageUrl),
          ),
          contentTitle: title,
          summaryText: body,
        );

        androidNotificationDetails = AndroidNotificationDetails(
          'image_channel_id',
          'Image Notifications',
          channelDescription: 'Notifications with images',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: bigPictureStyleInformation,
        );
      } else if (message.data.containsKey('progress')) {
        final progress = int.tryParse(message.data['progress'] ?? '0') ?? 0;

        for (int i = progress; i <= 100; i += 10) {
          androidNotificationDetails = AndroidNotificationDetails(
            'progress_channel_id',
            'Progress Notifications',
            channelDescription: 'Notifications with progress updates',
            importance: Importance.max,
            priority: Priority.high,
            showProgress: true,
            maxProgress: 100,  
            progress: i,       
          );

          final notificationDetails =
              NotificationDetails(android: androidNotificationDetails);

          await flutterLocalNotificationsPlugin.show(
            message.hashCode,
            title,
            '$body ($i%)', 
            notificationDetails,
          );

          await Future.delayed(const Duration(milliseconds: 500)); 
        }
        return;
      } else if (body.length > 100) {
        final bigTextStyleInformation = BigTextStyleInformation(
          body,
          contentTitle: title,
          summaryText: 'Expanded notification',
        );

        androidNotificationDetails = AndroidNotificationDetails(
          'big_text_channel_id',
          'Big Text Notifications',
          channelDescription: 'Notifications with long text',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: bigTextStyleInformation,
        );
      } else {
        androidNotificationDetails = const AndroidNotificationDetails(
          'default_channel_id',
          'Default Notifications',
          channelDescription: 'Simple notifications',
          importance: Importance.max,
          priority: Priority.high,
        );
      }

      final notificationDetails = NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.show(
        message.hashCode,
        title,
        body,
        notificationDetails,
        payload: jsonEncode(message.data), 
      );
    }
  }

  Future<String> _downloadAndConvertImage(String imageUrl) async {
    try {
      final response = await NetworkAssetBundle(Uri.parse(imageUrl)).load("");
      final bytes = response.buffer.asUint8List();
      return base64Encode(bytes);
    } catch (e) {
      debugPrint("Failed to download image: $e");
      return "";
    }
  }

  void handleNotificationClick(String payload) {
    Keys.navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    );
  }
}
