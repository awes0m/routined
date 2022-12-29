import 'package:flutter/material.dart';
import 'package:routined/core/common/colors.dart';

class AppTextStyle {
  static Text hintText(text, [color = kCaptionColor]) => Text(text,
      style: const TextStyle(
          color: kCaptionColor, fontSize: 18, fontStyle: FontStyle.italic));
  static Text smallText(text, [color = kCaptionColor]) =>
      Text(text, style: const TextStyle(color: kCaptionColor, fontSize: 18));

  static Text smallBoldText(text, [color = kCaptionColor]) => Text(text,
      style: const TextStyle(
          color: kCaptionColor, fontSize: 18, fontWeight: FontWeight.bold));
  static Text mediumText(text, [color = kCaptionColor]) =>
      Text(text, style: const TextStyle(color: kCaptionColor, fontSize: 25));
  static Text mediumBoldText(text, [color = kCaptionColor]) => Text(text,
      style: const TextStyle(
          color: kCaptionColor, fontSize: 25, fontWeight: FontWeight.bold));
  static Text largeText(text, [color = kCaptionColor]) =>
      Text(text, style: const TextStyle(color: kCaptionColor, fontSize: 32));
  static Text largeBoldText(text, [color = kCaptionColor]) => Text(text,
      style: const TextStyle(
          color: kCaptionColor, fontSize: 32, fontWeight: FontWeight.bold));

  static Text headingBoldText(text, [color = kCaptionColor]) => Text(text,
      style: const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
        color: kCaptionColor,
      ));
}
