import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:chat_app/features/chat/view/widgets/user_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersListPage extends ConsumerWidget {
  static const routePath = '/chat/users';

  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const UserListItemWidget();
        },
      ),
    );
  }
}
