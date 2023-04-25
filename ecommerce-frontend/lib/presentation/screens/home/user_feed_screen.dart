import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:ecommerce/logic/cubits/product_cubit/product_cubit.dart';
import 'package:ecommerce/logic/cubits/product_cubit/product_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {

        if(state is ProductLoadingState && state.products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is ProductErrorState && state.products.isEmpty) {
          return Center(
            child: Text(state.message)
          );
        }
        else {
          return productListView(state.products);
        }

        
      }
    );
  }
}

Widget productListView(List<ProductModel> products) {
    return ListView.separated(
      itemCount: products.length,
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemBuilder: (context, index) {

        final product = products[index];

        return CupertinoButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              
              Flexible(
                flex: 2,
                child: Image.network("${product.images?[0]}")
              ),
        
              const SizedBox(width: 16),
        
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${product.title}", style: TextStyles.heading3, maxLines: 1, overflow: TextOverflow.ellipsis,),
                    Text("INR ${product.price}", style: TextStyles.heading3.copyWith(color: AppColors.accent)),
                    const SizedBox(height: 5),
                    Text("${product.description}", style: TextStyles.body2.copyWith(color: AppColors.textLight), maxLines: 2, overflow: TextOverflow.ellipsis,),
                  ],
                )
              )
        
            ],
          ),
        );

      },
    );
  }