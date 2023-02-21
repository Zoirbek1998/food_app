import 'package:food_app/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductsModel? productsModel;

  CartModel({
    int? id,
    String? name,
    int? price,
    String? img,
    int? quantity,
    bool? isExist,
    String? time,
    ProductsModel? products,
  }) {
    if (id != null) {
      this.id = id;
    }
    if (name != null) {
      this.name = name;
    }
    if (price != null) {
      this.price = price;
    }
    if (img != null) {
      this.img = img;
    }
    if (quantity != null) {
      this.quantity = quantity;
    }
    if (isExist != null) {
      this.isExist = isExist;
    }
    if (time != null) {
      this.time = time;
    }
    if (products != null) {
      this.productsModel = products;
    }
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json["quantity"];
    isExist = json["isExist"];
    time = json["time"];
    productsModel = ProductsModel.fromJson(json["product"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      'name': this.name,
      "price": this.price,
      "img": this.img,
      "quantity": this.quantity,
      "isExist": this.isExist,
      "time": this.time,
      "product": this.productsModel!.toJson()
    };
  }
}
