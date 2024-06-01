import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:rxdart/rxdart.dart';

class NotificationProvider {
  NotificationProvider() {
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  }
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});

    // _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()!
    //     .requestNotificationsPermission();
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('1', 'Product Expiry Reminder'),
        iOS: DarwinNotificationDetails());
  }


  // NotificationDetails notificationDetails() {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     '1', // channelId
  //     'Product Expiry Reminder', // channelName
  //     channelDescription: 'Reminder notifications for product expiry',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails();
  //   return const NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  // }

  // notificationDetails() {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     '1', // channelId
  //     'Product Expiry Reminder', // channelName
  //     channelDescription: 'Reminder notifications for product expiry',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );

  Future<void> scheduleNotification(
      String title, String body, DateTime scheduledDate) async {
    // final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation("Asia/Kolkata"));

    await _flutterLocalNotificationsPlugin.zonedSchedule(//zoned schedule method to schedule a notification
      0,
      title,
      body,
      _nextInstance(scheduledDate),
      await notificationDetails(),
      // androidAllowWhileIdle: true,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    // final tz.TZDateTime scheduledDate =
    //     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
    // // print(scheduledDate);
    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //     0, title, body, scheduledDate, await notificationDetails(),
    //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.wallClockTime);

    // final tz.TZDateTime scheduledDate =
    //     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
    // print(scheduledDate);

    /*>>>>>>>>>>>>>>show notification after 5 seconds<<<<<<<<<<<<<*/
    // await _flutterLocalNotificationsPlugin.zonedSchedule(
    //     0,
    //     title,
    //     body,
    //     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    //     await notificationDetails(),
    //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime);

        // print("scheduled time=${tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5))}");


    /*>>>>>>>>>>>>>Code to immediately show notification<<<<<<<<<<<<*/
    // await _flutterLocalNotificationsPlugin.show(
    //   0,
    //   title,
    //   body,
    //   await notificationDetails(),
    // );
  }

  // Future<void> checkPendingNotificationRequests() async {
  //   final List<PendingNotificationRequest> pendingNotificationRequests =
  //       await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  //   print('${pendingNotificationRequests.length} pending notification ');

  //   for (PendingNotificationRequest pendingNotificationRequest
  //       in pendingNotificationRequests) {
  //     print(pendingNotificationRequest.id.toString() +
  //         " " +
  //         (pendingNotificationRequest.payload ?? ""));
  //   }
  //   print('NOW ' + tz.TZDateTime.now(tz.local).toString());
  // }

  tz.TZDateTime _nextInstance(DateTime scheduledDate) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledNotificationDate =
        tz.TZDateTime.from(scheduledDate, tz.local).subtract(const Duration(days: 5));
        tz.TZDateTime.from(scheduledNotificationDate, tz.local);
    scheduledNotificationDate = tz.TZDateTime(
        tz.local,
        scheduledNotificationDate.year,
        scheduledNotificationDate.month,
        scheduledNotificationDate.day,
        12,
        00);

    if (scheduledNotificationDate.isBefore(now)) {
      scheduledNotificationDate =
          scheduledNotificationDate.add(const Duration(days: 1));
    }
    return scheduledNotificationDate;
  }
}
