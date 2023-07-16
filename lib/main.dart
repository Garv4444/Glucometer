import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glucometer/screens/about.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constants.dart';
import 'screens/input_screen.dart';
import 'screens/result.dart';
import 'screens/ble_connection.dart';


void main() {
  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {

    }
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
   _getStoragePermission();
  runApp(
     MaterialApp(
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
          Results.id: (BuildContext context) => Results(),
          About.id: (BuildContext context) => const About(),
          Helper.id: (BuildContext context) => const Helper()
        },
    )
  );
}

