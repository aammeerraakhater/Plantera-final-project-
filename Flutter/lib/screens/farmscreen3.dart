// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantera/componant/ambair.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:get/get.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmScreen3 extends StatefulWidget {
  const FarmScreen3({Key? key}) : super(key: key);

  @override
  State<FarmScreen3> createState() => _FarmScreen3State();
}

class _FarmScreen3State extends State<FarmScreen3> {
  List<String> options = ["tomatoes", "potatoes", "corn", "switch"];
  String? selectedOption;
  Future<void> loadSelectedOption1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedOption = prefs.getString('selectedplat3');
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
  DatabaseReference? databaseRef4;
  DatabaseReference? refc3;
  DatabaseReference? reft3;
  DatabaseReference? refp3;
  DatabaseReference? refc4;
  DatabaseReference? reft4;
  DatabaseReference? refp4;
  DatabaseReference? refbattery;
  DatabaseReference? refweather;
  @override
  void initState() {
    super.initState();
    loadSelectedOption1();
    user = FirebaseAuth.instance.currentUser!;
    ref = FirebaseDatabase.instance.ref().child("/users/${user.uid}/farm3/");
    databaseRef1 = FirebaseDatabase.instance
        .ref()
        .child('/users/${user.uid}/farm3/temperature_realtime');
    databaseRef2 = FirebaseDatabase.instance
        .ref()
        .child('/users/${user.uid}/farm3/airhumidity_realtime');
    databaseRef3 = FirebaseDatabase.instance
        .ref()
        .child('/users/${user.uid}/farm3/soilmoisture_realtime');

    databaseRef4 = FirebaseDatabase.instance
        .ref()
        .child('/users/${user.uid}/farm3/ph_realtime');
    refbattery = FirebaseDatabase.instance
        .ref()
        .child('/users/${user.uid}/farm3/battery');
    refweather = FirebaseDatabase.instance
        .ref()
        .child('/users/${user.uid}/farm3/weather');

    refc4 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm3/phc');

    reft4 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm3/pht');

    refp4 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm3/php');
    refc3 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm3/soilc');

    reft3 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm3/soilt');

    refp3 =
        FirebaseDatabase.instance.ref().child('/users/${user.uid}/farm3/soilp');
  }

  @override
  Widget build(BuildContext context) {
    String? soilTomato;
    String? soilPotato;
    String? soilCorn;
    String? phTomato;
    String? phPotato;
    String? phCorn;

    double width = MediaQuery.of(context).size.width;
    int? x;
    return Scaffold(
      appBar: AppBar(
        title: Text("farm3".tr),
      ),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 50,
                  width: 150,
                  child: FirebaseAnimatedList(
                      query: refweather as Query,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        double x = double.parse(snapshot
                            .child("/users/${user.uid}/farm3/weather")
                            .value
                            .toString());
                        int y = x.toInt();
                        if ((y == 0)) {
                          return Column(
                            children: [],
                          );
                        } else {
                          return Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "It will rany today".tr,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )
                              ]);
                        }
                      }),
                ),
                DropdownButton(
                  borderRadius: BorderRadius.circular(15),
                  value: selectedOption,
                  items: options.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option.tr),
                    );
                  }).toList(),
                  onChanged: (String? newValue) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('selectedplat3', newValue!);
                    if (newValue == "corn") {
                      setState(() {
                        x = 0;
                      });
                    } else if (newValue == "potatoes") {
                      setState(() {
                        x = 1;
                      });
                    } else if (newValue == "tomatoes") {
                      setState(() {
                        x = 2;
                      });
                    } else if (newValue == "switch") {
                      setState(() {
                        x = 3;
                      });
                    }
                    FirebaseDatabase.instance
                        .ref('/users/${user.uid}/farm3')
                        .update({'plant': x});
                    setState(() {
                      selectedOption = newValue;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (selectedOption == "corn")
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 90,
                        width: width * 0.3,
                        child: FirebaseAnimatedList(
                            query: refbattery! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child('/users/${user.uid}/farm3/battery')
                                  .value
                                  .toString());
                              int y = x.toInt();
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                          child: (x < 50)
                                              ? Column(
                                                  children: [
                                                    (x < 5)
                                                        ? Icon(
                                                            Icons.battery_alert,
                                                            color: Colors.red,
                                                            size: 50)
                                                        : (x < 20)
                                                            ? Icon(
                                                                Icons
                                                                    .battery_2_bar,
                                                                size: 50,
                                                                color: Colors
                                                                    .orange
                                                                    .shade400,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .battery_3_bar,
                                                                size: 50)
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    (x == 100)
                                                        ? Icon(
                                                            Icons.battery_full,
                                                            size: 50,
                                                          )
                                                        : Icon(
                                                            Icons.battery_5_bar,
                                                            size: 50)
                                                  ],
                                                )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              "%",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                y.toString(),
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 90,
                        width: width * 0.33,
                        child: FirebaseAnimatedList(
                            query: databaseRef1! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      '/users/${user.uid}/farm3/temperature_realtime')
                                  .value
                                  .toString());

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: (x < 36)
                                            ? Icon(
                                                Icons.thermostat_outlined,
                                                size: 50,
                                                color: Colors.blue,
                                              )
                                            : Icon(
                                                Icons.thermostat_outlined,
                                                size: 50,
                                                color: Colors.red,
                                              ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              x.toString(),
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                "°C",
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 90,
                        width: width * 0.33,
                        child: FirebaseAnimatedList(
                            query: databaseRef2 as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      "/users/${user.uid}/farm3/airhumidity_realtime")
                                  .value
                                  .toString());
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Icon(
                                          Icons.water_drop_outlined,
                                          size: 50,
                                          color: Colors.lightBlue.shade400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              "%",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                x.toString(),
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: databaseRef3 as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child(
                                          "/users/${user.uid}/farm3/soilmoisture_realtime")
                                      .value
                                      .toString());
                                  return Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 20, 0),
                                        child: ambair(
                                            0,
                                            100,
                                            x,
                                            "soilmoisture",
                                            "%",
                                            Color.fromARGB(255, 40, 200, 228)),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: refc3! as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child("/users/${user.uid}/farm3/soilc")
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
                                            soilCorn = value;
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
                                            // ignore: unnecessary_null_comparison
                                            if (soilCorn == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'textformisempty'.tr,
                                                  ),
                                                  action: SnackBarAction(
                                                    label:
                                                        ('youshouldwriteanumber'
                                                            .tr),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              );
                                            } else {
                                              double z = double.parse(
                                                  soilCorn.toString());
                                              if (z > 100 || z < 0) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'thenumberisoutofrange'
                                                          .tr,
                                                    ),
                                                    action: SnackBarAction(
                                                      label:
                                                          ('youshouldwriteanumber<100'
                                                              .tr),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                FirebaseDatabase.instance
                                                    .ref(
                                                        '/users/${user.uid}/farm3/soilc')
                                                    .update({"value": z});
                                              }
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
                      /*Column(
                        children: [
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: databaseRef4! as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child(
                                          "/users/${user.uid}/farm3/ph_realtime")
                                      .value
                                      .toString());
                                  return Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 20, 0),
                                        child: ambair(0, 14, x, "acidity", "PH",
                                            Color.fromARGB(255, 40, 200, 228)),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: refc4! as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child("/users/${user.uid}/farm3/phc")
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
                                            phCorn = value;
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
                                            if (phCorn == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'textformisempty'.tr,
                                                  ),
                                                  action: SnackBarAction(
                                                    label:
                                                        ('youshouldwriteanumber'
                                                            .tr),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              );
                                            } else {
                                              double z = double.parse(
                                                  phCorn.toString());
                                              if (z < 0 || z > 14) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'thenumberisoutofrange'
                                                          .tr,
                                                    ),
                                                    action: SnackBarAction(
                                                      label:
                                                          ('youshouldwriteanumber<14'
                                                              .tr),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                FirebaseDatabase.instance
                                                    .ref(
                                                        '/users/${user.uid}/farm3/phc')
                                                    .update({"value": z});
                                              }
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
                    */
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "fertilizer".tr,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: RollingSwitch.icon(
                              width: 100,
                              height: 51,
                              innerSize: 41,
                              rollingInfoRight: const RollingIconInfo(
                                backgroundColor: Colors.green,
                              ),
                              rollingInfoLeft: const RollingIconInfo(
                                icon: Icons.close_sharp,
                                backgroundColor: Colors.grey,
                              ),
                              // ignore: avoid_types_as_parameter_names
                              onChanged: (bool state) {
                                if (state == true) {
                                  FirebaseDatabase.instance
                                      .ref(
                                          '/users/${user.uid}/farm3/ph_realtime')
                                      .update({"RT": 1});
                                } else {
                                  FirebaseDatabase.instance
                                      .ref(
                                          '/users/${user.uid}/farm3/ph_realtime')
                                      .update({"RT": 0});
                                }
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 60, 40, 0),
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
            else if (selectedOption == "potatoes")
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 90,
                        width: width * 0.3,
                        child: FirebaseAnimatedList(
                            query: refbattery! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child('/users/${user.uid}/farm3/battery')
                                  .value
                                  .toString());
                              int y = x.toInt();
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                          child: (x < 50)
                                              ? Column(
                                                  children: [
                                                    (x < 5)
                                                        ? Icon(
                                                            Icons.battery_alert,
                                                            color: Colors.red,
                                                            size: 50)
                                                        : (x < 20)
                                                            ? Icon(
                                                                Icons
                                                                    .battery_2_bar,
                                                                size: 50,
                                                                color: Colors
                                                                    .orange
                                                                    .shade400,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .battery_3_bar,
                                                                size: 50)
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    (x == 100)
                                                        ? Icon(
                                                            Icons.battery_full,
                                                            size: 50,
                                                          )
                                                        : Icon(
                                                            Icons.battery_5_bar,
                                                            size: 50)
                                                  ],
                                                )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              "%",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                y.toString(),
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 90,
                        width: width * 0.33,
                        child: FirebaseAnimatedList(
                            query: databaseRef1! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      '/users/${user.uid}/farm3/temperature_realtime')
                                  .value
                                  .toString());

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: (x < 36)
                                            ? Icon(
                                                Icons.thermostat_outlined,
                                                size: 50,
                                                color: Colors.blue,
                                              )
                                            : Icon(
                                                Icons.thermostat_outlined,
                                                size: 50,
                                                color: Colors.red,
                                              ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              x.toString(),
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                "°C",
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 90,
                        width: width * 0.33,
                        child: FirebaseAnimatedList(
                            query: databaseRef2 as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      "/users/${user.uid}/farm3/airhumidity_realtime")
                                  .value
                                  .toString());
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Icon(
                                          Icons.water_drop_outlined,
                                          size: 50,
                                          color: Colors.lightBlue.shade400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              "%",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                x.toString(),
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: databaseRef3 as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child(
                                          "/users/${user.uid}/farm3/soilmoisture_realtime")
                                      .value
                                      .toString());
                                  return Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 20, 0),
                                        child: ambair(
                                            0,
                                            100,
                                            x,
                                            "soilmoisture",
                                            "%",
                                            Color.fromARGB(255, 40, 200, 228)),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: refp3! as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child("/users/${user.uid}/farm3/soilp")
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
                                            soilPotato = value;
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
                                            if (soilPotato == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'textformisempty'.tr,
                                                  ),
                                                  action: SnackBarAction(
                                                    label:
                                                        ('youshouldwriteanumber'
                                                            .tr),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              );
                                            } else {
                                              double z = double.parse(
                                                  soilPotato.toString());
                                              if (z < 0 || z > 100) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'thenumberisoutofrange'
                                                          .tr,
                                                    ),
                                                    action: SnackBarAction(
                                                      label:
                                                          ('youshouldwriteanumber<100'
                                                              .tr),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                FirebaseDatabase.instance
                                                    .ref(
                                                        '/users/${user.uid}/farm3/soilp')
                                                    .update({"value": z});
                                              }
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

                      /*  Column(
                        children: [
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: databaseRef4! as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child(
                                          "/users/${user.uid}/farm3/ph_realtime")
                                      .value
                                      .toString());
                                  return Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 20, 0),
                                        child: ambair(0, 14, x, "acidity", "PH",
                                            Color.fromARGB(255, 40, 200, 228)),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: refp4! as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child("/users/${user.uid}/farm3/phc")
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
                                            phPotato = value;
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
                                            if (phPotato == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'textformisempty'.tr,
                                                  ),
                                                  action: SnackBarAction(
                                                    label:
                                                        ('youshouldwriteanumber'
                                                            .tr),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              );
                                            } else {
                                              double z = double.parse(
                                                  phPotato.toString());
                                              if (z < 0 || z > 14) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'thenumberisoutofrange'
                                                          .tr,
                                                    ),
                                                    action: SnackBarAction(
                                                      label:
                                                          ('youshouldwriteanumber<14'
                                                              .tr),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                FirebaseDatabase.instance
                                                    .ref(
                                                        '/users/${user.uid}/farm3/php')
                                                    .update({"value": z});
                                              }
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
                    */
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "fertilizer".tr,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: RollingSwitch.icon(
                              width: 100,
                              height: 51,
                              innerSize: 41,
                              rollingInfoRight: const RollingIconInfo(
                                backgroundColor: Colors.green,
                              ),
                              rollingInfoLeft: const RollingIconInfo(
                                icon: Icons.close_sharp,
                                backgroundColor: Colors.grey,
                              ),
                              // ignore: avoid_types_as_parameter_names
                              onChanged: (bool state) {
                                if (state == true) {
                                  FirebaseDatabase.instance
                                      .ref(
                                          '/users/${user.uid}/farm3/ph_realtime')
                                      .update({"RT": 1});
                                } else {
                                  FirebaseDatabase.instance
                                      .ref(
                                          '/users/${user.uid}/farm3/ph_realtime')
                                      .update({"RT": 0});
                                }
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 60, 40, 0),
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
            else if (selectedOption == "tomatoes")
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 90,
                        width: width * 0.3,
                        child: FirebaseAnimatedList(
                            query: refbattery! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child('/users/${user.uid}/farm3/battery')
                                  .value
                                  .toString());
                              int y = x.toInt();
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                          child: (x < 50)
                                              ? Column(
                                                  children: [
                                                    (x < 5)
                                                        ? Icon(
                                                            Icons.battery_alert,
                                                            color: Colors.red,
                                                            size: 50)
                                                        : (x < 20)
                                                            ? Icon(
                                                                Icons
                                                                    .battery_2_bar,
                                                                size: 50,
                                                                color: Colors
                                                                    .orange
                                                                    .shade400,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .battery_3_bar,
                                                                size: 50)
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    (x == 100)
                                                        ? Icon(
                                                            Icons.battery_full,
                                                            size: 50,
                                                          )
                                                        : Icon(
                                                            Icons.battery_5_bar,
                                                            size: 50)
                                                  ],
                                                )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              "%",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                y.toString(),
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 90,
                        width: width * 0.33,
                        child: FirebaseAnimatedList(
                            query: databaseRef1! as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      '/users/${user.uid}/farm3/temperature_realtime')
                                  .value
                                  .toString());

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: (x < 36)
                                            ? Icon(
                                                Icons.thermostat_outlined,
                                                size: 50,
                                                color: Colors.blue,
                                              )
                                            : Icon(
                                                Icons.thermostat_outlined,
                                                size: 50,
                                                color: Colors.red,
                                              ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              x.toString(),
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                "°C",
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 90,
                        width: width * 0.33,
                        child: FirebaseAnimatedList(
                            query: databaseRef2 as Query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              double x = double.parse(snapshot
                                  .child(
                                      "/users/${user.uid}/farm3/airhumidity_realtime")
                                  .value
                                  .toString());
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Icon(
                                          Icons.water_drop_outlined,
                                          size: 50,
                                          color: Colors.lightBlue.shade400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              "%",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                x.toString(),
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: databaseRef3 as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child(
                                          "/users/${user.uid}/farm3/soilmoisture_realtime")
                                      .value
                                      .toString());
                                  return Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 20, 0),
                                        child: ambair(
                                            0,
                                            100,
                                            x,
                                            "soilmoisture",
                                            "%",
                                            Color.fromARGB(255, 40, 200, 228)),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: reft3! as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child("/users/${user.uid}/farm3/soilt")
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
                                            soilTomato = value;
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
                                            if (soilTomato == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'textformisempty'.tr,
                                                  ),
                                                  action: SnackBarAction(
                                                    label:
                                                        ('youshouldwriteanumber'
                                                            .tr),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              );
                                            } else {
                                              double z = double.parse(
                                                  soilTomato.toString());
                                              if (z < 0 || z > 100) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'thenumberisoutofrange'
                                                          .tr,
                                                    ),
                                                    action: SnackBarAction(
                                                      label:
                                                          ('youshouldwriteanumber<100'
                                                              .tr),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                FirebaseDatabase.instance
                                                    .ref(
                                                        '/users/${user.uid}/farm3/soilt')
                                                    .update({"value": z});
                                              }
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
                      /*Column(
                        children: [
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: databaseRef4 as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child(
                                          "/users/${user.uid}/farm3/ph_realtime")
                                      .value
                                      .toString());
                                  return Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 20, 0),
                                        child: ambair(0, 14, x, "acidity", "PH",
                                            Color.fromARGB(255, 40, 200, 228)),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 170,
                            width: width * 0.5,
                            child: FirebaseAnimatedList(
                                query: reft4! as Query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  double x = double.parse(snapshot
                                      .child("/users/${user.uid}/farm3/pht")
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
                                            phTomato = value;
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
                                            if (phTomato == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'textformisempty'.tr,
                                                  ),
                                                  action: SnackBarAction(
                                                    label:
                                                        ('youshouldwriteanumber'
                                                            .tr),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              );
                                            } else {
                                              double z = double.parse(
                                                  phTomato.toString());
                                              if (z < 0 || z > 14) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'thenumberisoutofrange'
                                                          .tr,
                                                    ),
                                                    action: SnackBarAction(
                                                      label:
                                                          ('youshouldwriteanumber<14'
                                                              .tr),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                FirebaseDatabase.instance
                                                    .ref(
                                                        '/users/${user.uid}/farm3/pht')
                                                    .update({"value": z});
                                              }
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
                    */
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "fertilizer".tr,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: RollingSwitch.icon(
                              width: 100,
                              height: 51,
                              innerSize: 41,
                              rollingInfoRight: const RollingIconInfo(
                                backgroundColor: Colors.green,
                              ),
                              rollingInfoLeft: const RollingIconInfo(
                                icon: Icons.close_sharp,
                                backgroundColor: Colors.grey,
                              ),
                              // ignore: avoid_types_as_parameter_names
                              onChanged: (bool state) {
                                if (state == true) {
                                  FirebaseDatabase.instance
                                      .ref(
                                          '/users/${user.uid}/farm3/ph_realtime')
                                      .update({"RT": 1});
                                } else {
                                  FirebaseDatabase.instance
                                      .ref(
                                          '/users/${user.uid}/farm3/ph_realtime')
                                      .update({"RT": 0});
                                }
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 60, 40, 0),
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
            else if (selectedOption == "switch")
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
