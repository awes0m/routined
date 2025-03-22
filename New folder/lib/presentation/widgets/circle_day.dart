import 'package:flutter/material.dart';
import 'package:routined/core/common/app_test_style.dart';

Widget circleDay(day, BuildContext context, enabled) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
        color: (enabled)
            ? Theme.of(context).colorScheme.secondary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(100)),
    child: Padding(
      padding: const EdgeInsets.all(1),
      child: Center(
        child: AppTextStyle.smallBoldText(day),
      ),
    ),
  );
}
