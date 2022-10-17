// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:routined/core/common/colors.dart';

class TodoTile extends StatelessWidget {
  final String title;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deletefunction;
  const TodoTile({
    Key? key,
    required this.title,
    required this.taskCompleted,
    required this.onChanged,
    required this.deletefunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        enabled: true,
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(25),
                onPressed: deletefunction)
          ],
        ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          child: ListTile(
            leading: Checkbox(
              value: taskCompleted,
              onChanged: onChanged,
              activeColor: secondaryBackgroundColor,
            ),
            title: Text(
              title,
              style: TextStyle(
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ),
        ),
      ),
    );
  }
}
