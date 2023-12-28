import 'package:to_do_list_bloc/models/task.dart';

sealed class HomeState {}

class InitialHome implements HomeState {}

class AddHome implements HomeState {
  final Task addedTask;
  AddHome(this.addedTask);
}

class DeleteHome implements HomeState {
  final Task deleteTask;
  final List<Task> taskAtt;
  DeleteHome(
    this.deleteTask,
    this.taskAtt,
  );
}

class EditingHome implements HomeState {}

class LoadingHome implements HomeState {}

class LoadedHome implements HomeState {
  final List<Task> tasks;
  LoadedHome({required this.tasks});
}

class EmptyHome extends LoadedHome {
  EmptyHome() : super(tasks: []);
}

class FailureHome implements HomeState {
  final String message;
  FailureHome({required this.message});
}
