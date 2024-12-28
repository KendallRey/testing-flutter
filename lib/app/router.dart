
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/features/auth/presentation/screens/login_screen.dart';
import 'package:normal_list/features/list/presentation/screens/list_screen.dart';
import 'package:normal_list/features/settings/presentation/screens/settings_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String settings = '/settings';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  redirect: (ctx, state) {
    final isAuthenticated = FirebaseAuth.instance.currentUser != null;
    final isLoggingIn = state.uri.toString() == AppRoutes.login;
    if(!isAuthenticated && !isLoggingIn){
      return AppRoutes.login;
    }
    if(isAuthenticated && isLoggingIn){
      return AppRoutes.home;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (ctx, state) => LoginScreen()
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (ctx, state) => ListScreen()
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (ctx, state) => SettingsScreen()
    )
  ]
);