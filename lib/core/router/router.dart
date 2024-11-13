import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/auth/services/auth_services.dart';
import 'package:chat_app/features/auth/view/pages/login_page.dart';
import 'package:chat_app/features/auth/view/pages/signup_page.dart';
import 'package:chat_app/features/chat/view/pages/chat_room_page.dart';
import 'package:chat_app/features/chat/view/pages/users_list_page.dart';
import 'package:chat_app/main.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: LoginPage.routePath,
  navigatorKey: App.navigatorKey,
  routes: [
    GoRoute(
      path: UsersListPage.routePath,
      builder: (context, state) => const UsersListPage(),
    ),
    GoRoute(
      path: ChatRoomPage.routePath,
      builder: (context, state) => ChatRoomPage(
        user: state.extra as UserModel,
      ),
    ),
    GoRoute(
      path: LoginPage.routePath,
      builder: (context, state) => const LoginPage(),
      redirect: (context, state) {
        final user = AuthServices.getCurrentUserSync();

        if (user != null) {
          return UsersListPage.routePath;
        }

        return null;
      },
    ),
    GoRoute(
      path: SignupPage.routePath,
      builder: (context, state) => const SignupPage(),
    ),
  ],
);
