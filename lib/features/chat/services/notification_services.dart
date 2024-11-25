import 'package:chat_app/env.dart';
import 'package:chat_app/features/chat/models/notification_model.dart';
import 'package:dio/dio.dart';

class NotificationServices {
  static final _client = Dio(BaseOptions(baseUrl: Env.notificationApiBaseUrl));

  static Future<void> sendNotification(NotificationModel notification) async {
    final data = notification.toJson();
    final response = await _client.post('', data: data);

    if (response.statusCode != 200) {
      throw Exception('Failed to send notification');
    }
  }
}
