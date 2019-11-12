import 'package:amzur_todo_example/screens/main_screen.dart';
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
        primarySwatch: Colors.blue,
      ),
      home: MainScreen('Flutter Demo Home Page'),
    );
  }
}


