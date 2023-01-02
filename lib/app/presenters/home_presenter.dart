import 'package:flutter/material.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/services/category_service.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';
import 'package:todo/app/services/task_service.dart';

abstract class HomePresenterContract {
  loading();
  start() {}
  changeState() {}
}

class HomePresenter {
  // Variables
  int tasks = 0;
  List<Category> categories = [Category(icon: Icons.add, name: 'Adicionar', tasks: 0, color: Colors.red[100]),];

  // Service and State
  var state = ValueNotifier<HomeState>(HomeState.start);
  IService service = CategoryService();
  IService taskService = TaskService();

  final HomePresenterContract contract;
  HomePresenter(this.contract);

  restartCategories() {
    categories.clear();
    categories.add(Category(icon: Icons.add, name: 'Adicionar', tasks: 0, color: Colors.red[100]));
  }

  getTasksNumber() async {
    try {
      var response = await taskService.get();
      if (response.isNotEmpty) {
        tasks = response.length;
      }
    } catch (e) {
      print('Houve um erro ao tentar pegar o número de tarefas');
    }
  }

  loadCategories() async {
    state.value = HomeState.loading;
    
    restartCategories();
    await getTasksNumber();
    
    try {
      var response = await service.get();
      if (response.isNotEmpty) {
          categories = response as List<Category>;
          state.value = HomeState.start;
      }

    } catch (e) {
      print('Houve um erro desconhecido: ');
    }
  }

  addCategory(Category category) async {
    state.value = HomeState.loading;
    try {
      var response = await service.add(category);
      
      if (response.isNotEmpty) {
          categories = response as List<Category>;
          state.value = HomeState.start;
      }
    } catch (e) {
      print('Houve um erro desconhecido: ');
    }

    contract.changeState();
  }

  stateManager(HomeState state) {
    switch (state) {
      case HomeState.start:
        return contract.start();
      case HomeState.loading:
        return contract.loading();
    }
  }
}

enum HomeState { start, loading }
