// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:routined/core/colors.dart';

Widget alarmItem(hour, enabled) {
  return Padding(
    padding: const EdgeInsets.all(7),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hour,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    )),
                Row(
                  children: [
                    weekdayShort('Sun'),
                    weekdayShort('Mon'),
                    weekdayShort('Tue'),
                    weekdayShort('Wed'),
                    weekdayShort('Thu'),
                    weekdayShort('Fri'),
                    weekdayShort('Sat'),
                  ],
                )
              ],
            ),
            Switch.adaptive(
              value: enabled,
              onChanged: (bool val) {
                print(val);
              },
              activeColor: const Color(0xff65d1ba),
            )
          ],
        )
      ],
    ),
  );
}

Widget weekdayShort(String text) => Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        text,
        style: const TextStyle(
          color: kSecondaryBackgroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
