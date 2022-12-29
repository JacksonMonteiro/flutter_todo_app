import 'package:todo/app/models/task_model.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';

class TaskService extends IService {
  final List<Task> _tasks = [
    Task(name: 'Tarefa inicial', category: 'Geral')
  ];
  
  @override
  List<Task> add(data) {
    _tasks.add(data as Task);
    return _tasks;
  }
  
  @override
  List<Task> get() {
    return _tasks;
  }
  
  @override
  List<Task> remove(data) {
    _tasks.remove(data as Task);
    return _tasks;
  }
}