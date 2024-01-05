import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/models/task.dart';
import 'package:to_do_list_bloc/pages/home/home_cubit.dart';
import 'package:to_do_list_bloc/pages/home/widgets/home_form_fiel.dart';
import 'package:validatorless/validatorless.dart';

class FloatButtonHome extends StatefulWidget {
  const FloatButtonHome({super.key});

  @override
  State<FloatButtonHome> createState() => _FloatButtonHomeState();
}

class _FloatButtonHomeState extends State<FloatButtonHome> {
  final formKey = GlobalKey<FormState>();
  final titleEC = TextEditingController();
  final descriptionEC = TextEditingController();

  @override
  void dispose() {
    titleEC.dispose();
    descriptionEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final cubit = BlocProvider.of<HomeCubit>(context);
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Form(
              key: formKey,
              child: AlertDialog(
                title: const Text('Adicionar uma tarefa'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HomeFormFiel(
                      controller: titleEC,
                      validator: Validatorless.required("Titulo necessário"),
                      title: 'Titulo',
                    ),
                    const SizedBox(height: 20),
                    HomeFormFiel(
                      controller: descriptionEC,
                      validator: Validatorless.required("Descrição necessária"),
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
                                formKey.currentState?.validate() ?? false;
                            if (valid) {
                              String userId = auth.currentUser!.uid;
                              final nav = Navigator.of(context);
                              nav.pop();
                              final Task task = Task(
                                title: titleEC.text,
                                description: descriptionEC.text,
                                id: userId,
                              );
                              await cubit.addTask(userId, task);
                              titleEC.clear();
                              descriptionEC.clear();
                            }
                          },
                          child: const Text('Adicionar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      label: const Text('Adicionar Tarefa'),
      icon: const Icon(Icons.add),
    );
  }
}
