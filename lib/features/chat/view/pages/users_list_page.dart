import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/view/widgets/user_list_item_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UsersListPage extends HookConsumerWidget {
  static const routePath = '/chat/users';

  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      FirebaseMessaging.instance.getToken().then((token) {
        ref.read(authControllerProvider.notifier).updateDeviceToken(token!);
      });

      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        ref.read(authControllerProvider.notifier).updateDeviceToken(fcmToken);
      });
      return null;
    }, []);

    void onLogoutPressed() {
      ref.read(authControllerProvider.notifier).logout();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogoutPressed,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: ref.read(authControllerProvider.notifier).getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final currentUser =
              ref.read(authControllerProvider.notifier).getCurrentUser();

          final allUsers = snapshot.data as List<UserModel>;
          final filteredUsers =
              allUsers.where((user) => user.id != currentUser!.uid).toList();

          return ListView.builder(
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              return UserListItemWidget(
                user: filteredUsers[index],
              );
            },
          );
        },
      ),
    );
  }
}
