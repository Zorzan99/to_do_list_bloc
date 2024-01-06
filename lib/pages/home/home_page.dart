import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/pages/home/home_cubit.dart';
import 'package:to_do_list_bloc/pages/home/home_state.dart';
import 'package:to_do_list_bloc/pages/home/widgets/float_button_home.dart';
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
    return Scaffold(
      backgroundColor: const Color(0XFF73AEF5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Tarefas'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Olá ${_auth.currentUser!.displayName}, seja bem-vindo ao To-Do List. Analise suas tarefas!',
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            BlocConsumer<HomeCubit, HomeState>(
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
                } else if (state is DeleteHome) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Tarefa excluída com sucesso'),
                        ],
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadingHome) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is LoadedHome) {
                  if (state.tasks.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'Lista de tarefas vazia',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  } else {
                    return TodoList(tasks: state.tasks);
                  }
                } else if (state is FailureHome) {
                  return Center(
                    child: Text('Erro: ${state.message}'),
                  );
                } else if (state is DeleteHome && state.taskAtt.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'Lista de tarefas vazia',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else if (state is DeleteHome) {
                  return TodoList(tasks: state.taskAtt);
                } else if (state is AddHome) {
                  return TodoList(tasks: state.tasks);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatButtonHome(),
    );
  }
}
