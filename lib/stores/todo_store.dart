

import 'package:amzur_todo_example/models/todo.dart';
import 'package:mobx/mobx.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

//flutter packages pub run build_runner clean
//flutter packages pub run build_runner build

abstract class _TodoStore with Store {

  // QUESTION:
  // Can we use
     //@observable
     //List<Todo> todos = [];
  // What is the difference between the code above and ObservableList?
  ObservableList<Todo> todos = ObservableList();

  @computed
  int get todosDone => todos.where((todo){
    return todo.isDone;
  }).length;

  @computed
  double get completionPercentage {
    if(todos.isNotEmpty) {
      return (todosDone / todos.length * 100).roundToDouble().roundToDouble();
    } else {
      return 100.0;
    }
  }

  @action
  void addTodo(){
    todos.add(Todo.placeholder(taskNumber: todos.length));
  }

  @action
  void removeTodo(Todo todo){
    todos.remove(todo);
  }

  @action
  void toggleTaskStatus(int index, bool isDone){
    Todo oldTodo = todos[index];
    todos[index] = oldTodo.copy(isDone: isDone);
  }

}