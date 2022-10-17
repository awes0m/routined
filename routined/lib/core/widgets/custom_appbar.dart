import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({
  required String titleText,
  Color appBarColor = Colors.black,
}) =>
    AppBar(
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(titleText,
            style: TextStyle(
              color: appBarColor,
              fontSize: 24,
            )),
      ),
      backgroundColor: Colors.white,
    );
