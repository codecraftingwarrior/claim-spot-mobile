import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static const String channelId = '123';

  static final NotificationService _notificationService =
      NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();


  Future<void> init() async {

    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) => {}
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
   // tz.initializeTimeZones();
  }

  Future<void> showNotification(String notificationMessage) async {
    await flutterLocalNotificationsPlugin.show(
        notificationMessage.hashCode,
        'C.I.A - Mobile',
        notificationMessage,
        const NotificationDetails(
            android: AndroidNotificationDetails(channelId, 'C.I.A - Mobile')
        ),
    );
  }

  Future selectNotification(String? payload) async {

  }
}
