import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_app/core/utils/snackbar_utils.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/auth/services/auth_db_services.dart';
import 'package:chat_app/features/auth/services/auth_services.dart';
import 'package:chat_app/features/auth/view/pages/login_page.dart';
import 'package:chat_app/features/chat/view/pages/users_list_page.dart';
import 'package:chat_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  void build() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        App.navigatorKey.currentContext!.go(LoginPage.routePath);
      } else {
        App.navigatorKey.currentContext!.go(UsersListPage.routePath);
      }
    });
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    return null;
  }

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

  Future<void> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await AuthServices.signup(
        email: email,
        password: password,
        name: name,
      );

      final userDetails = AuthServices.getCurrentUserSync();
      final user = UserModel(
        id: userDetails!.uid,
        name: name,
        email: email,
      );

      await AuthDbServices.createUser(user);

      SnackBarUtils.showMessage('Signup success');
    } catch (e) {
      SnackBarUtils.showMessage(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await AuthServices.logout();

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'auth_channel',
          title: 'Logout',
          body: 'You have been logged out',
        ),
      );
    } catch (e) {
      SnackBarUtils.showMessage(e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await AuthServices.login(email, password);

      SnackBarUtils.showMessage('Login success');
    } catch (e) {
      SnackBarUtils.showMessage(e.toString());
    }
  }

  Stream<List<UserModel>> getUserStream() {
    return AuthDbServices.getUserStream();
  }

  User? getCurrentUser() {
    try {
      return AuthServices.getCurrentUserSync();
    } catch (e) {
      SnackBarUtils.showMessage('Canot get current user');
    }

    return null;
  }
}
