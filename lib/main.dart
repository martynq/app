import 'package:flutter/material.dart';
import 'package:to_do_app_m/features/presentation/todo_list/widgets/todo_list_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        unselectedWidgetColor: Colors.grey,
      ),
      home: const TodoScreen(),
    );
  }
}
