import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const bool kIsWeb = identical(0, 0.0);

/// This class is used to get the screen height and width
/// Functions- screenHeight() and screenWidth()

/// This function is used to show a snackbar with a message
/// Parameters- [context], [message]
showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 8,
      content: Text(message),
      duration: const Duration(seconds: 5),
    ),
  );
}

///This function is used to validate the email string
///Parameters- [email] String
bool isValidEmail(String email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);

Future<bool> requestPermission(Permission permission) async {
  var status = await permission.isGranted;
  if (status) {
    return true;
  } else {
    var status = await permission.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}


String getNameFromEmail(String email) {
  return email.split('@')[0];
}


// Random String Generator
const String _chars =
    'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(
      Iterable<int>.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))),
    );

String? extractImageId(String inputString) {
  final RegExp regex = RegExp(r'/files/([^/]+)/');
  final RegExpMatch? match = regex.firstMatch(inputString);

  if (match != null && match.groupCount >= 1) {
    return match.group(1);
  }

  return null; // Return null if no match found
}
