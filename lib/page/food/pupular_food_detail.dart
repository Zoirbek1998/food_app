import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/helper/route_helper.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_column.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/exandable_text.dart';

import 'package:get/get.dart';

class PupularFoodDetaile extends StatelessWidget {
  int pageId;
  String page;
  PupularFoodDetaile({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    //  int id = widget.pageIds
    var products =
        Get.find<PopularProductController>().popularProductList[pageId];

    Get.find<PopularProductController>()
        .initProduct(products, Get.find<CartController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // header image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.IMAGE_URI + products.img!),
                  ),
                ),
              ),
            ),

            // app bar
            Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (page == "cartpage") {
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                    ),
                  ),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                            icon: Icons.shopping_bag_outlined,
                          ),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 2,
                                  top: 2,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // description
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: products.name!,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: 'Intrduce'),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExandableTextWidget(text: products.description!
                            // "Mavjud Lore Ipsum oyatlarning ko'p tafovutlar bor, lekin ko'p ba'zi shaklida o'zgartirish uchradi, sanchiladi hazil tomonidan, hatto bir oz ehtimol qarash emas yoki randomize so'zlar. Agar siz Lore Ipsum parchasidan foydalanmoqchi bo'lsangiz, matn o'rtasida sharmandali narsa yashirilmaganiga ishonch hosil qilishingiz kerak. Internetda barcha Lore Ipsum generatorlar zarur oldindan belgilangan qismlar takrorlash moyil, bu internetda birinchi haqiqiy generator qilish. Bu orqali bir lug'at foydalanadi 200 lotin so'zlar, model hukm tuzilmalari bir hovuch bilan birga, o'rtacha ko'rinadi Lore Ipsum ishlab chiqarish uchun. Yaratilgan Lore Ipsum shuning uchun har doim takrorlash, AOK qilingan hazil yoki xarakterli bo'lmagan so'zlardan va hokazolardan xoli.",
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Exandable Text
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
              top: Dimensions.height20,
              bottom: Dimensions.height20,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroudColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //product add and remuve

                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuentity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuentity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),

                //product card shop
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(products);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "\$${products.price!} | Add to cart",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
