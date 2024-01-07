import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/models/task.dart';
import 'package:to_do_list_bloc/pages/home/home_cubit.dart';
import 'package:to_do_list_bloc/pages/home/widgets/home_form_fiel.dart';
import 'package:to_do_list_bloc/pages/home/widgets/todo_item.dart';
import 'package:validatorless/validatorless.dart';

class TodoList extends StatelessWidget {
  final List<Task> tasks;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TodoList({Key? key, required this.tasks}) : super(key: key);

  final _descriptionEC = TextEditingController();
  final _titleEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    final user = _auth.currentUser;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TodoItem(
          onDelete: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(25),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Excluir tarefa?'),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();

                                cubit.deleteTask(
                                    _auth.currentUser!.uid, tasks[index]);
                              },
                              child: const Text(
                                'Excluir',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          },
          title: tasks[index].title,
          subtitle: tasks[index].description,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Alterar descrição'),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HomeFormFiel(
                          controller: _titleEC,
                          validator:
                              Validatorless.required("Titulo necessário"),
                          title: 'Titulo',
                        ),
                        const SizedBox(height: 20),
                        HomeFormFiel(
                          controller: _descriptionEC,
                          validator:
                              Validatorless.required("Descrição necessária"),
                          title: 'Descrição',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                final valid =
                                    _formKey.currentState?.validate() ?? false;
                                if (valid) {
                                  String userId = user!.uid;
                                  final nav = Navigator.pop(context);
                                  final Task task = Task(
                                    title: _titleEC.text,
                                    description: _descriptionEC.text,
                                    id: tasks[index].id,
                                  );
                                  await cubit.editTask(userId, task);
                                  cubit.getTasks(userId);
                                  _titleEC.clear();
                                  _descriptionEC.clear();
                                  nav;
                                }
                              },
                              child: const Text('Alterar'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
