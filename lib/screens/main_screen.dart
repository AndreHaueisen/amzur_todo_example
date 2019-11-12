import 'package:amzur_todo_example/routes.dart';
import 'package:amzur_todo_example/screens/todo_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {

  final String title;
  MainScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Observe the page transition. Check the file "routes.dart" to play with them',
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text("TODO SCREEN"),
                  onPressed: (){
                    Navigator.of(context).push(
                      FadeInRoute(
                        page: TodoScreen(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
