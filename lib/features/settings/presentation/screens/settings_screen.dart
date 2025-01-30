import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/core/widgets/button.dart';
import 'package:normal_list/app/router.dart';
import 'package:normal_list/features/auth/data/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void handleLogout(BuildContext ctx) async {
    AuthService().signOut();
    await Future.delayed(Durations.medium1);
    if (ctx.mounted) {
      ctx.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Text(''),
            ),
            Center(
                child: AppButton(
              label: 'Logout',
              onPressed: () => handleLogout(context),
            ))
          ],
        ));
  }
}
