import 'package:amzur_todo_example/main.dart';
import 'package:amzur_todo_example/models/todo.dart';
import 'package:flutter/material.dart';

class EditTodoDialog extends StatelessWidget {
  final int todoIndex;
  final Todo editingTodo;

  TextEditingController _controller;

  EditTodoDialog(this.todoIndex) : editingTodo = todoStore.todos[todoIndex] {
    _controller = TextEditingController(text: editingTodo.task);
    _controller.value = TextEditingValue(  //TODO this fixes the cursor position when the user clicks it. Try removing it to see what happens
      text: editingTodo.task,
      selection: TextSelection.collapsed(
        offset: editingTodo.task.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: StatefulBuilder(builder: (_, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Edit Task",
                style: TextStyle(
                  color: textColorPrimaryDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextFormField(
                controller: _controller,
                cursorColor: accentColor,
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 8, bottom: 12),
              child: Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: _controller.text.isNotEmpty
                      ? () {
                          todoStore.updateTaskText(
                              todoIndex, _controller.value.text);
                          Navigator.of(context).pop();
                        }
                      : null,
                  textColor: textColorPrimary,
                  disabledTextColor: textColorPrimaryLight,
                  child: Text("SAVE"),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
