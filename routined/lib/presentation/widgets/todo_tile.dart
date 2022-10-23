// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:routined/core/common/colors.dart';
import 'package:routined/core/common/utils.dart';

class TodoTile extends StatefulWidget {
  final String title;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deletefunction;
  final String description;
  const TodoTile({
    Key? key,
    required this.title,
    required this.taskCompleted,
    required this.onChanged,
    required this.deletefunction,
    required this.description,
  }) : super(key: key);

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool descriptionOpener = false;

  ///False by default

  void toggleDescription() {
    setState(() {
      descriptionOpener = !descriptionOpener;
    });
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
              color: toDoColor,
              shadowColor: toDoAlternate,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: ListTile(
                //CheckBox for taskCompleted Boolean
                leading: Checkbox(
                  value: widget.taskCompleted,
                  onChanged: widget.onChanged,
                  activeColor: secondaryBackgroundColor,
                ),
                //Task tittle
                title: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: toDoText,
                      decoration: widget.taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                //Details opener- if Description availiable
                //TODO: check if description is available
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
                    height: ScrnSizer.screenHeight() * 0.2,
                    width: ScrnSizer.screenWidth() * 0.8,
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
