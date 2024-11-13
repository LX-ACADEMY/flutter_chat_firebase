import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatRoomBottomBarWidget extends HookConsumerWidget {
  final UserModel user;

  const ChatRoomBottomBarWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageController = useTextEditingController();

    Future<void> onSendPressed() async {
      await ref.read(chatControllerProvider.notifier).sendMessage(
            message: messageController.text,
            receiverId: user.id,
          );

      messageController.clear();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: 'Message',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: onSendPressed,
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.green),
            ),
            padding: const EdgeInsets.all(16),
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
