import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/data/repository/poopular_product_repo.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/utils/app_colors.dart';

import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  late CartController _cart;

  List<ProductsModel> _popularProductList = [];
  List<ProductsModel> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quentity = 0;
  int get quentity => _quentity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quentity;

  Future<void> getPopularroductList() async {
    Response response = await popularProductRepo.getPopularroductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products!);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuentity(bool isIncriment) {
    if (isIncriment) {
      _quentity = chackeQuentity(_quentity + 1);
    } else {
      _quentity = chackeQuentity(_quentity - 1);
    }
    update();
  }

  int chackeQuentity(int quantity) {
    if ((_inCartItems + quentity) < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItems < 0) {
        _quentity = -_inCartItems;
        return _quentity;
      }
      return 0;
    } else if ((_inCartItems + quentity) > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductsModel product, CartController cart) {
    _quentity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);

    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    print("the quantity in the cart is" + _inCartItems.toString());
  }

  void addItem(ProductsModel product) {
    _cart.addItem(product, quentity);

    _quentity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("The id is" +
          value.id.toString() +
          " The quentity is " +
          value.quantity.toString());
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
