import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'WelcomePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.removeAfter(initialization);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const WelcomePageWidget());
  

}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 1));
}
