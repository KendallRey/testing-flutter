
import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/core/widgets/app_bar.dart';
import 'package:normal_list/app/core/widgets/bottom_app_bar.dart';
import 'package:normal_list/features/auth/presentation/screens/login_screen.dart';
import 'package:normal_list/features/list/presentation/screens/add_list_item_screen.dart';
import 'package:normal_list/features/list/presentation/screens/list_screen.dart';
import 'package:normal_list/features/settings/presentation/screens/settings_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String settings = '/settings';
  static const String addListItem = '/add-list-item';

  static const String titleHome = 'My List';
  static const String titleLogin = 'Login';
  static const String titleSettings = 'Settings';
  static const String titleAddListItem = 'Add List Item';

  static HashMap<String, int> indexes = HashMap<String, int>.from({
    AppRoutes.home: 0,
    AppRoutes.settings: 1,
  });

  static HashMap<String, String> titles = HashMap<String, String>.from({
    AppRoutes.home: AppRoutes.titleHome,
    AppRoutes.settings: AppRoutes.titleSettings,
    AppRoutes.addListItem: AppRoutes.titleAddListItem,
  });

}

class AppRouter {

  final GoRouter router;

  AppRouter() : router = GoRouter(
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
        pageBuilder: (ctx, state) => AppRouter.customTransitionPage(LoginScreen(), state),
      ),
      ShellRoute(
        builder:(context, state, child) {
          final url = state.uri.toString();
          final String pageTitle = AppRoutes.titles[url] ?? 'App';
          return Scaffold(
            appBar: MyAppBar(title: pageTitle),
            body: AnimatedSwitcher(
              duration: Durations.short1,
              child: child,
            ),
            bottomNavigationBar: MyBottomAppBar(),
            floatingActionButton: url == AppRoutes.home ? FloatingActionButton(
              onPressed: ()=>handleAddItem(context),
              child: Icon(Icons.add),
            ) : null,
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (ctx, state) => AppRouter.customTransitionPage(ListScreen(), state)
          ),
          GoRoute(
            path: AppRoutes.settings,
            pageBuilder: (ctx, state) => AppRouter.customTransitionPage(SettingsScreen(), state),
          )
        ]),
      GoRoute(
        path: AppRoutes.addListItem,
        pageBuilder: (ctx, state) => AppRouter.customTransitionPage(AddListItemScreen(), state),
      )
    ]
  );
  
  static void handleAddItem(BuildContext ctx) {
    if(ctx.mounted){
      ctx.push(AppRoutes.addListItem);
    }
  }

  static CustomTransitionPage customTransitionPage(Widget page, GoRouterState state){
    return CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionDuration: Durations.medium2,
      transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
            // return FadeTransition(opacity: fadeAnimation, child: child);
            return SlideTransition(position: offsetAnimation, child: child);
      }
    );
  }

}