import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:to_do_list_bloc/models/task.dart';
import 'package:to_do_list_bloc/pages/home/home_state.dart';
import 'package:to_do_list_bloc/repositories/home/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  HomeCubit(this._homeRepository) : super(EmptyHome());

  Future<void> addTask(String userId, Task task) async {
    emit(LoadingHome());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final updatedTask = await _homeRepository.addTask(userId, task);
      final tasks = await _homeRepository.getTasks(userId);
      emit(AddHome(updatedTask, tasks));
    } catch (e, s) {
      emit(FailureHome(message: 'Erro ao adicionar tarefa: $e, $s'));
    }
  }

  Future<void> getTasks(String userId) async {
    emit(LoadingHome());
    try {
      final tasks = await _homeRepository.getTasks(userId);
      emit(LoadedHome(tasks: tasks));
    } catch (e, s) {
      log('Erro getTasks:', error: e, stackTrace: s);
      emit(FailureHome(message: 'Erro ao obter tarefas'));
    }
  }

  Future<void> deleteTask(String userId, Task taskId) async {
    emit(LoadingHome());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _homeRepository.deleteTask(userId, taskId);
      final tasks = await _homeRepository.getTasks(userId);
      emit(DeleteHome(taskId, tasks));
    } catch (e, s) {
      log('Erro deleteTask:', error: e, stackTrace: s);

      emit(FailureHome(message: 'Erro ao deletar tarefa:'));
    }
  }

  Future<void> editTask(String userId, Task editedTask) async {
    emit(LoadingHome());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _homeRepository.editTask(userId, editedTask);
      final tasks = await _homeRepository.getTasks(userId);
      emit(EditHome(editedTask, tasks));
    } catch (e, s) {
      log('Erro editTask:', error: e, stackTrace: s);

      emit(FailureHome(message: 'Erro ao editar tarefa:'));
    }
  }
}
