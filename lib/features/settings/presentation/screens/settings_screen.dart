import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/core/widgets/app_bar.dart';
import 'package:normal_list/app/core/widgets/bottom_app_bar.dart';
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
    if(!ctx.mounted) return;
    ctx.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(),
          onPressed: () {
            handleLogout(context);
          },
          child: Text('Logout')
        ),
    );
  }
}