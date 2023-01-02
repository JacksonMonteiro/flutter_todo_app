import 'package:flutter/cupertino.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/services/category_service.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';

abstract class AddTaskContract {
  loading();
  start() {}
  changeState() {}
}

class AddTaskPresenter {
  // Variables
  List<Category> categories = [];

  // Service and State
  var state = ValueNotifier<AddTaskState>(AddTaskState.start);
  IService service = CategoryService();

  final AddTaskContract contract;
  AddTaskPresenter(this.contract);

  stateManager(AddTaskState state) {
    switch (state) {
      case AddTaskState.start:
        return contract.start();
      case AddTaskState.loading:
        return contract.loading();
    }
  }
}

enum AddTaskState { start, loading }
