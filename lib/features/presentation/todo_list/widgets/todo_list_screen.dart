import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_m/common/strings.dart';
import 'package:to_do_app_m/features/presentation/todo_list/todo_cubit.dart';
import 'package:to_do_app_m/features/presentation/todo_list/todo_state.dart';
import 'package:to_do_app_m/features/presentation/todo_list/widgets/add_task_dialog.dart';
import 'package:to_do_app_m/model/enum/pop_up_function_enum.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoCubit>(
      create: (context) => TodoCubit(),
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: BlocConsumer<TodoCubit, TodoState>(
          listener: (context, state) async {},
          builder: (context, state) {
            if (state is TodoInitial || state is TodoFailure) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TodoLoaded) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 80,
                    stretch: true,
                    title: const Text(TodoStrings.toDoList),
                    backgroundColor: Colors.indigo,
                    actions: [
                      PopupMenuButton(
                        icon: const Icon(Icons.add, color: Colors.grey),
                        onSelected: (value) {
                          if (value == PopUpFunction.addItem) {
                            showAddTaskDialog(
                                context: context,
                                onConfirm: (value) {
                                  BlocProvider.of<TodoCubit>(context).addItem(
                                    state.todoList ?? [],
                                    state.idx,
                                    value,
                                  );
                                });
                          }
                          if (value == PopUpFunction.newList) {
                            BlocProvider.of<TodoCubit>(context).createNewList(
                              state.todoList!,
                              state.idx + 1,
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          const PopupMenuItem(
                            value: PopUpFunction.addItem,
                            child: ListTile(
                              leading: Icon(Icons.add),
                              title: Text(TodoStrings.addItem),
                            ),
                          ),
                          const PopupMenuItem(
                            value: PopUpFunction.newList,
                            child: ListTile(
                              leading: Icon(Icons.create),
                              title: Text(TodoStrings.createNewList),
                            ),
                          ),
                          if (state.todoList!.length > 1)
                            ...state.todoList!
                                .map(
                                  (list) => PopupMenuItem(
                                    value: state.todoList!.indexOf(list),
                                    onTap: () =>
                                        BlocProvider.of<TodoCubit>(context)
                                            .changeCurrentIndex(
                                      state.todoList!,
                                      state.todoList!.indexOf(list),
                                    ),
                                    child: ListTile(
                                      leading: const Icon(Icons.list),
                                      title: Text(
                                        "${TodoStrings.list} ${state.todoList!.indexOf(list) + 1}",
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        ],
                      ),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final id = state.idx;
                        final todo = state.todoList![id][index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                todo.title.toUpperCase(),
                                style: const TextStyle(color: Colors.white60),
                              ),
                              trailing: PopupMenuButton(
                                icon: const Icon(Icons.menu_open,
                                    color: Colors.grey),
                                onSelected: (value) {
                                  if (value == PopUpFunction.moveDown) {
                                    BlocProvider.of<TodoCubit>(context)
                                        .moveItemToEnd(state.todoList ?? [],
                                            state.idx, index);
                                  }
                                  if (value == PopUpFunction.moveUp) {
                                    BlocProvider.of<TodoCubit>(context)
                                        .moveItemToStart(state.todoList ?? [],
                                            state.idx, index);
                                  } else if (value == PopUpFunction.delete) {
                                    BlocProvider.of<TodoCubit>(context)
                                        .deleteItem(state.todoList ?? [],
                                            state.idx, index);
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry>[
                                  const PopupMenuItem(
                                    value: PopUpFunction.moveDown,
                                    child: ListTile(
                                      leading: Icon(Icons.move_down),
                                      title: Text(TodoStrings.moveBottom),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: PopUpFunction.moveUp,
                                    child: ListTile(
                                      leading: Icon(Icons.move_up),
                                      title: Text(TodoStrings.moveTop),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: PopUpFunction.delete,
                                    child: ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text(TodoStrings.delete),
                                    ),
                                  ),
                                ],
                              ),
                              leading: Checkbox(
                                value: todo.completed,
                                activeColor: Colors.white70,
                                checkColor: Colors.black54,
                                onChanged: (_) {
                                  BlocProvider.of<TodoCubit>(context)
                                      .changeIsDone(state.todoList ?? [],
                                          state.idx, index);
                                },
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                          ],
                        );
                      },
                      childCount: state.todoList![state.idx].length,
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
