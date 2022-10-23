// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:routined/core/common/colors.dart';
import 'package:routined/core/common/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color = buttonColor,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      child: Text(
        text,
        style: AppTextStyle.smallBold(color: textColor),
      ),
    );
  }
}
