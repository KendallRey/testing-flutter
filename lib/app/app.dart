
import 'package:flutter/material.dart';
import 'package:normal_list/app/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //     appBar: AppBar(
  //       title: Text('My List'),
  //     ),
  //     bottomNavigationBar: BottomAppBar(
  //       shape: CircularNotchedRectangle(),
  //       notchMargin: 6,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           IconButton(
  //             icon: Icon(Icons.home),
  //             onPressed: () {},
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.settings),
  //             onPressed: () {},
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  // );
  // }
}