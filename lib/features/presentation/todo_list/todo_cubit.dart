import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_m/features/presentation/todo_list/todo_state.dart';
import 'package:to_do_app_m/model/todo.dart';
import 'package:to_do_app_m/service/service.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial()) {
    fetchMeals();
  }

  Future<void> fetchMeals() async {
    try {
      final todoList = await DataService().getData();

      emit(
        TodoLoaded([todoList], 0),
      );
    } catch (_) {
      emit(
        TodoFailure(),
      );
    }
  }

  void changeIsDone(
    List<List<Todo>> list,
    int curIndex,
    int index,
  ) {
    final todo = list[curIndex][index];
    final todoItem = todo.copyWith(completed: !todo.completed);
    list[curIndex][index] = todoItem;
    emit(TodoLoaded(list, curIndex));
  }

  void deleteItem(
    List<List<Todo>> list,
    int curIndex,
    int index,
  ) {
    list[curIndex].removeAt(index);
    emit(
      TodoLoaded(list, curIndex),
    );
  }

  void moveItemToEnd(
    List<List<Todo>> list,
    int curIndex,
    int index,
  ) {
    final todoItem = list[curIndex].removeAt(index);
    list[curIndex].add(todoItem);
    emit(
      TodoLoaded(list, curIndex),
    );
  }

  void addItem(
    List<List<Todo>> list,
    int curIndex,
    String value,
  ) {
    final todoItem = Todo(
      id: list[curIndex].length,
      title: value,
      completed: false,
    );
    list[curIndex].insert(0, todoItem);
    emit(
      TodoLoaded(list, curIndex),
    );
  }

  void moveItemToStart(
    List<List<Todo>> list,
    int curIndex,
    int index,
  ) {
    Todo item = list[curIndex].removeAt(index);
    list[curIndex].insert(0, item);
    emit(
      TodoLoaded(list, curIndex),
    );
  }

  void createNewList(
    List<List<Todo>> list,
    int idx,
  ) {
    final List<Todo> newItem = [];
    list.add(newItem);
    emit(
      TodoLoaded(list, idx),
    );
  }

  void changeCurrentIndex(
    List<List<Todo>> list,
    int index,
  ) {
    emit(
      TodoLoaded(list, index),
    );
  }
}
