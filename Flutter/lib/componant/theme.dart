import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Color c1 = Color.fromARGB(255, 70, 102, 75);

class ThemeService {
  final lighttheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFF38a73c),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: TextStyle(color: Colors.black),
          side: BorderSide(
            color: Color(0xFF38a73c),
          ),
        ),
      ),
      iconTheme: IconThemeData(color: Color(0xFF477340)),
      unselectedWidgetColor: Color.fromARGB(255, 70, 209, 75),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Color(0xFF38a73c)),
      )),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF477340)),
      dividerColor: Colors.black);

  final darktheme = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: const Color.fromARGB(255, 70, 102, 75)),
      iconTheme: IconThemeData(color: Color(0xFF477340)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: TextStyle(color: Colors.white),
          // backgroundColor: Colors.white,
          side: BorderSide(color: Color.fromARGB(255, 70, 102, 75)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Color.fromARGB(255, 70, 102, 75)),
      )),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF477340)),
      dividerColor: Colors.white54);

  final _getstorage = GetStorage();
  final _darkthemekey = 'isDarkTheme';

  void savethemedata(bool isdarkmode) {
    _getstorage.write(_darkthemekey, isdarkmode);
  }

  bool issavedarkmode() {
    return _getstorage.read(_darkthemekey) ?? false;
  }

  ThemeMode getthememode() {
    return issavedarkmode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changetheme() {
    Get.changeThemeMode(issavedarkmode() ? ThemeMode.light : ThemeMode.dark);
    savethemedata(!issavedarkmode());
  }
}
