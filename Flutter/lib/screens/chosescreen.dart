// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantera/componant/language_controlar.dart';

class ChoseScreen extends GetView<LanguageController> {
  Color c1 = Color.fromARGB(255, 70, 209, 75);
  Color c3 = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("myfarm".tr),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: SizedBox(
                height: 200,
                width: 380,
                child: InkWell(
                  onTap: (() {
                    Navigator.pushNamed(context, "add");
                  }),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "img/plantera4.png",
                        height: 120.0,
                        width: 120.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: Text(
                          "farms".tr,
                          style: TextStyle(
                            fontSize: 20,
                            // color: c3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: SizedBox(
                height: 200,
                width: 380,
                child: InkWell(
                  onTap: (() {
                    Navigator.pushNamed(context, "detect");
                  }),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "img/plantera4.png",
                        height: 120.0,
                        width: 120.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: Text(
                          "detect".tr,
                          style: TextStyle(
                            fontSize: 20,
                            // color: c3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 94, 94, 95),
                ),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        //backgroundColor: const Color(0xFF778899),
                        backgroundImage: AssetImage(
                          'img/plantera6.png',
                        ), //For Image Asset
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${FirebaseAuth.instance.currentUser?.email}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text('acount'.tr),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Navigator.pushNamed(context, "profile");
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text('setting'.tr),
                    leading: Icon(Icons.settings),
                    onTap: () {
                      Navigator.pushNamed(context, "setting");
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text('help'.tr),
                    leading: Icon(Icons.help_center),
                    onTap: () {
                      Navigator.pushNamed(context, "help");
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text("logout".tr),
                    leading: Icon(Icons.logout),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamed(context, "login");
                    },
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15.0),
              //     ),
              //     child: ListTile(
              //       title: Text("test".tr),
              //       leading: Icon(Icons.apple_rounded),
              //       onTap: () {
              //         FirebaseAuth.instance.signOut();
              //         Navigator.pushNamed(context, "test");
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
