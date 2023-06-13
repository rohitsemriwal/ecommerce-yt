import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/api.dart';
import 'package:ecommerce/data/models/cart/cart_item_model.dart';
import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/data/models/order/order_model.dart';

class OrderRepository {
  final _api = Api();

  Future<List<OrderModel>> fetchOrdersForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/order/$userId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((json) => OrderModel.fromJson(json)).toList();
    }
    catch(ex) {
      rethrow;
    }
  }

  Future<OrderModel> createOrder(OrderModel orderModel) async {
    try {
      Response response = await _api.sendRequest.post(
        "/order",
        data: jsonEncode(orderModel.toJson())
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return OrderModel.fromJson(apiResponse.data);
    }
    catch(ex) {
      rethrow;
    }
  }

  Future<OrderModel> updateOrder(OrderModel orderModel, {
    String? paymentId,
    String? signature
  }) async {
    try {
      Response response = await _api.sendRequest.put(
        "/order/updateStatus",
        data: jsonEncode({
          "orderId": orderModel.sId,
          "status": orderModel.status,
          "razorPayPaymentId": paymentId,
          "razorPaySignature": signature
        })
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return OrderModel.fromJson(apiResponse.data);
    }
    catch(ex) {
      rethrow;
    }
  }

}