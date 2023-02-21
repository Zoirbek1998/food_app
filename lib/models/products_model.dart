class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  List<ProductsModel>? _products;
  List<ProductsModel>? get products => _products;

  Product(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    if (totalSize != null) {
      this._totalSize = totalSize;
    }
    if (typeId != null) {
      this._typeId = typeId;
    }
    if (offset != null) {
      this._offset = offset;
    }
    if (products != null) {
      this._products = products;
    }
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductsModel>[];
      json['products'].forEach((v) {
        _products!.add(ProductsModel.fromJson(v));
      });
    }
  }
}

class ProductsModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductsModel(
      {int? id,
      String? name,
      String? description,
      int? price,
      int? stars,
      String? img,
      String? location,
      String? createdAt,
      String? updatedAt,
      int? typeId}) {
    if (id != null) {
      this.id = id;
    }
    if (name != null) {
      this.name = name;
    }
    if (description != null) {
      this.description = description;
    }
    if (price != null) {
      this.price = price;
    }
    if (stars != null) {
      this.stars = stars;
    }
    if (img != null) {
      this.img = img;
    }
    if (location != null) {
      this.location = location;
    }
    if (createdAt != null) {
      this.createdAt = createdAt;
    }
    if (updatedAt != null) {
      this.updatedAt = updatedAt;
    }
    if (typeId != null) {
      this.typeId = typeId;
    }
  }

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "description": this.description,
      "price": this.price,
      "stars": this.stars,
      "img": this.img,
      "location": this.location,
      "created_at": this.createdAt,
      "updated_at": this.updatedAt,
      "type_id": this.typeId,
    };
  }
}
