import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddFarmScreen extends StatefulWidget {
  const AddFarmScreen({Key? key}) : super(key: key);

  @override
  State<AddFarmScreen> createState() => _AddFarmScreenState();
}

class _AddFarmScreenState extends State<AddFarmScreen> {
  Color c1 = Color.fromARGB(255, 70, 209, 75);
  Color c3 = Colors.white;
  late User user;
  DatabaseReference? userRef;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    userRef = FirebaseDatabase.instance.ref().child("/users/${user.uid}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("farms".tr),
        ),
        body: SafeArea(
            child: FirebaseAnimatedList(
                defaultChild: Center(child: CircularProgressIndicator()),
                query: userRef! as Query,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
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
                                  Navigator.pushNamed(
                                      context, '${snapshot.key}');
                                }),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Image.asset(
                                      "img/plantera5.png",
                                      height: 120.0,
                                      width: 120.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 0, 50, 0),
                                      child: Text(
                                        snapshot.key!.tr,
                                        style: TextStyle(
                                          fontSize: 20,
                                          // color: Color(0xFFAABF06),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })));
  }
}
