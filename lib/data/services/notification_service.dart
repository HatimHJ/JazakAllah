import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;


class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //Initialize local notification service
  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  //Set up notification details
  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }


  //Sending instant one click notification
  Future sendNotification(String title, String body) async{
    await _flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        await notificationDetails()
    );
  }

  //Sending periodic schedule notification
  Future scheduleNotification(
      {int id = 6969,
        String? title,
        String? body,
        String? payLoad,
        required DateTime scheduledNotificationDateTime}) async {
    return _flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.everyMinute,
        notificationDetails()
    );
  }


  //Stop periodic notification
  void stopNotifications(int id) async{
    _flutterLocalNotificationsPlugin.cancel(id);
  }


  Future zonedScheduleNotification({
    int id = 333,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledNotificationDateTime,
  }) async {
    // Timezone settings - replace 'America/New_York' with your desired timezone
    const String timeZoneName = 'America/New_York';
    final tz.TZDateTime scheduledTime =
    tz.TZDateTime.from(scheduledNotificationDateTime, tz.getLocation(timeZoneName));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'Your Channel Name',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails()
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }



  Future zonedScheduleNotificationFajr({
    int id = 1,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledNotificationDateTime,
  }) async {
    // Timezone settings - replace 'America/New_York' with your desired timezone
    const String timeZoneName = 'America/New_York';
    final tz.TZDateTime scheduledTime =
    tz.TZDateTime.from(scheduledNotificationDateTime, tz.getLocation(timeZoneName));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'Your Channel Name',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails()
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future zonedScheduleNotificationDhuhr({
    int id = 2,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledNotificationDateTime,
  }) async {
    // Timezone settings - replace 'America/New_York' with your desired timezone
    const String timeZoneName = 'America/New_York';
    final tz.TZDateTime scheduledTime =
    tz.TZDateTime.from(scheduledNotificationDateTime, tz.getLocation(timeZoneName));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'Your Channel Name',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails()
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future zonedScheduleNotificationAsr({
    int id = 3,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledNotificationDateTime,
  }) async {
    // Timezone settings - replace 'America/New_York' with your desired timezone
    const String timeZoneName = 'America/New_York';
    final tz.TZDateTime scheduledTime =
    tz.TZDateTime.from(scheduledNotificationDateTime, tz.getLocation(timeZoneName));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'Your Channel Name',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails()
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future zonedScheduleNotificationMaghrib({
    int id = 4,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledNotificationDateTime,
  }) async {
    // Timezone settings - replace 'America/New_York' with your desired timezone
    const String timeZoneName = 'America/New_York';
    final tz.TZDateTime scheduledTime =
    tz.TZDateTime.from(scheduledNotificationDateTime, tz.getLocation(timeZoneName));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'Your Channel Name',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails()
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future zonedScheduleNotificationIsha({
    int id = 5,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledNotificationDateTime,
  }) async {
    // Timezone settings - replace 'America/New_York' with your desired timezone
    const String timeZoneName = 'America/New_York';
    final tz.TZDateTime scheduledTime =
    tz.TZDateTime.from(scheduledNotificationDateTime, tz.getLocation(timeZoneName));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'Your Channel Name',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails()
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }
}