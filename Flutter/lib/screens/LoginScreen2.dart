import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passtoggle = true;
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Sucessfulllogin'.tr,
          ),
          action: SnackBarAction(
            label: ('Hi'.tr),
            onPressed: () {},
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found" || e.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'usernameunknown'.tr,
            ),
            action: SnackBarAction(
              label: ('tryanthorone'.tr),
              onPressed: () {},
            ),
          ),
        );
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'passwordunknown'.tr,
            ),
            action: SnackBarAction(
              label: ('tryanthorone'.tr),
              onPressed: () {},
            ),
          ),
        );
      }
    }
    return user;
  }

  bool showSpiner = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    // ignore: unused_local_variable
    final formfield = GlobalKey<FormState>();

    return ModalProgressHUD(
      inAsyncCall: showSpiner,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Image.asset(
                "img/plantera4.png",
                height: 180.0,
                width: 180.0,
              ),
              SizedBox(
                height: 44,
              ),
              TextFormField(
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  label: Text(
                    "useremail".tr,
                    style: GoogleFonts.ubuntu(
                      fontSize: 14,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.mail,
                  ),
                ),
                textInputAction: TextInputAction.next,
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'please type Password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 26,
              ),
              TextFormField(
                controller: passwordcontroller,
                obscureText: passtoggle,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    label: Text("userpassword".tr),
                    prefixIcon: Icon(
                      Icons.lock,
                      // color: Colors.black,
                    )),
                keyboardType: TextInputType.visiblePassword,
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'please type Password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "forgetemail");
                  /*showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      context: context,
                      builder: (context) => Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 15, 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "makeselection!".tr,
                                style: Theme.of(context).textTheme.headline2,
                                //style: TextStyle(fontSize: 2),
                              ),
                              Text(
                                "selectoneoftheoptiongivenbelowtoresetyourpassword"
                                    .tr,
                                style: Theme.of(context).textTheme.bodyText2,
                                //style: TextStyle(fontSize: 2),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "forgetemail");
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    //color: Colors.grey.shade200,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.mail_outline_rounded,
                                        size: 60,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "withemail".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                            // style: TextStyle(fontSize: 2),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "forgetphone");
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Colors.grey.shade200,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.mobile_friendly_rounded,
                                        size: 60,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "withphonenumber".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                            //style: TextStyle(fontSize: 2),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );*/
                },
                child: Text(
                  "forgetpassword".tr,
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                height: 88,
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () async {
                    setState(() {
                      showSpiner = true;
                    });
                    User? user = await loginUsingEmailPassword(
                        email: emailcontroller.text,
                        password: passwordcontroller.text,
                        context: context);
                    // print("user");

                    if (user != null) {
                      Navigator.pushNamed(context, "chose");
                      setState(() {
                        showSpiner = false;
                      });
                    } else {
                      setState(() {
                        showSpiner = false;
                      });
                    }
                  },
                  child: Text(
                    "login".tr,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
