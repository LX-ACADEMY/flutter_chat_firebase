import 'package:chat_app/features/chat/view/widgets/chat_room_bottom_bar_widget.dart';
import 'package:chat_app/features/chat/view/widgets/message_list_item_widget.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  static const routePath = '/chat/room';

  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              child: Text('U'),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User Name'),
                Text(
                  'Last seen',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: ListView.separated(
                itemCount: 100,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return MessageListItemWidget(
                    isSentMessage: index % 2 == 0,
                    message: 'Message',
                  );
                },
              ),
            ),
          ),
          const ChatRoomBottomBarWidget(),
        ],
      ),
    );
  }
}
