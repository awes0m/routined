import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(titleText) => AppBar(
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(titleText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
            )),
      ),
      backgroundColor: Colors.white,
    );
