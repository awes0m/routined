// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:routined/core/common/colors.dart';

import '../common/app_test_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color = kPrimaryColor,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      child: AppTextStyle.smallBoldText(text, textColor),
    );
  }
}
