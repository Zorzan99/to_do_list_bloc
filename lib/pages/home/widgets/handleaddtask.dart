import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_bloc/models/task.dart';
import 'package:to_do_list_bloc/pages/home/home_cubit.dart';

Future<void> handleAddTask(BuildContext context, HomeCubit cubit) async {
  final titleEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final nav = Navigator.pop(context);
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final task = Task(
    title: titleEC.text,
    description: descriptionEC.text,
  );
  await cubit.addTask(userId, task);
  cubit.getTasks(userId); // Atualiza a lista de tarefas
  titleEC.clear();
  descriptionEC.clear();
  nav;
}
