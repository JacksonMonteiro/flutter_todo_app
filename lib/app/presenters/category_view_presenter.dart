import 'package:flutter/cupertino.dart';
import 'package:todo/app/models/task_model.dart';
import 'package:todo/app/services/category_service.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';
import 'package:todo/app/services/task_service.dart';

abstract class CategoryViewContract {
  start() {}
  loading() {}
  changeState() {}
}

class CategoryViewPresenter {
  // Variables
  List<Task> tasks = [];

  String category = '';
  int tasksNumber = 0;
  bool isCategorySelected = false;

  // State and service
  final state = ValueNotifier<CategoryViewState>(CategoryViewState.start);
  IService service = TaskService();
  CategoryService categoryService = CategoryService();

  final CategoryViewContract contract;
  CategoryViewPresenter(this.contract);

  initTasksNumber() async {
    state.value = CategoryViewState.loading;
    try {
      var response = await service.get();
      
      if (response.isNotEmpty) {
          tasksNumber = tasks.length;
      }
    } catch (e) {
      print('Houve um erro desconhecido ao preencher o número de tarefas');
    }
    
    state.value = CategoryViewState.start;
  }

  getTasks() async {
    state.value = CategoryViewState.loading;
    try {
      var response = await service.get();
      
      if (response.isNotEmpty) {
          tasks = response as List<Task>;
          tasksNumber = tasks.length;
      }

      print('Número de tarefas: $tasksNumber');
    } catch (e) {
      print('Houve um erro desconhecido: ');
    }
    
    state.value = CategoryViewState.start;
  }

  addTask(Task task) async {
    state.value = CategoryViewState.loading;
    try {
      var response = await service.add(task);
      
      if (response.isNotEmpty) {
          tasks = response as List<Task>;
          tasksNumber = tasksNumber + 1;
          updateCategory(category, tasksNumber);
          print('Número de tarefas: $tasksNumber');
          state.value = CategoryViewState.start;
      }
    } catch (e) {
      print('Houve um erro desconhecido: ');
    }
    contract.changeState();
  }

  updateCategory(String name, int tasks) async {
    try {
      var response = await categoryService.put(name, tasks);
      if (response <= 0) {
        print('Erro ao atualizar');
      } else {
        return true;
      }
    } catch (e) {
      print('Erro ao atualizar tarefas na categoria');
    }

    return false;
  }

  removeTask(String name, int index) async {
    await initTasksNumber();
    
    print('Número de tarefas: $tasksNumber');
    
    state.value = CategoryViewState.loading;
    try {
      var response = await service.remove(name);
      if (response <= 0 ) {
        print('Erro ao deletar');
      } else {
        tasksNumber = tasksNumber - 1;
        await updateCategory(category, tasksNumber);
        removeByIndex(index);
        return true;
      }
    } catch (e) {
      print('Houve um erro desconhecido ao deletar');
    }
    
    return false;
  }

  removeByIndex(int index) {
    service.removeByIndex(index);
    contract.changeState();
    state.value = CategoryViewState.start;
  }

  stateManager(CategoryViewState state) {
    switch(state) {
      case CategoryViewState.start:
        return contract.start();
      case CategoryViewState.loading:
        return contract.loading();
    }
  }
}

enum  CategoryViewState { start, loading }