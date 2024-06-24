import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(double dailySpent, double dailyGoal) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'daily_spending_channel', // Channel ID
      'Daily Spending', // Channel Name
      channelDescription: 'Notification for daily spending and goals', // Channel Description
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      ongoing: true, // Make the notification ongoing
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    double progress = dailySpent / dailyGoal;
    String progressText = '${(progress * 100).toStringAsFixed(2)}%';

    await flutterLocalNotificationsPlugin.show(
      0,
      'Daily Spending',
      'Spent: ₹${dailySpent.toStringAsFixed(2)}, Goal: ₹${dailyGoal.toStringAsFixed(2)}',
      platformChannelSpecifics,
      payload: progressText,
    );
  }

  Future<void> updateNotification(double dailySpent, double dailyGoal) async {
    await showNotification(dailySpent, dailyGoal);
  }
}
