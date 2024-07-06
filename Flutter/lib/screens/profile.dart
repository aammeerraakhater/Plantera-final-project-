import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("myprofile".tr),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(65, 50, 65, 30),
            child: Center(
              child: ClipOval(
                child: Image(
                  image: AssetImage("img/wait.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 150),
              Text(
                "acountinfo".tr,
                style: TextStyle(
                  fontSize: (14),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 150),
            ],
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              "username".tr,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('${FirebaseAuth.instance.currentUser?.email}'),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
