import 'package:chat_app/features/chat/view/widgets/user_list_item_widget.dart';
import 'package:flutter/material.dart';

class UsersListPage extends StatelessWidget {
  static const routePath = '/chat/users';

  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const UserListItemWidget();
        },
      ),
    );
  }
}
