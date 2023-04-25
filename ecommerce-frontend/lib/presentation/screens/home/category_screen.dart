import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/logic/cubits/category_cubit/category_cubit.dart';
import 'package:ecommerce/logic/cubits/category_cubit/category_state.dart';
import 'package:ecommerce/presentation/screens/product/product_by_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/category/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        
        if(state is CategoryLoadingState || state is CategoryInitialState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is CategoryLoadedState) {
          return categoryList(state.categories);
        }
        else if(state is CategoryErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        else {
          return const SizedBox();
        }

      }
    );
  }

  Widget categoryList(List<CategoryModel> categories) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    
          Text("Categories", style: TextStyles.heading3),
    
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {

                final category = categories[index];
          
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, ProductByCategoryScreen.routeName, arguments: category);
                  },
                  leading: const Icon(Icons.category),
                  contentPadding: EdgeInsets.zero,
                  title: Text("${category.title}"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                );
          
              },
            ),
          ),
    
        ],
      ),
    );
  }

}