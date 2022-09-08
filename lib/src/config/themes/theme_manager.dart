import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_todo_app/src/core/resources/font_manager.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Colors.teal,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: true,
    ),
    backgroundColor: Colors.white,
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 25.0,
      fontWeight: FontWeightManager.medium,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    toolbarTextStyle: TextStyle(
      color: Colors.black,
    ),
    titleSpacing: 20.0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    unselectedItemColor: Colors.black,
  ),
  bottomAppBarTheme: BottomAppBarTheme(color: Colors.black, elevation: 0),
  bottomAppBarColor: Colors.black,
  errorColor: Colors.red,
  disabledColor: Colors.grey,
  hintColor: Colors.black,
  iconTheme: const IconThemeData(color: Colors.black, size: 30.0),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.teal,
    unselectedLabelColor: Colors.black,
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeightManager.regular,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Colors.teal,
          fontSize: 16.0,
          fontWeight: FontWeightManager.regular,
        ),
      ),
    ),
  ),
  textTheme: const TextTheme(
    caption: TextStyle(color: Colors.black),
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeightManager.regular,
    ),
    headline3: TextStyle(
      color: Colors.black,
      fontWeight: FontWeightManager.bold,
    ),
    headline4: TextStyle(
      color: Colors.black,
      fontWeight: FontWeightManager.bold,
    ),
    headline5: TextStyle(
      color: Colors.black,
      fontWeight: FontWeightManager.regular,
    ),
    headline6: TextStyle(
      color: Colors.black,
      fontWeight: FontWeightManager.bold,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Colors.teal,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
      systemStatusBarContrastEnforced: true,
    ),
    backgroundColor: Colors.black,
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25.0,
      fontWeight: FontWeightManager.medium,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    toolbarTextStyle: TextStyle(
      color: Colors.white,
    ),
    titleSpacing: 20.0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    unselectedItemColor: Colors.white,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white, elevation: 0),
  bottomAppBarColor: Colors.white,
  errorColor: Colors.red,
  disabledColor: Colors.grey,
  hintColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.white, size: 30.0),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.teal,
    unselectedLabelColor: Colors.white,
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeightManager.regular,
    ),
  ),
  scaffoldBackgroundColor: Colors.black,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Colors.teal,
          fontSize: 16.0,
          fontWeight: FontWeightManager.regular,
        ),
      ),
    ),
  ),
  dialogTheme: DialogTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    backgroundColor: Colors.black,
    contentTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeightManager.regular,
      fontSize: 16.0,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeightManager.bold,
      fontSize: 20.0,
    ),
  ),
  textTheme: const TextTheme(
    caption: TextStyle(color: Colors.white),
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeightManager.regular,
    ),
    headline3: TextStyle(
      color: Colors.white,
      fontWeight: FontWeightManager.bold,
    ),
    headline4: TextStyle(
      color: Colors.white,
      fontWeight: FontWeightManager.bold,
    ),
    headline5: TextStyle(
      color: Colors.white,
      fontWeight: FontWeightManager.regular,
    ),
    headline6: TextStyle(
      color: Colors.white,
    ),
  ),
);
