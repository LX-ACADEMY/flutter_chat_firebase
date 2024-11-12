import 'package:chat_app/core/utils/snackbar_utils.dart';
import 'package:chat_app/features/auth/services/auth_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  void build() {}

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    /// Use regex to validate email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }

    if (password != confirmPassword) {
      return 'Password and confirm password must be the same';
    }

    return null;
  }

  Future<void> signup(String email, String password) async {
    try {
      await AuthServices.signup(email, password);

      SnackBarUtils.showMessage('Signup success');
    } catch (e) {
      SnackBarUtils.showMessage(e.toString());
    }
  }
}
