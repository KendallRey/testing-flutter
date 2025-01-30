import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/router.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({super.key});

  void handleNavigate(BuildContext ctx, int index) {
    if (ctx.mounted) {
      switch (index) {
        case 0:
          ctx.go(AppRoutes.home);
          break;
        case 1:
          ctx.go(AppRoutes.settings);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouter.of(context).state!.uri.toString();
    final int currentIndex = AppRoutes.indexes[location] ?? 0;

    return BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: (index) {
          handleNavigate(context, index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ]);
  }
}
