import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glucometer/screens/about.dart';

import 'constants.dart';
import 'screens/input_screen.dart';
import 'screens/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xff212121),
          secondary: const Color(0xff0D7377),
        ),
        scaffoldBackgroundColor: const Color(0xff212121),
        textButtonTheme: kButtonStyle,
      ),
      initialRoute: Input.id,
      routes: <String, WidgetBuilder>{
        Input.id: (BuildContext context) => const Input(),
        Results.id: (BuildContext context) => const Results(),
        About.id: (BuildContext context) => const About()
      },
    );
  }
}
