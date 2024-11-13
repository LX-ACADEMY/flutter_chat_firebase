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
}
