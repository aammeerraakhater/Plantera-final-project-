import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plantera/pref_services.dart';

class LanguageController extends GetxController {
  final PrefService _prefService = PrefService();
  var savedLang = 'EN'.obs;

  savedLocale() {
    _prefService.createString('locale', savedLang.value);
  }

  Future<void> setlocal() async {
    _prefService.readString('locale').then((value) {
      if (value != '' && value != null) {
        Get.updateLocale(Locale(value.toString().toLowerCase()));
        savedLang.value = value.toString();
      }
    });
  }

  @override
  void onInit() async {
    setlocal();
    super.onInit();
  }
}
