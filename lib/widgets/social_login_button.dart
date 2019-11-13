import 'package:amzur_todo_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SocialLoginButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final IconData iconData;

  SocialLoginButton(
      {@required this.onPressed, @required this.title, this.iconData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        constraints: BoxConstraints(maxWidth: 140),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          border: Border.all(
            color: Colors.grey[200],
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            iconData != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      iconData,
                      color: primaryColor.withOpacity(0.75),
                    ),
                  )
                : Container(),
            Text(
              title,
              style: TextStyle(
                color: textColorPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
