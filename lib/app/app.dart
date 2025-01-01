
import 'package:flutter/material.dart';
import 'package:normal_list/app/router.dart';

class MyApp extends StatelessWidget {

  const MyApp({ super.key });


  final Color darkActionColor = Colors.deepOrange;
  final Color darkShadeColor = Colors.black38;
  final Color darkFocusedColor = Colors.yellow;
  final Color darkGenericColor = Colors.black;
  final Color darkDisabledColor = Colors.blueGrey;
  final Color darkErrorColor = Colors.red;
  final Color darkErrorFocusColor = Colors.redAccent;

  final Color lightActionColor = Colors.blue;
  final Color lightShadeColor = Colors.white38;
  final Color lightFocusedColor = Colors.cyan;
  final Color lightGenericColor = Colors.white;
  final Color lightDisabledColor = Colors.blueGrey;
  final Color lightErrorColor = Colors.red;
  final Color lightErrorFocusColor = Colors.redAccent;

  WidgetStateProperty<Color?> stateColorBackgroundDarkMode(){
    return WidgetStateProperty.resolveWith((state) {
      if(state.contains(WidgetState.disabled)){
        return darkDisabledColor;
      }
      return darkActionColor;
    });
  }

  WidgetStateProperty<Color?> stateColorBackgroundLightMode(){
    return WidgetStateProperty.resolveWith((state) {
      if(state.contains(WidgetState.disabled)){
        return lightDisabledColor;
      }
      return lightActionColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig:  AppRouter().router,
      theme: ThemeData.light().copyWith(
        primaryColor:  lightActionColor,
        primaryColorDark: lightShadeColor,
        appBarTheme: AppBarTheme(
          backgroundColor: lightActionColor,
          foregroundColor: lightGenericColor,
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: stateColorBackgroundLightMode(),
            )
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: lightActionColor,
            unselectedItemColor: darkGenericColor,
            backgroundColor: lightActionColor
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.all(lightActionColor),
          fillColor: WidgetStateProperty.all(Colors.transparent),
          side: BorderSide(color: lightActionColor, width: 2),
        ),
        unselectedWidgetColor: lightActionColor,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: lightActionColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: stateColorBackgroundLightMode(),
            foregroundColor: WidgetStateProperty.all(lightGenericColor),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: lightActionColor,
          foregroundColor: lightGenericColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: lightActionColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: lightFocusedColor),
            ),
            focusColor: darkFocusedColor,
            labelStyle: TextStyle(color: lightActionColor),
            floatingLabelStyle: TextStyle(
                color: lightActionColor
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: lightErrorColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: lightErrorFocusColor),
            )
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
          labelLarge: TextStyle(color: lightGenericColor),
          labelMedium: TextStyle(color: lightGenericColor),
          labelSmall: TextStyle(color: lightGenericColor),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: darkActionColor,
        primaryColorDark: darkShadeColor,
        appBarTheme: AppBarTheme(
          backgroundColor: darkActionColor,
          foregroundColor: lightGenericColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: stateColorBackgroundDarkMode(),
          )
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: darkActionColor,
          unselectedItemColor: lightGenericColor,
          backgroundColor: darkActionColor
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.all(darkActionColor),
          fillColor: WidgetStateProperty.all(Colors.transparent),
          side: BorderSide(color: darkActionColor, width: 2),
        ),
        unselectedWidgetColor: darkActionColor,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: darkActionColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: stateColorBackgroundDarkMode(),
            foregroundColor: WidgetStateProperty.all(lightGenericColor),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: darkActionColor,
          foregroundColor: lightGenericColor,
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
      // themeMode: ThemeMode.dark,
    );
  }

}