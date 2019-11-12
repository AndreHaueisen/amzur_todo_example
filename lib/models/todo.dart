
import 'package:flutter/foundation.dart';

class Todo {

  final String task;
  final bool isDone;

  Todo({@required this.task, @required this.isDone});

  factory Todo.placeholder({@required int taskNumber}){
    return Todo(task: "This is task number $taskNumber",
    isDone: false);
  }

  Todo copy({String task, bool isDone}){
    return Todo(
      task: task ?? this.task,
      isDone: isDone ?? this.isDone
    );
  }
}