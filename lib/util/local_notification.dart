import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> initializeNotifications(
    FlutterLocalNotificationsPlugin plugin) async {
  const MacOSInitializationSettings initSettingsMacOS =
      MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  const InitializationSettings initializationSettings =
      InitializationSettings(macOS: initSettingsMacOS);
  await plugin.initialize(initializationSettings);
}

Future<void> displayNotifications(
    FlutterLocalNotificationsPlugin plugin) async {
  await cancelNotifications(plugin);
  const messageId = 1;
  const title = 'Deploy Status Update';
  const body = 'Deploy status is now open';
  const notificationDetails =
      NotificationDetails(macOS: MacOSNotificationDetails());
  plugin.show(messageId, title, body, notificationDetails);
}

Future<void> cancelNotifications(FlutterLocalNotificationsPlugin plugin) async {
  await plugin.cancelAll();
}

Future<void> requestPermissions(FlutterLocalNotificationsPlugin plugin) async {
  await plugin
      .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: false,
        sound: true,
      );
}
