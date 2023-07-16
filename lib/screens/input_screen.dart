import 'package:flutter/material.dart';
import 'package:glucometer/constants.dart';
import 'package:glucometer/screens/about.dart';
import 'package:glucometer/screens/ble_connection.dart';
import 'result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Input extends StatefulWidget {
  static const String id = "input_screen";
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  Color currColor = kSecondaryColour;
  static const String fast = "Fasting";
  static const String pp = "Postprandial";
  String current = pp;

  void handleClick(String value) {
    switch (value) {
      case '$fast mode':
        setState(() {
          current = fast;
          currColor = kFastSecondaryColour;
          Results.setCurrent(true);
        });
        break;
      case '$pp mode':
        setState(() {
          current = pp;
          currColor = kSecondaryColour;
          Results.setCurrent(false);
        });
        break;
      case 'About':
        Navigator.pushNamed(context, About.id);
        break;
      case 'Connect Bluetooth':
        Navigator.pushNamed(context, Helper.id);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              '     SUCRE',
              style: TextStyle(fontSize: 25),
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'${current == pp ? fast : pp} mode','Connect Bluetooth', 'About'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Text(
                        'CHECK ${current.toUpperCase()} SUGAR LEVEL',
                        style: kTitleStyle.copyWith(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: const Size(0, 75),
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      cursorColor: currColor,
                      cursorWidth: 2,
                      cursorHeight: 30,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: kLightColour,
                          suffix: const Text('mg/dL'),
                          labelText: 'Enter Blood Sugar',
                          labelStyle: const TextStyle(
                            fontSize: 23,
                          )),
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                      onChanged: (value) {
                        Results.value = double.parse(value);
                      },
                    ),
                  ),
                  SizedBox.fromSize(
                    size: const Size(0, 20),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(currColor)),
                    onPressed: () {
                      Navigator.pushNamed(context, Results.id);
                    },
                    child: Text(
                      'SEE RESULTS',
                      style: kTitleStyle.copyWith(fontSize: 18),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: const Size(0, 20),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: currColor,
              width: double.infinity,
              height: 70,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Helper.id);
                },
                child: const Center(
                    child: Text(
                  'READ FROM GLUCOMETER',
                  style: kTitleStyle,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
