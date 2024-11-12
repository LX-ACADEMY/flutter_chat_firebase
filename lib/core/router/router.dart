import 'package:chat_app/features/chat/view/pages/users_list_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: UsersListPage.routePath,
  routes: [
    GoRoute(
      path: UsersListPage.routePath,
      builder: (context, state) => const UsersListPage(),
    ),
  ],
);
