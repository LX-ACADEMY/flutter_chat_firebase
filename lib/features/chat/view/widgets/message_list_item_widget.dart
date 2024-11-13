import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageListItemWidget extends StatelessWidget {
  final bool isSentMessage;
  final MessageModel message;

  const MessageListItemWidget({
    super.key,
    required this.isSentMessage,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.6,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSentMessage ? Colors.green[200] : Colors.green[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.message),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat.jm().format(message.createdAt),
                style: const TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
