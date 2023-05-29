import 'package:ecommerce/data/models/cart/cart_item_model.dart';

import '../user/user_model.dart';

class OrderModel {
  String? sId;
  UserModel? user;
  List<CartItemModel>? items;
  String? status;
  DateTime? updatedOn;
  DateTime? createdOn;

  OrderModel({this.sId, this.user, this.items, this.status, this.updatedOn, this.createdOn});

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = UserModel.fromJson(json["user"]);
    items = (json["items"] as List<dynamic>).map((item) => CartItemModel.fromJson(item)).toList();
    status = json['status'];
    updatedOn = DateTime.tryParse(json['updatedOn']);
    createdOn = DateTime.tryParse(json['createdOn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = user!.toJson();
    data['items'] = items!.map((item) => item.toJson(objectMode: true)).toList();
    data['status'] = this.status;
    data['updatedOn'] = this.updatedOn?.toIso8601String();
    data['createdOn'] = this.createdOn?.toIso8601String();
    return data;
  }
}
