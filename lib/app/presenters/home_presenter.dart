import 'package:flutter/cupertino.dart';
import 'package:todo/app/services/category_service.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';

abstract class HomePresenterContract {
  start() {}
}

class HomePresenter {
  IService service = CategoryService();

  final state = ValueNotifier<HomeState>(HomeState.start);

  final HomePresenterContract contract;
  HomePresenter(this.contract);

  loadCategories() {
    var response = service.get();
    return response;
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