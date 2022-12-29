import 'package:bloc/bloc.dart';
import 'package:todo/app/blocs/task/task_events.dart';
import 'package:todo/app/blocs/task/task_state.dart';
import 'package:todo/app/models/task_model.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';
import 'package:todo/app/services/task_service.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final IService _service = TaskService();

  TaskBloc() : super(TaskInitialState()) {
    on<LoadTasksEvent>(
       (event, emit) => emit(TaskSuccessState(tasks: _service.get() as List<Task>)),
    );
  }
}