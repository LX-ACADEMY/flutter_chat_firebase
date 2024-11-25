import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthDbServices {
  static final userCollection =
      FirebaseFirestore.instance.collection('users').withConverter(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

  static Future<void> createUser(UserModel user) async {
    await userCollection.doc(user.id).set(user);
  }

  static Stream<List<UserModel>> getUserStream() {
    final userStream = userCollection.snapshots();

    final usersListStream = userStream
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    return usersListStream;
  }

  static Future<void> updateDeviceToken({
    required String userId,
    required String deviceToken,
  }) async {
    await userCollection.doc(userId).update({
      'deviceToken': deviceToken,
    });
  }

  static Future<UserModel> getUserById(String userId) async {
    final user = await userCollection.doc(userId).get();
    return user.data()!;
  }
}
