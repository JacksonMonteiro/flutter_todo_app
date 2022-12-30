import 'package:todo/app/models/task_model.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';

class TaskService extends IService {
  final List<Task> _tasks = [Task(name: 'Tarefa 1', category: 'Geral'), Task(name: 'Tarefa 2', category: 'Geral'),];
  
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
    Task taskData = data as Task;
    for (var task in _tasks) {
      if  (task.name == taskData.name && task.category == taskData.category) {
        _tasks.remove(task);
        break;
      }
    }


    return _tasks;
  }

  @override
  List<Task> removeByIndex(int index) {
    _tasks.removeAt(index);
    return _tasks;
  }
}