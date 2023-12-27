import 'package:to_do_list_bloc/models/task.dart';

abstract interface class HomeRepository {
  Future<Task> addTask(String userId, Task task);
  Future<List<Task>> getTasks(String userId);
}
