import 'package:ecommerce/logic/cubits/category_product_cubit/category_product_cubit.dart';
import 'package:ecommerce/logic/cubits/category_product_cubit/category_product_state.dart';
import 'package:ecommerce/presentation/screens/home/user_feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductByCategoryScreen extends StatefulWidget {
  const ProductByCategoryScreen({super.key});

  static const String routeName = "product_by_category";

  @override
  State<ProductByCategoryScreen> createState() => _ProductByCategoryScreenState();
}

class _ProductByCategoryScreenState extends State<ProductByCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryProductCubit = BlocProvider.of<CategoryProductCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("${categoryProductCubit.category.title}"),
      ),
      body: SafeArea(
        child: BlocBuilder<CategoryProductCubit, CategoryProductState>(
          builder: (context, state) {

            if(state is CategoryProductLoadingState && state.products.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(state is CategoryProductErrorState && state.products.isEmpty) {
              return Center(
                child: Text(state.message)
              );
            }
            else {
              if(state.products.isEmpty) {
                return const Center(
                  child: Text("No products found!"),
                );
              }
              return productListView(state.products);
            }

          },
        ),
      ),
    );
  }
}