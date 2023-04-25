import 'package:ecommerce/data/models/category/category_model.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<CategoryModel> categories;
  CategoryLoadedState(this.categories);
}

class CategoryErrorState extends CategoryState {
  final String message;
  CategoryErrorState(this.message);
}