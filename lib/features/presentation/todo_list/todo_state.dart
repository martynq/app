import 'package:to_do_app_m/model/todo.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoFailure extends TodoState {}

class TodoLoaded extends TodoState {
  final List<List<Todo>>? todoList;
  final int idx;

  TodoLoaded(
    this.todoList,
    this.idx,
  );
}
