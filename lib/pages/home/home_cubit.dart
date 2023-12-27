import 'package:bloc/bloc.dart';
import 'package:to_do_list_bloc/models/task.dart';
import 'package:to_do_list_bloc/pages/home/home_state.dart';
import 'package:to_do_list_bloc/repositories/home/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  HomeCubit(this._homeRepository) : super(EmptyHome());

  Future<void> addTask(String userId, Task task) async {
    emit(LoadingHome());
    try {
      final updatedTask = await _homeRepository.addTask(userId, task);
      emit(AddHome(updatedTask));
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
      emit(FailureHome(message: 'Erro ao obter tarefas: $e. $s'));
    }
  }
}
