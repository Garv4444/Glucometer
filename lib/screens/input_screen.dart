import 'package:flutter/material.dart';
import 'package:glucometer/constants.dart';

import 'result.dart';

class Input extends StatefulWidget {
  static const String id = "input_screen";
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
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
            'SUCRE',
            style: TextStyle(fontSize: 25),
          )),
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'CHECK SUGAR LEVEL',
                      style: kTitleStyle.copyWith(fontSize: 25),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: const Size(0, 50),
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      cursorColor: kSecondaryColour,
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
              color: kSecondaryColour,
              width: double.infinity,
              height: 70,
              child: GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, Results.id);
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
