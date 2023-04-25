import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/data/repositories/product_repository.dart';
import 'package:ecommerce/logic/cubits/category_product_cubit/category_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;
  CategoryProductCubit(this.category) : super( CategoryProductInitialState() ) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize() async {
    emit( CategoryProductLoadingState(state.products) );
    try {
      final products = await _productRepository.fetchProductsByCategory(category.sId.toString());
      emit( CategoryProductLoadedState(products) );
    }
    catch(ex) {
      emit( CategoryProductErrorState(ex.toString(), state.products) );
    }
  }
}