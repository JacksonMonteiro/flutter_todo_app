import 'package:flutter/cupertino.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/services/category_service.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';

abstract class HomePresenterContract {
  start() {}
  changeState() {}
}

class HomePresenter {
  // Variables
  List<Category> categories = [];
  
  // Service and State
  final state = ValueNotifier<HomeState>(HomeState.start);
  IService service = CategoryService();

  final HomePresenterContract contract;
  HomePresenter(this.contract);

  loadCategories() {
    categories = service.get() as List<Category>;
  }

  addCategory(Category category) {
    categories = service.add(category) as List<Category>;
    contract.changeState();
  }

  stateManager(HomeState state) {
      switch(state) {
        case HomeState.start:
          return contract.start();
      }
  }

}

enum HomeState {
  start,
}