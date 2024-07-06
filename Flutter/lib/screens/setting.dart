import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantera/componant/language_controlar.dart';
import 'package:plantera/componant/theme.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    const moonicon = CupertinoIcons.moon_stars;
    return Scaffold(
        appBar: AppBar(
          title: Text("setting".tr),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text("darkmode".tr),
                SizedBox(
                  width: 80,
                ),
                IconButton(
                    onPressed: () {
                      ThemeService().changetheme();
                    },
                    icon: Icon(
                      moonicon,
                      color: Colors.grey,
                    )),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text("language".tr),
                SizedBox(
                  width: 100,
                ),
                GetBuilder<LanguageController>(
                  init: LanguageController(),
                  builder: (Value) {
                    return DropdownButton<String>(
                        value: Value.savedLang.value,
                        elevation: 6,
                        items: [
                          DropdownMenuItem(
                            child: Text("EN"),
                            value: 'EN',
                          ),
                          DropdownMenuItem(
                            child: Text("AR"),
                            value: 'AR',
                          ),
                        ],
                        onChanged: (String? newvalue) {
                          Value.savedLang.value = newvalue!;
                          Get.updateLocale(Locale(newvalue.toLowerCase()));
                          Value.savedLocale();
                        });
                  },
                ),
                const SizedBox(
                  width: 100,
                ),
              ],
            ),
          ],
        ));
  }
}
