import 'package:get/get.dart';
import 'package:plantera/componant/ar.dart';
import 'package:plantera/componant/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': ar,
        'en': en,
      };
}
