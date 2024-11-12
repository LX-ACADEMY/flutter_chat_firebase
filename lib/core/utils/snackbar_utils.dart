import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showMessage(String message) {
    App.scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
