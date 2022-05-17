class CartModel {
  int? id;
  String? name;
  String? imageurl;
  int? price;
  int? quantity;

  CartModel({this.id, this.name, this.imageurl, this.price, this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageurl = json['imageurl'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageurl'] = this.imageurl;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
