import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantera/screens/LoginScreen2.dart';
import 'package:plantera/screens/chosescreen.dart';

// ignore: camel_case_types
class auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChoseScreen();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
