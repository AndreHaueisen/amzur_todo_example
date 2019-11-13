// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoStore on _TodoStore, Store {
  Computed<int> _$todosDoneComputed;

  @override
  int get todosDone =>
      (_$todosDoneComputed ??= Computed<int>(() => super.todosDone)).value;
  Computed<double> _$completionPercentageComputed;

  @override
  double get completionPercentage => (_$completionPercentageComputed ??=
          Computed<double>(() => super.completionPercentage))
      .value;

  final _$_TodoStoreActionController = ActionController(name: '_TodoStore');

  @override
  void addTodo() {
    final _$actionInfo = _$_TodoStoreActionController.startAction();
    try {
      return super.addTodo();
    } finally {
      _$_TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTodo(Todo todo) {
    final _$actionInfo = _$_TodoStoreActionController.startAction();
    try {
      return super.removeTodo(todo);
    } finally {
      _$_TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleTaskStatus(int index, bool isDone) {
    final _$actionInfo = _$_TodoStoreActionController.startAction();
    try {
      return super.toggleTaskStatus(index, isDone);
    } finally {
      _$_TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTaskText(int index, String nextTask) {
    final _$actionInfo = _$_TodoStoreActionController.startAction();
    try {
      return super.updateTaskText(index, nextTask);
    } finally {
      _$_TodoStoreActionController.endAction(_$actionInfo);
    }
  }
}
