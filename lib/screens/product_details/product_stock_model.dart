// To parse this JSON data, do
//
//     final productStockModel = productStockModelFromJson(jsonString);

import 'dart:convert';

ProductStockModel productStockModelFromJson(String str) =>
    ProductStockModel.fromJson(json.decode(str));

String productStockModelToJson(ProductStockModel data) =>
    json.encode(data.toJson());

class ProductStockModel {
  ProductStockModel({
    this.id,
    this.manageStock,
    this.stockQuantity,
    this.lowStockAmount,
    this.stockStatus,
  });

  int? id;
  bool? manageStock;
  dynamic stockQuantity;
  dynamic lowStockAmount;
  String? stockStatus;

  factory ProductStockModel.fromJson(Map<String, dynamic> json) =>
      ProductStockModel(
        id: json["id"],
        manageStock: json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        lowStockAmount: json["low_stock_amount"],
        stockStatus: json["stock_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "low_stock_amount": lowStockAmount,
        "stock_status": stockStatus,
      };
}
