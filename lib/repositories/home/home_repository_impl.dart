import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list_bloc/models/task.dart';

import './home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Task> addTask(String userId, Task task) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add(task.toMap());

      final Task updatedTask =
          task.copyWith(title: task.title, description: task.description);

      return updatedTask;
    } catch (e, s) {
      log('Erro ao salvar tarefa', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<Task>> getTasks(String userId) async {
    try {
      var listTask = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .get();

      final listFavorites = <Task>[];
      for (var movie in listTask.docs) {
        listFavorites.add(Task.fromMap(movie.data()));
      }
      return listFavorites;
    } catch (e, s) {
      log("Error getTask", error: e, stackTrace: s);
      throw Exception("Error");
    }
  }
}
