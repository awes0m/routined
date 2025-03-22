// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:routined/core/common/colors.dart';

import 'package:routined/core/common/utils.dart';
import 'package:routined/core/widgets/custom_button.dart';

import '../../core/common/app_test_style.dart';

class TasksDialogBox extends StatelessWidget {
  final TextEditingController textController;
  final TextEditingController dateInput;
  final TextEditingController descriptionController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const TasksDialogBox({
    super.key,
    required this.textController,
    required this.dateInput,
    required this.descriptionController,
    required this.onSave,
    required this.onCancel,
  });

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
                      controller: textController,
                      decoration: InputDecoration(
                          label: AppTextStyle.hintText('Task', kPrimaryColor),
                          border: const OutlineInputBorder(),
                          hintText: "Add Task Name"),
                    ),
                    //Gap
                    const SizedBox(height: 20),
                    TextField(
                      maxLines: 2,
                      textCapitalization: TextCapitalization.sentences,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          label: Text(
                            'Description (Optional)',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          border: OutlineInputBorder(),
                          hintText: " Add Task Description"),
                    ),
                  ],
                ),
              ),
            ),

            // const SizedBox(
            //   height: 20,
            // ),
            // //Datepicker
            // TextField(
            //   controller: dateInput,
            //   //editing controller of this TextField
            //   decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       icon: Icon(Icons.calendar_today), //icon of text field
            //       labelText: "Due Date" //label text of field
            //       ),
            //   readOnly: true,
            //   //set it true, so that user will not able to edit text
            //   onTap: () async {
            //     pickedDate = (await showDatePicker(
            //         context: context,
            //         initialDate: DateTime.now(),
            //         firstDate: DateTime(1950),
            //         //DateTime.now() - not to allow to choose before today.
            //         lastDate: DateTime(2100)))!;
            //   },
            // ),

            // SizedBox(
            //   height: ScrnSizer.screenHeight() * 0.01,
            // ),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,

                /// Action Buttons
                children: [
                  CustomButton(
                    text: "Save",
                    onPressed: onSave,
                    color: kBackGroundColor,
                    textColor: kCaptionColor,
                  ),
                  CustomButton(
                    text: "Cancel",
                    onPressed: onCancel,
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
