import 'package:todo/app/models/category_model.dart';

abstract class CategoryEvent {}
class LoadCategoriesEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  Category category;
  AddCategoryEvent({required this.category});
}