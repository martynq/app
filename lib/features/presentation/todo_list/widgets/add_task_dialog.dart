import 'package:flutter/material.dart';
import 'package:to_do_app_m/common/strings.dart';

Future<void> showAddTaskDialog({
  required BuildContext context,
  required Function(String) onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (_) => AddTodoItem(
      onConfirm: onConfirm,
    ),
  );
}

class AddTodoItem extends StatefulWidget {
  const AddTodoItem({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  final Function(String) onConfirm;

  @override
  State<AddTodoItem> createState() => _AddTodoItemState();
}

class _AddTodoItemState extends State<AddTodoItem> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController itemTitleController = TextEditingController();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: TodoStrings.taskDescTitle,
              ),
              onChanged: (value) {
                itemTitleController.text = value;
              },
            ),
            SizedBox(
              child: TextButton(
                onPressed: () {
                  widget.onConfirm(itemTitleController.text);
                  Navigator.of(context).pop();
                },
                child: const Text(TodoStrings.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}
