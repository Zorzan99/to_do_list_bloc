import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/models/task.dart';
import 'package:to_do_list_bloc/pages/home/home_cubit.dart';
import 'package:to_do_list_bloc/pages/home/home_state.dart';
import 'package:to_do_list_bloc/pages/home/widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeCubit>().getTasks(_auth.currentUser!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    final titleEC = TextEditingController();
    final descriptionEC = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Tarefas'),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is EditHome) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Tarefa atualizada com sucesso'),
                  ],
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingHome) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedHome) {
            if (state.tasks.isEmpty) {
              return const Center(
                child: Text('Lista de tarefas vazia'),
              );
            } else {
              return TodoList(tasks: state.tasks);
            }
          } else if (state is FailureHome) {
            return Center(
              child: Text('Erro: ${state.message}'),
            );
          } else if (state is DeleteHome && state.taskAtt.isEmpty) {
            return const Center(
              child: Text('Lista de tarefas vazia'),
            );
          } else if (state is DeleteHome) {
            return TodoList(tasks: state.taskAtt);
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Sair'),
                  ),
                  TextButton(
                    onPressed: () async {
                      String userId = _auth.currentUser!.uid;
                      final nav = Navigator.of(context);
                      final Task task = Task(
                        title: titleEC.text,
                        description: descriptionEC.text,
                        id: _auth.currentUser!.uid,
                      );
                      await cubit.addTask(userId, task);
                      cubit.getTasks(userId);
                      titleEC.clear();
                      descriptionEC.clear();
                      nav.pop();
                    },
                    child: const Text('Adicionar'),
                  ),
                ],
                title: const Text('Adicionar uma tarefa'),
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
              );
            },
          );
        },
        label: const Text('Adicionar Tarefa'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
