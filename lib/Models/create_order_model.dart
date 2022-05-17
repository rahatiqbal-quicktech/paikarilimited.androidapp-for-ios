class CreateOrderModel {
  int? product_id;
  int? quantity;
  CreateOrderModel({this.product_id, this.quantity});
  Map<String, dynamic> toJson() {
    return {"product_id": product_id, "quantity": quantity};
  }
}
