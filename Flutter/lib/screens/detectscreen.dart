import 'dart:convert';
import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class DetectScreen extends StatefulWidget {
  const DetectScreen({Key? key}) : super(key: key);

  @override
  State<DetectScreen> createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
  File? _image;
  String? result;
  final imagePicker = ImagePicker();
  var url = "https://planteraapi-production.up.railway.app/predictApi";

  Widget getImagewidget() {
    if (_image != null) {
      return Material(
        elevation: 5,
        child: Image.file(
          _image!,
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Material(
        elevation: 5,
        child: Image.asset(
          "img/wait.png",
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  getimage(ImageSource source) async {
    final image = await imagePicker.pickImage(source: source);
    if (image != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Plantera',
              toolbarColor: Color.fromARGB(255, 70, 209, 75),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      setState(() {
        _image = File(cropped!.path);
      });
    }
  }

  upload() async {
    final request = http.MultipartRequest("POST", Uri.parse(url));
    final header = {"Content_type": "mutipart/form-data"};
    request.files.add(http.MultipartFile(
        'fileup', _image!.readAsBytes().asStream(), _image!.lengthSync(),
        filename: _image!.path.split("/").last));
    request.headers.addAll(header);
    final myRequest = await request.send();
    http.Response res = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      final resjson = jsonDecode(res.body);
      print("response here : $resjson");
      setState(() {
        result = resjson['prediction'];
      });

      print('result = $result');
    } else {
      print("Erorr : ${myRequest.statusCode}");
    }
  }

  bool _switch = false;
  final Stream<QuerySnapshot> dis =
      FirebaseFirestore.instance.collection("plant").snapshots();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("detect".tr),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 90, 40, 0),
            child: getImagewidget(),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: (_image == null)
                  ? Column(
                      children: [],
                    )
                  : Text(
                      "disease is : ".tr + "${result}".tr,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: (() {
                      getimage(ImageSource.camera);
                    }),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.camera_alt_rounded),
                        ),
                        Text(
                          "camera".tr,
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: (() {
                      getimage(ImageSource.gallery);
                    }),
                    style: ElevatedButton.styleFrom(
                      // primary: c1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.camera),
                        ),
                        Text(
                          "device".tr,
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 130, 40, 0),
            child: SizedBox(
              height: 70,
              width: 330,
              child: ElevatedButton(
                onPressed: (() {
                  upload();
                }),
                style: ElevatedButton.styleFrom(
                  // primary: c1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(
                  "upload".tr,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: (result == null ||
                    result == 'Tomato___healthy' ||
                    result == 'Strawberry___healthy' ||
                    result == 'Soybean___healthy' ||
                    result == 'Raspberry___healthy' ||
                    result == 'Potato___healthy' ||
                    result == 'Pepper,_bell___healthy' ||
                    result == 'Peach___healthy' ||
                    result == 'Grape___healthy' ||
                    result == 'Corn_(maize)___healthy' ||
                    result == 'Cherry_(including_sour)___healthy' ||
                    result == 'Blueberry___healthy' ||
                    result == 'Apple___healthy' ||
                    result == 'please add plants picture')
                ? Center()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
                    child: SizedBox(
                      height: 70,
                      width: 330,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _switch = !_switch;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            // primary: c1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Text(
                            "know_the_treatment".tr,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                    ),
                  ),
          ),
          Center(
              child: (_switch == true)
                  ? Container(
                      height: 300,
                      width: width - 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Color.fromARGB(255, 134, 133, 133),
                      ),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: dis,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("you have an error".tr);
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text("nodata"),
                            );
                          }

                          final data = snapshot.requireData;
                          return ListView.builder(
                            itemCount: data.size,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "${data.docs[index][result!]}".tr,
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : Center()),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
