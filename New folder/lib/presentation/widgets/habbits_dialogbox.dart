// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:routined/core/common/colors.dart';

import 'package:routined/core/common/utils.dart';
import 'package:routined/core/widgets/custom_button.dart';

import '../../core/common/app_test_style.dart';

class HabbitDialogBox extends StatefulWidget {
  final TextEditingController habbitName;
  final TextEditingController hourPicker;
  final TextEditingController minutePicker;
  final TextEditingController secondsPicker;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const HabbitDialogBox({
    super.key,
    required this.habbitName,
    required this.onSave,
    required this.onCancel,
    required this.hourPicker,
    required this.minutePicker,
    required this.secondsPicker,
  });

  @override
  State<HabbitDialogBox> createState() => _HabbitDialogBoxState();
}

class _HabbitDialogBoxState extends State<HabbitDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBackGroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(20, 30),
              bottomRight: Radius.circular(20),
              topRight: Radius.elliptical(20, 30))),
      content: SizedBox(
        height: ScrnSizer.screenHeight() * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Task name field
            SizedBox(
              height: ScrnSizer.screenHeight() * 0.25,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    //TaskName field
                    TextField(
                      maxLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                      controller: widget.habbitName,
                      decoration: InputDecoration(
                          label: AppTextStyle.hintText('Task', kPrimaryColor),
                          border: const OutlineInputBorder(),
                          hintText: "Add Task Name"),
                    ),
                    //Gap
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          maxLines: 1,
                          textCapitalization: TextCapitalization.characters,
                          controller: widget.hourPicker,
                          decoration: InputDecoration(
                              label:
                                  AppTextStyle.hintText('Hour', kPrimaryColor),
                              border: const OutlineInputBorder(),
                              hintText: "HH"),
                        ),
                        TextField(
                          maxLines: 1,
                          textCapitalization: TextCapitalization.characters,
                          controller: widget.hourPicker,
                          decoration: InputDecoration(
                              label: AppTextStyle.hintText(
                                  'Minute', kPrimaryColor),
                              border: const OutlineInputBorder(),
                              hintText: "MM"),
                        ),
                        TextField(
                          maxLines: 1,
                          textCapitalization: TextCapitalization.characters,
                          controller: widget.hourPicker,
                          decoration: InputDecoration(
                              label:
                                  AppTextStyle.hintText('Sec', kPrimaryColor),
                              border: const OutlineInputBorder(),
                              hintText: "SS"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,

                /// Action Buttons
                children: [
                  CustomButton(
                    text: "Save",
                    onPressed: widget.onSave,
                    color: kBackGroundColor,
                    textColor: kCaptionColor,
                  ),
                  CustomButton(
                    text: "Cancel",
                    onPressed: widget.onCancel,
                    color: kBackGroundColor,
                    textColor: kCaptionColor,
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
