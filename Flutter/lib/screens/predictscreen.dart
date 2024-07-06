// ignore_for_file: unused_import, depend_on_referenced_packages, unused_local_variable

import 'dart:ffi';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class predictGrowth extends StatefulWidget {
  const predictGrowth({Key? key}) : super(key: key);

  @override
  State<predictGrowth> createState() => _predictGrowth();
}

class _predictGrowth extends State<predictGrowth> {
  late User user;
  String? selectedOption;
  List<String> items = [
    " ",
    'Cassava'.tr,
    'Maize'.tr,
    'Plantains and others'.tr,
    'Potatoes'.tr,
    'Rice,paddy'.tr,
    'Sorghum'.tr,
    'Soybeans'.tr,
    'Sweet potatoes'.tr,
    'Wheat'.tr,
    'Yams'.tr
  ];
  void initState() {
    super.initState();
  }

  Future<void> predict(
      {required String cn,
      required String rpn,
      required String ar,
      required String pt,
      required String at}) async {
    var url = Uri.parse(
        'https://planteraapi-production.up.railway.app/predictCropYieldApi');
    try {
      print(at);
      var response = await http.post(
          Uri.parse(
              'https://planteraapi-production.up.railway.app/predictCropYieldApi'),
          body: {
            'AverageTemp': at,
            'AverageRainfall': ar,
            'CropName': rpn,
            'CountryName': cn,
            'PesticideTonnes': pt
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final parsedJson = json.decode(response.body);
        print(parsedJson);
        var data = jsonDecode(response.body);
        //print(data['prediction']);

        setState(() {
          pp = data['prediction'] as double;
        });
        print(pp);
      } else {
        throw Exception('Failed to make prediction request');
      }
    } catch (e) {
      print("hee");
      print(e.toString());
    }
  }

  double pp = 0.0;
  String mean_t = '',
      country_n = "",
      mean_rainfall = '',
      p_tonnes = '',
      s = "",
      crop_n = '';
  late String mean_tt, country_nn, mean_rainfalll, p_tonness, crop_nn;
  bool visible = true;
  String? selectedValue;
  var features;
  var prediction;
  String? x;
  String? pes_tonnes;
  String? mean_temp;
  String? country_name;
  String? mean_rainfall2;
  TextEditingController mean_tconroller = TextEditingController();
  TextEditingController country_nconroller = TextEditingController();
  TextEditingController mean_rainfallconroller = TextEditingController();
  TextEditingController p_tonnesconroller = TextEditingController();
  TextEditingController crop_nconroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  var mm = {
    'Maize': 0.0,
    'Potatoes': 1.0,
    'Rice,paddy': 2.0,
    'Sorghum': 3.0,
    'Soybeans': 4.0,
    'Wheat': 5.0,
    'Cassava': 6.0,
    'Sweet potatoes': 7.0,
    'Plantains and others': 8.0,
    'Yams': 9.0
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("predictgrowth".tr),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 20),
            DropdownButton(
              borderRadius: BorderRadius.circular(15),
              value: selectedOption,
              items: items.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option.tr),
                );
              }).toList(),
              onChanged: (String? newValue) async {
                setState(() {
                  selectedOption = newValue;
                  crop_n = newValue as String;
                  print(mm[crop_n]);
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: mean_tconroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: 'Enter Average of Temperature ',
                          hintText: 'Temperature',
                        ),
                        onChanged: (value) {
                          setState(() {
                            setState(() {
                              mean_t = value;
                              mean_temp = value;
                            });
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                          controller: mean_rainfallconroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            labelText: 'Enter Average of Rainfall',
                            hintText: 'Rainfall',
                          ),
                          onChanged: (value) {
                            setState(() {
                              setState(() {
                                mean_rainfall = value;
                                mean_rainfall2 = value;
                              });
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                          controller: p_tonnesconroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            labelText: 'Enter Pesticide tonnes',
                            hintText: 'Pesticide',
                          ),
                          onChanged: (value) {
                            setState(() {
                              setState(() {
                                p_tonnes = value;
                                pes_tonnes = value;
                              });
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                          // controller: country_nconroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            labelText: 'Enter Country name',
                            hintText: 'Country',
                          ),
                          onChanged: (value) {
                            setState(() {
                              setState(() {
                                country_n = value;
                                country_name = value;
                              });
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              // style: ElevatedButton.styleFrom(primary: Colors.brown),
              child: Text('predict growth'.tr),
              onPressed: () {
                (pes_tonnes == null ||
                        mean_temp == null ||
                        country_name == null ||
                        mean_rainfall2 == null ||
                        x == " ")
                    ? {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            //backgroundColor: Colors.white,
                            content: Text(
                              'You must fill these 5 items!'.tr,
                              //style: TextStyle(color: Colors.red),
                            ),
                            action: SnackBarAction(
                              label: ('Hai'.tr),
                              onPressed: () {
                                // Code to execute.
                              },
                            ),
                          ),
                        ),
                        print(visible)
                      }
                    : {
                        setState(() {
                          mean_tt = mean_tconroller.text.trim();
                          mean_rainfalll = mean_rainfallconroller.text.trim();
                          p_tonness = p_tonnesconroller.text.trim();
                          // crop_nn=double.parse(mm[crop_n].toString());
                          //   country_nn=double.parse(country_nconroller.text.toString());
                          predict(
                              ar: mean_rainfalll,
                              rpn: mm[crop_n].toString(),
                              at: mean_tt,
                              cn: '27.0',
                              pt: p_tonness);
                          //print(prediction);
                          visible = !visible;
                        }),
                      };

                // ...
              },
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: (visible == false)
                    ? Column(
                        children: [
                          Text(
                            '${pp}' + " kg/ha ".tr,
                          )
                        ],
                      )
                    : Column(
                        children: [],
                      )),
          ]),
        ));
  }
}
