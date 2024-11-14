import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_app/core/router/router.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'auth_channel',
        channelName: 'Authentication Notifications',
        channelDescription: 'Authentication related notifications',
        groupKey: 'auth_group',
      ),
      NotificationChannel(
        channelKey: 'chat_channel',
        channelName: 'Chat Notifications',
        channelDescription: 'Chat related notifications',
        groupKey: 'chat_group',
      ),
      NotificationChannel(
        channelKey: 'auth_channel_silent',
        channelName: 'Authentication Notifications',
        channelDescription: 'Authentication related notifications',
        groupKey: 'auth_group',
        playSound: false,
      ),
      NotificationChannel(
        channelKey: 'chat_channel_silent',
        channelName: 'Chat Notifications',
        channelDescription: 'Chat related notifications',
        groupKey: 'chat_group',
        playSound: false,
      ),
      NotificationChannel(
        channelKey: 'sample',
        channelName: 'Sample',
        channelDescription: 'Sample Channel',
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'auth_group',
        channelGroupName: 'Authentication Notifications',
      ),
      NotificationChannelGroup(
        channelGroupKey: 'chat_group',
        channelGroupName: 'Chat Notifications',
      )
    ],
  );

  runApp(const ProviderScope(child: App()));
}

class App extends HookWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    /// Request for notification permission if not already allowed
    useEffect(() {
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });

      return null;
    }, []);

    return MaterialApp.router(
      routerConfig: router,
      scaffoldMessengerKey: App.scaffoldMessengerKey,
      title: 'Chat App',
    );
  }
}
