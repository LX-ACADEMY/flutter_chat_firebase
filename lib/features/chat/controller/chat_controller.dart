import 'package:chat_app/core/utils/snackbar_utils.dart';
import 'package:chat_app/features/auth/services/auth_services.dart';
import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:chat_app/features/chat/services/chat_db_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  void build() {}

  Future<void> sendMessage({
    required String message,
    required String receiverId,
  }) async {
    if (message.isEmpty) {
      SnackBarUtils.showMessage('Message cannot be empty');
      return;
    }

    try {
      final currentUser = AuthServices.getCurrentUserSync();

      final messageDetails = MessageModel(
          id: const Uuid().v4(),
          message: message,
          senderId: currentUser!.uid,
          receiverId: receiverId,
          createdAt: DateTime.now(),
          isRecieved: false,
          isRead: false);

      await ChatDbServices.sendMessage(messageDetails);
    } catch (e) {
      SnackBarUtils.showMessage('Cannot send message');
    }
  }
}
