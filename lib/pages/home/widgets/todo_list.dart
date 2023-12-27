import 'package:flutter/widgets.dart';
import 'package:to_do_list_bloc/models/task.dart';
import 'package:to_do_list_bloc/pages/home/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Task> tasks;

  const TodoList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TodoItem(
          title: tasks[index].title,
          subtitle: tasks[index].description,
        );
      },
    );
  }
}
