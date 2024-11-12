import 'package:chat_app/features/chat/view/pages/chat_room_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class UserListItemWidget extends StatelessWidget {
  const UserListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// Callback to execute when the user tap on the list item.
    void onListItemTap() {
      context.push(ChatRoomPage.routePath);
    }

    return ListTile(
      onTap: onListItemTap,
      title: const Text('User Name'),
      subtitle: const Text('Last Message'),
      leading: const CircleAvatar(
        child: Text('U'),
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
