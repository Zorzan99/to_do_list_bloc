import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list_bloc/models/task.dart';

import './home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Task> addTask(String userId, Task task) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      final DocumentReference documentReference = await firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add(task.toMap());

      final Task updatedTask = task.copyWith(id: documentReference.id);

      return updatedTask;
    } catch (e, s) {
      log('Erro ao salvar tarefa', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<Task>> getTasks(String userId) async {
    try {
      final QuerySnapshot taskSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .get();

      return taskSnapshot.docs
          .map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>)
              .copyWith(id: doc.id))
          .toList();
    } catch (e, s) {
      log("Error getTask", error: e, stackTrace: s);
      throw Exception("Error");
    }
  }

  @override
  Future<void> deleteTask(String userId, Task task) async {
    print('Deleting task from repository: $task');
    final DocumentReference taskReference = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(task
            .id); // O campo id já é do tipo String?, então não é necessário chamar .toString()

    try {
      await taskReference.delete();
      print('Task deleted from repository successfully');
    } catch (e, s) {
      log('Erro ao deletar tarefa', error: e, stackTrace: s);
      rethrow;
    }
  }
}
