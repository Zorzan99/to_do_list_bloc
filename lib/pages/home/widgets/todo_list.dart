import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    final titleEC = TextEditingController();
    final descriptionEC = TextEditingController();

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
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Adicionar Valor'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleEC,
                      ),
                      TextFormField(
                        controller: descriptionEC,
                      ),
                    ],
                  ),
                  actions: [
                    // Botão para cancelar o popup
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        String userId = user!.uid;
                        final nav = Navigator.pop(context);
                        final Task task = Task(
                          title: titleEC.text,
                          description: descriptionEC.text,
                          id: tasks[index].id,
                        );
                        await cubit.editTask(userId, task);
                        cubit.getTasks(userId);
                        titleEC.clear();
                        descriptionEC.clear();
                        nav;
                      },
                      child: const Text('Adicionar'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
