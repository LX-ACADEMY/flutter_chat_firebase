import 'package:flutter/material.dart';

class UserListItemWidget extends StatelessWidget {
  const UserListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('User Name'),
      subtitle: Text('Last Message'),
      leading: CircleAvatar(
        child: Text('U'),
      ),
      trailing: Column(
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
