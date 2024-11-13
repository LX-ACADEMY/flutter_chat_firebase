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
