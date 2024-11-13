import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/view/widgets/chat_room_bottom_bar_widget.dart';
import 'package:chat_app/features/chat/view/widgets/message_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChatRoomPage extends HookWidget {
  static const routePath = '/chat/room';

  final UserModel user;

  const ChatRoomPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    /// Controller used for the message list view
    final messagesScrollController = useScrollController();

    /// Scroll to the end of the list when page loads
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        messagesScrollController
            .jumpTo(messagesScrollController.position.maxScrollExtent);
      });

      return null;
    }, []);

    const totalMessages = 100;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Text(user.name[0].toUpperCase()),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name),
                const Text(
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
                controller: messagesScrollController,
                itemCount: totalMessages,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final EdgeInsets padding;

                  if (index == 0) {
                    padding = const EdgeInsets.only(
                      top: 16,
                    );
                  } else if (index == totalMessages - 1) {
                    padding = const EdgeInsets.only(bottom: 16);
                  } else {
                    padding = EdgeInsets.zero;
                  }

                  return Padding(
                    padding: padding,
                    child: MessageListItemWidget(
                      isSentMessage: index % 2 == 0,
                      message: 'Message',
                    ),
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
