import 'package:sqflite/sqflite.dart';
import 'package:todo/app/models/task_model.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';
import 'package:todo/database/db.dart';

class TaskService extends IService {
  late Database db;
  final List<Task> _tasks = [];
  
  @override
  Future<List<Task>> add(data) async {
    db = await DB.instance.database;
    Task task = data as Task;

    var response = await db.rawInsert('INSERT INTO tasks (name, category) VALUES ("${task.name}", "${task.category}")');
    if (response <= 0) {
      print('Erro ao adicionar');
    } else {
      _tasks.add(data);
    }

    _tasks.add(data as Task);
    return _tasks;
  }
  
  @override
  Future<List<Task>> get() async {
    // return _tasks;

    db = await DB.instance.database;

    List dbCategories = await db.rawQuery('SELECT * FROM tasks');
    if (dbCategories.isEmpty) {
      print('Consulta retornou lista vazia');
    } else {
      for (var i = 0; i < dbCategories.length; i++) {
        _tasks.insert(
            0,
            Task(
              id: dbCategories[i]['id'],
              name: dbCategories[i]['name'],
              category: dbCategories[i]['category'],
            ));
      }
    }

    return _tasks;
  }
  
  @override
  remove(String name) async {
    db = await DB.instance.database;
    var response = await db.rawDelete('DELETE FROM tasks WHERE name = "$name"');
    return response;
  }

  @override
  List<Task> removeByIndex(int index) {
    _tasks.removeAt(index);
    return _tasks;
  }
}