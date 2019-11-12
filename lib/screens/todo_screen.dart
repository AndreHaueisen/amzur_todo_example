import 'package:amzur_todo_example/main.dart';
import 'package:amzur_todo_example/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Completion rate ${todoStore.completionPercentage}%"), //TODO Why is the title not changing?
      ),
      body: Observer(
        builder: (_) {
          return todoStore.todos.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  itemCount: todoStore.todos.length,
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 1,
                      color: Colors.grey[300],
                    );
                  },
                  itemBuilder: (context, index) {
                    return _buildTodoItem(index);
                  })
              : Center(
                  child: Text(
                    "Click the button to add something to do",
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoStore.addTodo();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _buildTodoItem(int index) {
    Todo todo = todoStore.todos[index];

    return Dismissible(
      key: UniqueKey(),
      // Why do need a key here? What are the different types of keys?
      onDismissed: (_) {
        todoStore.removeTodo(todo);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(todo.task),
            ),
            Checkbox(
              value: todo.isDone,
              onChanged: (bool isDone) {
                todoStore.toggleTaskStatus(index, isDone);
              },
            ),
          ],
        ),
      ),
    );
  }
}
