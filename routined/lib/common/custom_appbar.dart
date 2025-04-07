import 'package:flutter/material.dart';
import 'package:routined/core/colors.dart';

PreferredSizeWidget customAppBar({
  required GlobalKey<ScaffoldState> key,
  required String titleText,
  Color appBarColor = kBackGroundColor,
  Color titleTextColor = kCaptionColor,
}) =>
    AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: kPrimaryColor,
        ),
        onPressed: () {
          key.currentState!.openDrawer();
        },
      ),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(titleText,
            style: TextStyle(
              color: titleTextColor,
              fontSize: 24,
            )),
      ),
      backgroundColor: appBarColor,
    );
