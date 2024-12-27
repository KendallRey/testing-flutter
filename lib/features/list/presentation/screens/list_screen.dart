import 'package:flutter/material.dart';
import 'package:normal_list/app/core/widgets/app_bar.dart';
import 'package:normal_list/app/core/widgets/bottom_app_bar.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'My List'),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}