// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:routined/core/common/colors.dart';
import 'package:routined/core/common/text_styles.dart';
import 'package:routined/core/common/utils.dart';
import 'package:routined/core/widgets/custom_button.dart';

class TodoDialogBox extends StatelessWidget {
  final TextEditingController textController;
  final TextEditingController dateInput;
  final TextEditingController descriptionController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const TodoDialogBox({
    Key? key,
    required this.textController,
    required this.dateInput,
    required this.descriptionController,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: toDoColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(20, 30),
              bottomRight: Radius.circular(20))),
      content: SizedBox(
        height: ScrnSizer.screenHeight() * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Task name field
            SizedBox(
              height: ScrnSizer.screenHeight() * 0.2,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //TaskName field
                    TextField(
                      maxLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                      controller: textController,
                      decoration: InputDecoration(
                          label: Text(
                            'Task',
                            style: AppTextStyle.hintTextStyle(color: toDoText),
                          ),
                          border: const OutlineInputBorder(),
                          hintText: "Add Task Name"),
                    ),
                    //Gap
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 2,
                      textCapitalization: TextCapitalization.sentences,
                      controller: descriptionController,
                      decoration: InputDecoration(
                          label: Text(
                            'Description (Optional)',
                            style: AppTextStyle.hintTextStyle(color: toDoText),
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
                    color: toDoAlternate,
                    textColor: toDoColor,
                  ),
                  CustomButton(
                    text: "Cancel",
                    onPressed: onCancel,
                    color: toDoAlternate,
                    textColor: toDoColor,
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
