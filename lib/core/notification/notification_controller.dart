import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_app/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    final route = receivedAction.payload?['route'];

    if (route != null) {
      App.navigatorKey.currentContext!.go(route);
    }

    // Your code goes here
  }

  static Future<void> processPushNotification(RemoteMessage message) async {
    final payload = message.data;

    final title = payload['title'];
    final body = payload['body'];

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'chat_channel',
        title: title,
        body: body,
      ),
    );
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    processPushNotification(message);
  }
}
