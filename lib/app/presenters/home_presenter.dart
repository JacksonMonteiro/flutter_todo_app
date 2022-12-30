import 'package:flutter/cupertino.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/services/category_service.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';

abstract class HomePresenterContract {
  loading();
  start() {}
  changeState() {}
}

class HomePresenter {
  // Variables
  List<Category> categories = [];

  // Service and State
  var state = ValueNotifier<HomeState>(HomeState.start);
  IService service = CategoryService();

  final HomePresenterContract contract;
  HomePresenter(this.contract);

  loadCategories() async {
    state.value = HomeState.loading;
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
