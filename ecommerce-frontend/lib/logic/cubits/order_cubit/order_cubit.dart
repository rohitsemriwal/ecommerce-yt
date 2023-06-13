import 'dart:async';

import 'package:ecommerce/data/models/order/order_model.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubits/order_cubit/order_state.dart';
import 'package:ecommerce/logic/services/calculations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../user_cubit/user_cubit.dart';
import '../user_cubit/user_state.dart';
import './../../../data/repositories/order_repository.dart';

class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  final CartCubit _cartCubit;
  StreamSubscription? _userSubscription;
  
  OrderCubit(this._userCubit, this._cartCubit) : super( OrderInitialState() ) {
    // initial Value
    _handleUserState(_userCubit.state);

    // Listening to User Cubit (for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if(userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    }
    else if(userState is UserLoggedOutState) {
      emit( OrderInitialState() );
    }
  }

  final _orderRepository = OrderRepository();

  void _initialize(String userId) async {
    emit( OrderLoadingState(state.orders) );
    try {
      final orders = await _orderRepository.fetchOrdersForUser(userId);
      emit( OrderLoadedState(orders) );
    }
    catch(ex) {
      emit( OrderErrorState(ex.toString(), state.orders) );
    }
  }

  Future<OrderModel?> createOrder({
    required List<CartItemModel> items,
    required String paymentMethod
  }) async {
    emit( OrderLoadingState(state.orders) );
    try {
      if(_userCubit.state is! UserLoggedInState) {
        return null;
      }

      OrderModel newOrder = OrderModel(
        items: items,
        totalAmount: Calculations.cartTotal(items),
        user: (_userCubit.state as UserLoggedInState).userModel,
        status: (paymentMethod == "pay-on-delivery") ? "order-placed" : "payment-pending"
      );
      final order = await _orderRepository.createOrder(newOrder);

      List<OrderModel> orders = [ order, ...state.orders ];

      emit( OrderLoadedState(orders) );

      // Clear the cart
      _cartCubit.clearCart();

      return order;
    }
    catch(ex) {
      emit( OrderErrorState(ex.toString(), state.orders) );
      return null;
    }
  }

  Future<bool> updateOrder(OrderModel orderModel, {
    String? paymentId,
    String? signature
  }) async {
    try {
      OrderModel updatedOrder = await _orderRepository.updateOrder(
        orderModel,
        paymentId: paymentId,
        signature: signature
      );

      int index = state.orders.indexOf(updatedOrder);
      if(index == -1) return false;

      List<OrderModel> newList = state.orders;
      newList[index] = updatedOrder;

      emit( OrderLoadedState(newList) );
      return true;
    }
    catch(ex) {
      emit( OrderErrorState(ex.toString(), state.orders) );
      return false;
    }
    
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

// Order(Backend) ---order_id---> Frontend (order_id: Payment)

// Order1 -> id: 1, items: 2
// Order2 -> id: 1, items: 2

// Order1 == Order2 --> false