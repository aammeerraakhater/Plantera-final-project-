import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plantera/componant/languages.dart';
import 'package:plantera/componant/theme.dart';
import 'package:plantera/screens/addfarmscreen.dart';
import 'package:plantera/screens/auth.dart';
import 'package:plantera/screens/chosescreen.dart';
import 'package:plantera/screens/detectscreen.dart';
import 'package:plantera/screens/farmscreen1.dart';
import 'package:plantera/screens/farmscreen10.dart';
import 'package:plantera/screens/farmscreen11.dart';
import 'package:plantera/screens/farmscreen12.dart';
import 'package:plantera/screens/farmscreen2.dart';
import 'package:plantera/screens/farmscreen3.dart';
import 'package:plantera/screens/farmscreen4.dart';
import 'package:plantera/screens/farmscreen5.dart';
import 'package:plantera/screens/farmscreen6.dart';
import 'package:plantera/screens/farmscreen7.dart';
import 'package:plantera/screens/farmscreen8.dart';
import 'package:plantera/screens/farmscreen9.dart';
import 'package:plantera/screens/forgetpassemail.dart';
import 'package:plantera/screens/predictscreen.dart';
import 'package:plantera/screens/profile.dart';
import 'package:plantera/screens/setting.dart';
import 'package:plantera/screens/help.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: unused_local_variable
  FirebaseApp firebaseApp = await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeService().lighttheme,
      darkTheme: ThemeService().darktheme,
      themeMode: ThemeService().getthememode(),
      translations: Translation(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en'),
      home: AnimatedSplashScreen(
        splash: Image.asset(
          "img/plantera3.png",
        ),
        splashIconSize: double.maxFinite,
        centered: true,
        nextScreen: _auth.currentUser != null ? ChoseScreen() : auth(),
        duration: 1000,
      ),
      routes: {
        "login": (context) => auth(),
        "chose": (context) => ChoseScreen(),
        "add": (context) => const AddFarmScreen(),
        "farm1": (context) => const FarmScreen1(),
        "farm2": (context) => const FarmScreen2(),
        "farm3": (context) => const FarmScreen3(),
        "farm4": (context) => const FarmScreen4(),
        "farm5": (context) => const FarmScreen5(),
        "farm6": (context) => const FarmScreen6(),
        "farm7": (context) => const FarmScreen7(),
        "farm8": (context) => const FarmScreen8(),
        "farm9": (context) => const FarmScreen9(),
        "farm10": (context) => const FarmScreen10(),
        "farm11": (context) => const FarmScreen11(),
        "farm12": (context) => const FarmScreen12(),
        "detect": (context) => const DetectScreen(),
        "profile": (context) => const Profile(),
        "setting": (context) => const Setting(),
        "help": (context) => const Help(),
        "predict": (context) => const predictGrowth(),
        'forgetemail': (context) => ForgetPasswordEmail(),
      },
    );
  }
}
