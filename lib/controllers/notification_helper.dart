import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationHelper() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('walking_logo');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: null);
  }

  Future<void> showNotification() async {
    var android = AndroidNotificationDetails(
      '00',
      'Safe Circle',
      'Safe Circle alerts you when you leave your travel radius',
      priority: Priority.High,
      importance: Importance.Max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alert'),
    );
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Safe Circle',
      'You are outside of your travel limit!',
      platform,
    );
  }

  Future<void> clearNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
