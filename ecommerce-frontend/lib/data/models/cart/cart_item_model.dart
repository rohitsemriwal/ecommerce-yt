import '../product/product_model.dart';

class CartItemModel {
  ProductModel? product;
  int? quantity;
  String? sId;

  CartItemModel({this.quantity, this.sId, this.product});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    product = ProductModel.fromJson(json["product"]);
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson({
    bool objectMode = false
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = (objectMode == false) ? product!.sId : product!.toJson();
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}