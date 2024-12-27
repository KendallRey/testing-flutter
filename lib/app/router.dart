
import 'package:go_router/go_router.dart';
import 'package:normal_list/features/list/presentation/screens/list_screen.dart';
import 'package:normal_list/features/settings/presentation/screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (ctx, state) => ListScreen()
    ),
    GoRoute(
      path: '/settings',
      builder: (ctx, state) => SettingsScreen()
    )
  ]
);