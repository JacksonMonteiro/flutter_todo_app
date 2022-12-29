import 'package:flutter/material.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';

class CategoryService extends IService {
  List<Category> categories = [
    Category(icon: Icons.add, name: 'Adicionar', tasks: [], color: Colors.red[100]),
  ];
  
  @override
  List<Category> add(data) {
    categories.insert(0, data as Category);
    return categories;
  }
  
  @override
  List<Category> get() {
    return categories;
  }
  
  @override
  List<Category> remove(data) {
    categories.remove(data as Category);
    return categories;
  }
}