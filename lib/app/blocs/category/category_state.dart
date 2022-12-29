import 'package:todo/app/models/category_model.dart';

abstract class CategoryState {
  List<Category> categories;
  CategoryState({
    required this.categories
  }); 
}

class CategoryInitialState extends CategoryState {
  CategoryInitialState() : super(categories: []);
}

class CategorySuccessState extends CategoryState {
  CategorySuccessState({required List<Category> categories}) : super(categories: categories);
}