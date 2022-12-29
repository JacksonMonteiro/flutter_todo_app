import 'package:bloc/bloc.dart';
import 'package:todo/app/blocs/category/category_events.dart';
import 'package:todo/app/blocs/category/category_state.dart';
import 'package:todo/app/models/category_model.dart';
import 'package:todo/app/services/category_service.dart';
import 'package:todo/app/services/interfaces/service_interface.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final IService _service = CategoryService();
  
  CategoryBloc() : super(CategoryInitialState()) {
    on<LoadCategoriesEvent>(
      (event, emit) => emit(CategorySuccessState(categories: _service.get() as List<Category>))
    );

    on<AddCategoryEvent>(
      (event, emit) => emit(CategorySuccessState(categories: _service.add(event.category) as List<Category>)),
    );
  }
 
}