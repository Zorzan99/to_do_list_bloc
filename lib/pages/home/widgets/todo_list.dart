import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/models/task.dart';
import 'package:to_do_list_bloc/pages/home/home_cubit.dart';
import 'package:to_do_list_bloc/pages/home/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Task> tasks;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TodoList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    final user = _auth.currentUser;

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TodoItem(
          onLongPress: () {
            if (user != null) {
              cubit.deleteTask(user.uid, tasks[index]);
            }
          },
          title: tasks[index].title,
          subtitle: tasks[index].description,
        );
      },
    );
  }
}
