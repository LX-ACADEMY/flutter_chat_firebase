import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/view/pages/chat_room_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class UserListItemWidget extends StatelessWidget {
  final UserModel user;

  const UserListItemWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    /// Callback to execute when the user tap on the list item.
    void onListItemTap() {
      context.push(ChatRoomPage.routePath, extra: user);
    }

    return ListTile(
      onTap: onListItemTap,
      title: Text(user.name),
      subtitle: const Text('Last Message'),
      leading: CircleAvatar(
        child: Text(user.name[0].toUpperCase()),
      ),
      trailing: const Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            radius: 14,
            child: Text('2'),
          ),
          SizedBox(height: 4),
          Text('12:00'),
        ],
      ),
    );
  }
}
