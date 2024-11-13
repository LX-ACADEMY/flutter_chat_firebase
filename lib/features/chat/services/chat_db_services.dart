import 'package:chat_app/features/auth/services/auth_services.dart';
import 'package:chat_app/features/chat/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDbServices {
  static final messagesCollection =
      FirebaseFirestore.instance.collection('messages').withConverter(
            fromFirestore: (snapshot, options) =>
                MessageModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  static Future<void> sendMessage(MessageModel message) async {
    await messagesCollection.doc(message.id).set(message);
  }

  static Stream<List<MessageModel>> getMessagesStream(String receiverId) {
    final currentUser = AuthServices.getCurrentUserSync();
    final messageStream = messagesCollection
        .where(
          'senderId',
          whereIn: [currentUser!.uid, receiverId],
        )
        .where(
          'receiverId',
          whereIn: [currentUser.uid, receiverId],
        )
        .orderBy('createdAt')
        .snapshots();

    final messagesListStream = messageStream
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    return messagesListStream;
  }
}
