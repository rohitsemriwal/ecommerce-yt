import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecommerce/logic/cubits/order_cubit/order_state.dart';
import 'package:ecommerce/logic/services/calculations.dart';
import 'package:ecommerce/logic/services/formatter.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  static const routeName = "my_orders";

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: SafeArea(
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {

            if(state is OrderLoadingState && state.orders.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(state is OrderErrorState && state.orders.isEmpty) {
              return Center(
                child: Text(state.message)
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.orders.length,
              separatorBuilder: (context, index) {
                return Column(
                  children: [
                    const GapWidget(),
                    Divider(color: AppColors.textLight),
                    const GapWidget(),
                  ],
                );
              },
              itemBuilder: (context, index) {

                final order = state.orders[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("# - ${order.sId}", style: TextStyles.body2.copyWith(color: AppColors.textLight),),
                    Text(Formatter.formatDate(order.createdOn!), style: TextStyles.body2.copyWith(color: AppColors.accent),),
                    Text("Order Total: ${Formatter.formatPrice(Calculations.cartTotal(order.items!))}", style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),),

                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: order.items!.length,
                      itemBuilder: (context, index) {

                        final item = order.items![index];
                        final product = item.product!;

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CachedNetworkImage(
                            imageUrl: product.images![0],
                          ),
                          title: Text("${product.title}"),
                          subtitle: Text("Qty: ${item.quantity}"),
                          trailing: Text(Formatter.formatPrice(product.price! * item.quantity!))
                        );

                      },
                    ),

                    Text("Status: ${order.status}"),

                  ],
                );

              },
            );

          },
        ),
      ),
    );
  }
}