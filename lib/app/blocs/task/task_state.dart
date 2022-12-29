import 'package:todo/app/models/task_model.dart';

abstract class TaskState {
  List<Task> tasks;
  TaskState({required this.tasks});
}

class TaskInitialState extends TaskState {
  TaskInitialState() : super(tasks: []);
}

class TaskSuccessState extends TaskState {
  TaskSuccessState({required List<Task> tasks}) : super(tasks: tasks);
}