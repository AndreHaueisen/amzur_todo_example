import 'package:amzur_todo_example/constants.dart';
import 'package:amzur_todo_example/screens/login_screen.dart';
import 'package:amzur_todo_example/screens/todo_screen.dart';
import 'package:amzur_todo_example/stores/todo_store.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final TodoStore todoStore = TodoStore();

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: accentColor,
        canvasColor: Colors.white,
        primaryColor: primaryColor,
      ),
      home: LoginScreen(),
      routes: {
        Constants.ROUTE_TODO: (context) => TodoScreen(),
      },
    );
  }
}

const Color accentColor = const Color(0xFFFF6F20);
const Color primaryColor = const Color(0xFF5E5D75);

const Color textColorPrimaryLight = const Color(0xFFA9AEB3);
const Color textColorPrimary = const Color(0xFF5E5D75);
const Color textColorPrimaryDark = const Color(0xFF203149);