import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:get/get.dart';
import '../componant/ambair.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmScreen9 extends StatefulWidget {
  const FarmScreen9({Key? key}) : super(key: key);

  @override
  State<FarmScreen9> createState() => _FarmScreen9State();
}

class _FarmScreen9State extends State<FarmScreen9> {
  List<String> options = ["tomatoes".tr, "potatoes".tr, "corn".tr, "switch".tr];
  String? selectedOption;
  Future<void> loadSelectedOption1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedOption = prefs.getString('selectedplat9');
    if (savedOption != null) {
      setState(() {
        selectedOption = savedOption;
      });
    }
  }

  late User user;
  DatabaseReference? ref;
  DatabaseReference? databaseRef1;
  DatabaseReference? databaseRef2;
  DatabaseReference? databaseRef3;
  DatabaseReference? refc1;
  DatabaseReference? refc2;
  DatabaseReference? refc3;
  DatabaseReference? reft1;
  DatabaseReference? reft2;
  DatabaseReference? reft3;
  DatabaseReference? refp1;
  DatabaseReference? refp2;
  DatabaseReference? refp3;
  @override
  void initState() {
    super.initState();
    loadSelectedOption1();
    user = FirebaseAuth.instance.currentUser!;
    ref = FirebaseDatabase.instance.ref().child("/users/${user.uid}/farm9/");
    databaseRef1 = FirebaseDatabase.instance
        .ref()
        .child('/users/${user.uid}/farm9/temperature_realtime');
    databaseRef2 = FirebaseDatabase.instance
        .ref()
        .child('/users/${user.uid}/farm9/airhumidity_realtime');
    databaseRef3 = FirebaseDatabase.instance
        .ref()
        .child('/users/${user.uid}/farm9/soilmoisture_realtime');

    refc1 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm9/tempc');
    refc2 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm9/airc');
    refc3 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm9/soilc');

    reft1 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm9/tempt');
    reft2 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm9/airt');
    reft3 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm9/soilt');

    refp1 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm9/tempp');
    refp2 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm9/airp');
    refp3 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm9/soilp');
  }

  @override
  Widget build(BuildContext context) {
    String? tt;
    String? at;
    String? st;
    String? tp;
    String? ap;
    String? sp;
    String? ac;
    String? sc;
    String? tc;
    double width = MediaQuery.of(context).size.width;
    int? x;
    return Scaffold(
      appBar: AppBar(
        title: Text("farm9".tr),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            DropdownButton(
              borderRadius: BorderRadius.circular(15),
              value: selectedOption,
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option.tr,
                  child: Text(option.tr),
                );
              }).toList(),
              onChanged: (String? newValue) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('selectedplat9', newValue!);
                if (newValue == "corn".tr) {
                  setState(() {
                    x = 0;
                  });
                } else if (newValue == "potatoes".tr) {
                  setState(() {
                    x = 1;
                  });
                } else if (newValue == "tomatoes".tr) {
                  setState(() {
                    x = 2;
                  });
                } else if (newValue == "switch".tr) {
                  setState(() {
                    x = 3;
                  });
                }
                FirebaseDatabase.instance
                    .ref('/users/${user.uid}/farm9')
                    .update({'plant': x});
                setState(() {
                  selectedOption = newValue;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            if (selectedOption == "corn".tr)
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 180,
                        width: width * 0.54,
                        child: FirebaseAnimatedList(
                            query: databaseRef1! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      '/users/${user.uid}/farm9/temperature_realtime')
                                  .value
                                  .toString());

                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 30, 20, 0),
                                    child: ambair(0, 70, x, "temperature", "C°",
                                        Color.fromARGB(255, 236, 39, 39)),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 180,
                        width: width * 0.46,
                        child: FirebaseAnimatedList(
                            query: refc1! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child("/users/${user.uid}/farm9/tempc")
                                  .value
                                  .toString());

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      x.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 20, 45, 0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        tc = value;
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        label: Text("change".tr),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (tc == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'textformisempty'.tr,
                                              ),
                                              action: SnackBarAction(
                                                label: ('youshouldwriteanumber'
                                                    .tr),
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        } else {
                                          double value =
                                              double.parse(tc.toString());
                                          FirebaseDatabase.instance
                                              .ref(
                                                  '/users/${user.uid}/farm9/airc')
                                              .update({"value": value});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        // color: Colors.black,
                                      ))
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 180,
                        width: width * 0.54,
                        child: FirebaseAnimatedList(
                            query: databaseRef2 as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      "/users/${user.uid}/farm9/airhumidity_realtime")
                                  .value
                                  .toString());
                              return Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 30, 20, 0),
                                    child: ambair(
                                        0,
                                        200,
                                        x,
                                        "airhumidity",
                                        "RH",
                                        Color.fromARGB(255, 40, 200, 228)),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 180,
                        width: width * 0.46,
                        child: FirebaseAnimatedList(
                            query: refc2! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child("/users/${user.uid}/farm9/airc")
                                  .value
                                  .toString());
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      x.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 20, 45, 0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        ac = value;
                                      },
                                      //controller: ac,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        label: Text("change".tr),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (ac == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'textformisempty'.tr,
                                              ),
                                              action: SnackBarAction(
                                                label: ('youshouldwriteanumber'
                                                    .tr),
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        } else {
                                          double value =
                                              double.parse(ac.toString());
                                          FirebaseDatabase.instance
                                              .ref(
                                                  '/users/${user.uid}/farm9/airc')
                                              .update({"value": value});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        // color: Colors.black,
                                      ))
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 180,
                        width: width * 0.54,
                        child: FirebaseAnimatedList(
                            query: databaseRef3 as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      "/users/${user.uid}/farm9/soilmoisture_realtime")
                                  .value
                                  .toString());
                              return Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 30, 20, 0),
                                    child: ambair(0, 1024, x, "soilmoisture",
                                        "%", Color.fromARGB(255, 40, 200, 228)),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 180,
                        width: width * 0.46,
                        child: FirebaseAnimatedList(
                            query: refc3! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child("/users/${user.uid}/farm9/soilc")
                                  .value
                                  .toString());
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      x.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 20, 45, 0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        sc = value;
                                      },
                                      //controller: sc,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        label: Text("change".tr),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (sc == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'textformisempty'.tr,
                                              ),
                                              action: SnackBarAction(
                                                label: ('youshouldwriteanumber'
                                                    .tr),
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        } else {
                                          double value =
                                              double.parse(sc.toString());
                                          FirebaseDatabase.instance
                                              .ref(
                                                  '/users/${user.uid}/farm9/soilc')
                                              .update({"value": value});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        // color: Colors.black,
                                      ))
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                    child: SizedBox(
                      height: 70,
                      width: 330,
                      child: ElevatedButton(
                        onPressed: (() {
                          Navigator.pushNamed(context, "predict");
                        }),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text(
                          "predictgrowth".tr,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else if (selectedOption == "potatoes".tr)
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 180,
                        width: width * 0.54,
                        child: FirebaseAnimatedList(
                            query: databaseRef1 as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      "/users/${user.uid}/farm9/temperature_realtime")
                                  .value
                                  .toString());

                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 30, 20, 0),
                                    child: ambair(0, 70, x, "temperature", "C°",
                                        Color.fromARGB(255, 236, 39, 39)),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 180,
                        width: width * 0.46,
                        child: FirebaseAnimatedList(
                            query: refp1! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child("/users/${user.uid}/farm9/tempp")
                                  .value
                                  .toString());
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      x.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 20, 45, 0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        tp = value;
                                      },
                                      // controller: tp,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        label: Text("change".tr),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (tp == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'textformisempty'.tr,
                                              ),
                                              action: SnackBarAction(
                                                label: ('youshouldwriteanumber'
                                                    .tr),
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        } else {
                                          double value =
                                              double.parse(tp.toString());
                                          FirebaseDatabase.instance
                                              .ref(
                                                  '/users/${user.uid}/farm9/tempp')
                                              .update({"value": value});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        // color: Colors.black,
                                      ))
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 180,
                        width: width * 0.54,
                        child: FirebaseAnimatedList(
                            query: databaseRef2 as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      "/users/${user.uid}/farm9/airhumidity_realtime")
                                  .value
                                  .toString());
                              return Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 30, 20, 0),
                                    child: ambair(
                                        0,
                                        200,
                                        x,
                                        "airhumidity",
                                        "RH",
                                        Color.fromARGB(255, 40, 200, 228)),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 180,
                        width: width * 0.46,
                        child: FirebaseAnimatedList(
                            query: refp2! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child("/users/${user.uid}/farm9/airp")
                                  .value
                                  .toString());
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      x.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 20, 45, 0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        ap = value;
                                      },
                                      //controller: ap,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        label: Text("change".tr),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (ap == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'textformisempty'.tr,
                                              ),
                                              action: SnackBarAction(
                                                label: ('youshouldwriteanumber'
                                                    .tr),
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        } else {
                                          double value =
                                              double.parse(ap.toString());
                                          FirebaseDatabase.instance
                                              .ref(
                                                  '/users/${user.uid}/farm9/airp')
                                              .update({"value": value});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        // color: Colors.black,
                                      ))
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 180,
                        width: width * 0.54,
                        child: FirebaseAnimatedList(
                            query: databaseRef3 as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      "/users/${user.uid}/farm9/soilmoisture_realtime")
                                  .value
                                  .toString());
                              return Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 30, 20, 0),
                                    child: ambair(0, 1024, x, "soilmoisture",
                                        "%", Color.fromARGB(255, 40, 200, 228)),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 180,
                        width: width * 0.46,
                        child: FirebaseAnimatedList(
                            query: refp3! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child("/users/${user.uid}/farm9/soilp")
                                  .value
                                  .toString());
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      x.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 20, 45, 0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        sp = value;
                                      },
                                      //controller: sp,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        label: Text("change".tr),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (sp == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'textformisempty'.tr,
                                              ),
                                              action: SnackBarAction(
                                                label: ('youshouldwriteanumber'
                                                    .tr),
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        } else {
                                          double value =
                                              double.parse(sp.toString());
                                          FirebaseDatabase.instance
                                              .ref(
                                                  '/users/${user.uid}/farm9/soilp')
                                              .update({"value": value});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        // color: Colors.black,
                                      ))
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                    child: SizedBox(
                      height: 70,
                      width: 330,
                      child: ElevatedButton(
                        onPressed: (() {
                          Navigator.pushNamed(context, "predict");
                        }),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text(
                          "predictgrowth".tr,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else if (selectedOption == "tomatoes".tr)
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 180,
                        width: width * 0.54,
                        child: FirebaseAnimatedList(
                            query: databaseRef1 as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      "/users/${user.uid}/farm9/temperature_realtime")
                                  .value
                                  .toString());

                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 30, 20, 0),
                                    child: ambair(0, 70, x, "temperature", "C°",
                                        Color.fromARGB(255, 236, 39, 39)),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 180,
                        width: width * 0.46,
                        child: FirebaseAnimatedList(
                            query: reft1! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child("/users/${user.uid}/farm9/tempt")
                                  .value
                                  .toString());

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      x.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 20, 45, 0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        tt = value;
                                      },
                                      //controller: tt,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        label: Text("change".tr),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (tt == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'textformisempty'.tr,
                                              ),
                                              action: SnackBarAction(
                                                label: ('youshouldwriteanumber'
                                                    .tr),
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        } else {
                                          double value =
                                              double.parse(tt.toString());
                                          FirebaseDatabase.instance
                                              .ref(
                                                  '/users/${user.uid}/farm9/tempt')
                                              .update({"value": value});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        // color: Colors.black,
                                      ))
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 180,
                        width: width * 0.54,
                        child: FirebaseAnimatedList(
                            query: databaseRef2 as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      "/users/${user.uid}/farm9/airhumidity_realtime")
                                  .value
                                  .toString());
                              return Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 30, 20, 0),
                                    child: ambair(
                                        0,
                                        200,
                                        x,
                                        "airhumidity",
                                        "RH",
                                        Color.fromARGB(255, 40, 200, 228)),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 180,
                        width: width * 0.46,
                        child: FirebaseAnimatedList(
                            query: reft2! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child("/users/${user.uid}/farm9/airt")
                                  .value
                                  .toString());
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      x.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 20, 45, 0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        at = value;
                                      },
                                      //controller: at,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        label: Text("change".tr),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (at == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'textformisempty'.tr,
                                              ),
                                              action: SnackBarAction(
                                                label: ('youshouldwriteanumber'
                                                    .tr),
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        } else {
                                          double value =
                                              double.parse(at.toString());
                                          FirebaseDatabase.instance
                                              .ref(
                                                  '/users/${user.uid}/farm9/airt')
                                              .update({"value": value});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        // color: Colors.black,
                                      ))
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 180,
                        width: width * 0.54,
                        child: FirebaseAnimatedList(
                            query: databaseRef3 as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      "/users/${user.uid}/farm9/soilmoisture_realtime")
                                  .value
                                  .toString());
                              return Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 30, 20, 0),
                                    child: ambair(0, 1024, x, "soilmoisture",
                                        "%", Color.fromARGB(255, 40, 200, 228)),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 180,
                        width: width * 0.46,
                        child: FirebaseAnimatedList(
                            query: reft3! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child("/users/${user.uid}/farm9/soilt")
                                  .value
                                  .toString());
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      x.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 20, 45, 0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        st = value;
                                      },
                                      //controller: st,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        label: Text("change".tr),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (st == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'textformisempty'.tr,
                                              ),
                                              action: SnackBarAction(
                                                label: ('youshouldwriteanumber'
                                                    .tr),
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        } else {
                                          double value =
                                              double.parse(st.toString());
                                          FirebaseDatabase.instance
                                              .ref(
                                                  '/users/${user.uid}/farm9/soilt')
                                              .update({"value": value});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        // color: Colors.black,
                                      ))
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                    child: SizedBox(
                      height: 70,
                      width: 330,
                      child: ElevatedButton(
                        onPressed: (() {
                          Navigator.pushNamed(context, "predict");
                        }),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text(
                          "predictgrowth".tr,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else if (selectedOption == "switch".tr)
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text("loading".tr),
              )),
          ],
        ),
      ),
    );
  }
}
