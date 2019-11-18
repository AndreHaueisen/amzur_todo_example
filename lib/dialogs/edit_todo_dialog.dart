import 'package:amzur_todo_example/main.dart';
import 'package:flutter/material.dart';

class EditTodoDialog extends StatelessWidget {

  // I'm leaving this custom dialog here for now
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
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
                  //controller: _controller,
                  cursorColor: accentColor,
                  onChanged: (text) {
                    //setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, right: 8, bottom: 12),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){},
                    textColor: textColorPrimary,
                    disabledTextColor: textColorPrimaryLight,
                    child: Text("SAVE"),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
