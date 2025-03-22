// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:routined/core/common/colors.dart';
import 'package:routined/core/common/utils.dart';

class TasksTile extends StatefulWidget {
  final String title;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deletefunction;
  final String description;
  const TasksTile({
    super.key,
    required this.title,
    required this.taskCompleted,
    required this.onChanged,
    required this.deletefunction,
    required this.description,
  });

  @override
  State<TasksTile> createState() => _TasksTileState();
}

class _TasksTileState extends State<TasksTile> {
  bool descriptionOpener = false;

  ///False by default

  void toggleDescription() {
    setState(() {
      descriptionOpener = !descriptionOpener;
    });
  }

  /// Gets the color of the CheckBox based on the current state of Task completion or mouse loaction
  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
      WidgetState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.green;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Slidable(
        enabled: true,
        // slide and show delete Button
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
                icon: Icons.delete,
                backgroundColor: Colors.red[300]!,
                borderRadius: BorderRadius.circular(25),
                onPressed: widget.deletefunction)
          ],
        ),
        child: Column(
          children: [
            //Main TodoTile
            Card(
              color: kBackGroundColor,
              shadowColor: kSecondaryBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: ListTile(
                //CheckBox for taskCompleted Boolean
                leading: Checkbox(
                  value: widget.taskCompleted,
                  onChanged: widget.onChanged,
                  activeColor: Colors.white,
                  fillColor: WidgetStateProperty.resolveWith(getColor),
                ),
                //Task tittle
                title: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kCaptionColor,
                      decoration: widget.taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationThickness: 5),
                ),
                //Details opener- if Description availiable
                trailing: widget.description.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.arrow_drop_down_circle),
                        onPressed: toggleDescription,
                      )
                    : null,
              ),
            ),

            // Description open
            (widget.description.isNotEmpty && descriptionOpener)
                ? Container(
                    width: ScrnSizer.screenWidth() * 0.8,
                    constraints: BoxConstraints(
                      maxHeight: ScrnSizer.screenHeight() * 0.2,
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.description,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
