import 'package:flutter/cupertino.dart';
import 'package:todo/app/models/task_model.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';
import 'package:todo/app/services/task_service.dart';

abstract class CategoryViewContract {
  start() {}
  changeState() {}
}

class CategoryViewPresenter {
  // Variables
  List<Task> tasks = [];

  // State and service
  final state = ValueNotifier<CategoryViewState>(CategoryViewState.start);
  IService taskServices = TaskService();

  final CategoryViewContract contract;
  CategoryViewPresenter(this.contract);

  getTasks() {
    tasks = taskServices.get() as List<Task>;
  }

  addTask(Task task) {
    tasks = taskServices.add(task) as List<Task>;
    contract.changeState();
  }

  removeTask(Task task) {
    tasks = taskServices.remove(task) as List<Task>;
    contract.changeState();
  }

  stateManager(CategoryViewState state) {
    switch(state) {
      case CategoryViewState.start:
        return contract.start();
    }
  }
}

enum  CategoryViewState { start }