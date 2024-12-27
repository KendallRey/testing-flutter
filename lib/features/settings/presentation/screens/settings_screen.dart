import 'package:flutter/material.dart';
import 'package:normal_list/app/core/widgets/app_bar.dart';
import 'package:normal_list/app/core/widgets/bottom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Settings'),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}