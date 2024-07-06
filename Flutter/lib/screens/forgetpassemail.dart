import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ForgetPasswordEmail extends StatelessWidget {
  final emailcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 15, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                "img/plantera4.png",
                height: 150.0,
                width: 150.0,
              ),
              SizedBox(
                height: 44,
              ),
              Text('forgetpassword'.tr,
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(
                height: 30,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: Text('email'.tr),
                      //hintText: 'email'.tr,
                      prefixIcon: Icon(Icons.mail_outline_rounded),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          child: Text('resetpassword'.tr),
                          style: ElevatedButton.styleFrom(
                            // primary: c1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          onPressed: () {
                            auth
                                .sendPasswordResetEmail(
                                    email: emailcontroller.text.toString())
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  //backgroundColor: Colors.white,
                                  content: Text(
                                    'wehavesentyouemailtorecoverpassword'.tr,
                                    // style: TextStyle(color: Colors.red),
                                  ),
                                  action: SnackBarAction(
                                    label: ('pleasecheckyouremail'.tr),
                                    onPressed: () {
                                      // Code to execute.
                                    },
                                  ),
                                ),
                              );
                            }).onError((error, stackTrace) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  //backgroundColor: Colors.white,
                                  content: Text("thereiserrorinyouremail".tr),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 80,
                        child: OutlinedButton(
                          child: Text(
                            'back'.tr,
                            //style: TextStyle(color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
