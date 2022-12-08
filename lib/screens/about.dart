import 'package:flutter/material.dart';
import 'package:glucometer/constants.dart';

class About extends StatefulWidget {
  static const String id = "about";
  const About({Key? key}) : super(key: key);
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'SUCRE       ',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'A Bluetooth Glucometer companion app made in flutter.',
              style: kTitleStyle.copyWith(fontSize: 27),
              textAlign: TextAlign.center,
            ),
            SizedBox.fromSize(
              size: const Size(0, 50),
            ),
            Text(
              'The app connects via BlueTooth with '
              'a glucometer to get the readings and then display '
              'the results according to the mode selected.',
              style: kTitleStyle.copyWith(fontSize: 15),
              textAlign: TextAlign.justify,
            ),
            Expanded(
              child: SizedBox.fromSize(
                size: const Size(0, 200),
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Icon(
                    Icons.copyright,
                    size: 10,
                  ),
                ),
                Text(
                  '  2022 - 2023   GARV',
                  style: kTitleStyle.copyWith(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
