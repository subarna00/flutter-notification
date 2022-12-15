import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();
  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  Future<void> initlize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@drawable/android");

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _localNotificationService.initialize(settings,
        onSelectNotification: onSelectNotification);
  }

  Future<NotificationDetails> _notificaitonDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channelId", "channelName",
            channelDescription: "description",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    return const NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final details = await _notificaitonDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificaitonDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  Future<void> showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required int seconds,
  }) async {
    final details = await _notificaitonDetails();
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
          DateTime.now().add(Duration(seconds: seconds)), tz.local),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print("id ${id}");
  }

  void onSelectNotification(String? payload) {
    print("payload ${payload}");
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }
}
