import 'dart:ffi';

import 'package:food_app/page/address/add_address_page.dart';
import 'package:food_app/page/address/pick_address_map.dart';
import 'package:food_app/page/auth/sign_in_page.dart';
import 'package:food_app/page/cart/cart_page.dart';
import 'package:food_app/page/food/pupular_food_detail.dart';
import 'package:food_app/page/food/recommended_food_detaile.dart';
import 'package:food_app/page/home/home_page.dart';
import 'package:food_app/page/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAdress = "/add-address";
  static const String pickAddressMap = "/pick-address";

  static String getSplashPage() => "$splashPage";

  static String getInitial() => "$initial";

  static String getPopularFood(int pageId, String page) =>
      "$popularFood?pageId=$pageId&page=$page";

  static String getRecommendedFood(int pageId, String page) =>
      "$recommendedFood?pageId=$pageId&page=$page";

  static String getCartPage() => "$cartPage";

  static String getSignIn() => "$signIn";

  static String getAddressPage() => "$addAdress";

  static String getPickAddressPage() => "$pickAddressMap";

  static List<GetPage> route = [
    GetPage(name: splashPage, page: () => const SplashScreen()),
    GetPage(
        name: initial,
        page: () {
          return const HomePage();
        },
        transition: Transition.fade),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];

          return PupularFoodDetaile(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var recommendedId = Get.parameters["pageId"];
          var page = Get.parameters['page'];
          return RecommendedFoodDetailes(
              recommendedId: int.parse(recommendedId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          // var recommendedId = Get.parameters["pageId"];
          return const CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: signIn,
        page: () {
          // var recommendedId = Get.parameters["pageId"];
          return const SignInPage();
        },
        transition: Transition.fadeIn),
    GetPage(
      name: addAdress,
      page: () {
        // var recommendedId = Get.parameters["pageId"];
        return const AddAddressPage();
      },
      // transition: Transition.fadeIn,
    ),
    GetPage(
      name: pickAddressMap,
      page: () {
        PickAddressMap _pickAddress = Get.arguments;
        return _pickAddress;
      },
      // transition: Transition.fadeIn,
    ),
  ];
}
