import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';

class CategoryService extends IService {
  List<Category> categories = [
    Category(icon: const Icon(Icons.home), name: 'Geral', tasks: [])
  ];
  
  @override
  List<Category> add(data) {
    categories.add(data as Category);
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