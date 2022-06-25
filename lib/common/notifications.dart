import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createPrayerTimeNotification(
    int id, int hour, int minute, String title, String body) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'scheduled_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: NotificationCalendar(
      repeats: true,
      hour: hour,
      minute: minute,
      second: 0,
      millisecond: 0,
    ),
  );
}

Future<void> cancelPrayerTimeNotification(int id) async {
  await AwesomeNotifications().cancelSchedule(id);
}
