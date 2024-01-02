import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/pages/home/home_cubit.dart';
import 'package:to_do_list_bloc/pages/home/home_state.dart';
import 'package:to_do_list_bloc/pages/home/widgets/float_button_home.dart';
import 'package:to_do_list_bloc/pages/home/widgets/home_drawer.dart';
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
      drawer: HomeDrawer(
        title: 'Bem-vindo, ${_auth.currentUser!.displayName}',
        perfilTitle: 'Meu perfil',
        exitTitle: "Sair",
        onTapPerfil: () {},
        onPressedExit: () {},
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          } else if (state is DeleteHome) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Tarefa excluida com sucesso'),
                  ],
                ),
                backgroundColor: Colors.redAccent,
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
          } else if (state is AddHome) {
            return TodoList(tasks: state.tasks);
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: const FloatButtonHome(),
    );
  }
}
