
import 'package:flutter/material.dart';
import 'package:normal_list/app/router.dart';

class MyApp extends StatelessWidget {

  const MyApp({ super.key });


  final Color darkActionColor = Colors.deepOrange;
  final Color darkFocusedColor = Colors.yellow;
  final Color darkGenericColor = Colors.black;
  final Color darkErrorColor = Colors.red;
  final Color darkErrorFocusColor = Colors.redAccent;

  final Color lightActionColor = Colors.blue;
  final Color lightFocusedColor = Colors.cyan;
  final Color lightGenericColor = Colors.white;


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig:  AppRouter().router,
      // routerDelegate: AppRouter().router.routerDelegate,
      // routeInformationParser: AppRouter().router.routeInformationParser,
      // routeInformationProvider: AppRouter().router.routeInformationProvider,

      theme: ThemeData.light().copyWith(
        primaryColor:  Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: lightActionColor,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData( color: lightActionColor),
          selectedLabelStyle: TextStyle(color: lightActionColor),
          unselectedLabelStyle: TextStyle(color: lightActionColor),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(color: darkGenericColor),
          displayMedium: TextStyle(color: darkGenericColor),
          displaySmall: TextStyle(color: darkGenericColor),
          headlineLarge: TextStyle(color: darkGenericColor),
          headlineMedium: TextStyle(color: darkGenericColor),
          headlineSmall: TextStyle(color: darkGenericColor),
          titleLarge: TextStyle(color: darkGenericColor),
          titleMedium: TextStyle(color: darkGenericColor),
          titleSmall: TextStyle(color: darkGenericColor),
          bodyLarge: TextStyle(color: darkGenericColor),
          bodyMedium: TextStyle(color: darkGenericColor),
          bodySmall: TextStyle(color: darkGenericColor),
          labelLarge: TextStyle(color: darkGenericColor),
          labelMedium: TextStyle(color: darkGenericColor),
          labelSmall: TextStyle(color: darkGenericColor),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: darkActionColor,
        appBarTheme: AppBarTheme(
          backgroundColor: darkActionColor,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: darkActionColor,
          unselectedItemColor: lightGenericColor,
          // selectedIconTheme: IconThemeData(color: darkActionColor),
          // selectedItemColor: darkActionColor,
          // selectedLabelStyle: TextStyle(color: darkActionColor),
          // showSelectedLabels: true,
          // unselectedLabelStyle: TextStyle(color: darkActionColor),
          backgroundColor: darkActionColor
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.all(darkActionColor),
          fillColor: WidgetStateProperty.all(Colors.transparent),
          // fillColor: WidgetStateProperty.all(darkActionColor),
          side: BorderSide(color: darkActionColor, width: 2),
        ),
        unselectedWidgetColor: darkActionColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(darkActionColor),
            foregroundColor: WidgetStateProperty.all(lightGenericColor),
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkActionColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkFocusedColor),
          ),
          focusColor: darkFocusedColor,
          labelStyle: TextStyle(color: darkActionColor),
          floatingLabelStyle: TextStyle(
            color: darkActionColor
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkErrorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkErrorFocusColor),
          )
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(color: lightGenericColor),
          displayMedium: TextStyle(color: lightGenericColor),
          displaySmall: TextStyle(color: lightGenericColor),
          headlineLarge: TextStyle(color: lightGenericColor),
          headlineMedium: TextStyle(color: lightGenericColor),
          headlineSmall: TextStyle(color: lightGenericColor),
          titleLarge: TextStyle(color: lightGenericColor),
          titleMedium: TextStyle(color: lightGenericColor),
          titleSmall: TextStyle(color: lightGenericColor),
          bodyLarge: TextStyle(color: lightGenericColor),
          bodyMedium: TextStyle(color: lightGenericColor),
          bodySmall: TextStyle(color: lightGenericColor),
          labelLarge: TextStyle(color: lightGenericColor),
          labelMedium: TextStyle(color: lightGenericColor),
          labelSmall: TextStyle(color: lightGenericColor),
        ),
      ),
      // themeMode: ThemeMode.light,
      themeMode: ThemeMode.dark,
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