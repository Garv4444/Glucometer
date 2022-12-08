import 'package:flutter/material.dart';

const kPrimaryColour = Color(0xff212121);
const kSecondaryColour = Color(0xff0D7377);
const kFastSecondaryColour = Color(0xff5c0119);
const Color kLightColour = Color(0xff323232);
const Color kMidColour = Color(0xff252525);
const kTitleStyle = TextStyle(
  color: Color(0xFFFFFFFF),
  fontSize: 20,
);
var kButtonStyle = TextButtonThemeData(
  style: ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(const Color(0xff0D7377)),
    foregroundColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
    fixedSize: MaterialStateProperty.all(const Size(300, 60)),
    elevation: MaterialStateProperty.all(5.0),
  ),
);
