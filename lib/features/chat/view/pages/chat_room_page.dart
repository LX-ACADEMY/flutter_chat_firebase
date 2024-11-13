import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/controller/chat_controller.dart';
import 'package:chat_app/features/chat/view/widgets/chat_room_bottom_bar_widget.dart';
import 'package:chat_app/features/chat/view/widgets/message_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatRoomPage extends HookConsumerWidget {
  static const routePath = '/chat/room';

  final UserModel user;

  const ChatRoomPage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Controller used for the message list view
    final messagesScrollController = useScrollController();

    /// Scroll to the end of the list when page loads
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (messagesScrollController.hasClients) {
          messagesScrollController
              .jumpTo(messagesScrollController.position.maxScrollExtent);
        }
      });

      return null;
    }, []);

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
              child: StreamBuilder(
                  stream: ref
                      .read(chatControllerProvider.notifier)
                      .getMessagesStream(user.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.separated(
                      controller: messagesScrollController,
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final EdgeInsets padding;

                        if (index == 0) {
                          padding = const EdgeInsets.only(
                            top: 16,
                          );
                        } else if (index == snapshot.data!.length - 1) {
                          padding = const EdgeInsets.only(bottom: 16);
                        } else {
                          padding = EdgeInsets.zero;
                        }

                        final message = snapshot.data![index];
                        final isSentSentMessage = message.receiverId == user.id;

                        return Padding(
                          padding: padding,
                          child: MessageListItemWidget(
                            isSentMessage: isSentSentMessage,
                            message: message,
                          ),
                        );
                      },
                    );
                  }),
            ),
          ),
          ChatRoomBottomBarWidget(
            user: user,
          ),
        ],
      ),
    );
  }
}
