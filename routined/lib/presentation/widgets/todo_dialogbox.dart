import 'package:flutter/material.dart';
import 'package:routined/core/widgets/custom_button.dart';

class TodoDialogBox extends StatelessWidget {
  final TextEditingController textController;
  final TextEditingController dateInput;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const TodoDialogBox({
    Key? key,
    required this.textController,
    required this.dateInput,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 230,
        child: Column(
          children: [
            //Task name field
            TextField(
              maxLines: 2,
              textCapitalization: TextCapitalization.sentences,
              controller: textController,
              decoration: const InputDecoration(
                  label: Text('Task'),
                  border: OutlineInputBorder(),
                  hintText: "Add Task Description"),
            ),
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,

                /// Action Buttons
                children: [
                  CustomButton(text: "Save", onPressed: onSave),
                  CustomButton(text: "Cancel", onPressed: onCancel),
                ]),
          ],
        ),
      ),
    );
  }
}
