import 'package:ecommerce/data/models/product/product_model.dart';

abstract class CategoryProductState {
  final List<ProductModel> products;
  CategoryProductState(this.products);
}

class CategoryProductInitialState extends CategoryProductState {
  CategoryProductInitialState() : super([]);
}

class CategoryProductLoadingState extends CategoryProductState {
  CategoryProductLoadingState(super.products);
}

class CategoryProductLoadedState extends CategoryProductState {
  CategoryProductLoadedState(super.products);
}

class CategoryProductErrorState extends CategoryProductState {
  final String message;
  CategoryProductErrorState(this.message, super.products);
}