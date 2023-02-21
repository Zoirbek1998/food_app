import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/helper/route_helper.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/exandable_text.dart';

import 'package:get/get.dart';

class RecommendedFoodDetailes extends StatelessWidget {
  int recommendedId;
  String page;
  RecommendedFoodDetailes(
      {super.key, required this.recommendedId, required this.page});

  @override
  Widget build(BuildContext context) {
    var recommended = Get.find<RecommendedProductController>()
        .recommendedProductList[recommendedId];
    Get.find<PopularProductController>()
        .initProduct(recommended, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          //
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 90,
            title: Row(
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
                    icon: Icons.clear,
                    iconColor: Colors.black,
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
            pinned: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                alignment: Alignment.center,
                child: BigText(
                  text: recommended.name!,
                  size: Dimensions.font26,
                ),
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )),
              ),
            ),
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.IMAGE_URI + recommended.img!,
                // "assets/images/food.jpeg",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: ExandableTextWidget(text: recommended.description!
                      // "Mavjud Lore Ipsum oyatlarning ko'p tafovutlar bor, lekin ko'p ba'zi shaklida o'zgartirish uchradi, sanchiladi hazil tomonidan, hatto bir oz ehtimol qarash emas yoki randomize so'zlar. Agar siz Lore Ipsum parchasidan foydalanmoqchi bo'lsangiz, matn o'rtasida sharmandali narsa yashirilmaganiga ishonch hosil qilishingiz kerak. Internetda barcha Lore Ipsum generatorlar zarur oldindan belgilangan qismlar takrorlash moyil, bu internetda birinchi haqiqiy generator qilish. Bu orqali bir lug'at foydalanadi 200 lotin so'zlar, model hukm tuzilmalari bir hovuch bilan birga, o'rtacha ko'rinadi Lore Ipsum ishlab chiqarish uchun. Yaratilgan Lore Ipsum shuning uchun har doim takrorlash, AOK qilingan hazil yoki xarakterli bo'lmagan so'zlardan va hokazolardan xoli.",
                      ),
                ),
                // Text(
                //   "Mavjud Lore Ipsum oyatlarning ko'p tafovutlar bor, lekin ko'p ba'zi shaklida o'zgartirish uchradi, sanchiladi hazil tomonidan, hatto bir oz ehtimol qarash emas yoki randomize so'zlar. Agar siz Lore Ipsum parchasidan foydalanmoqchi bo'lsangiz, matn o'rtasida sharmandali narsa yashirilmaganiga ishonch hosil qilishingiz kerak. Internetda barcha Lore Ipsum generatorlar zarur oldindan belgilangan qismlar takrorlash moyil, bu internetda birinchi haqiqiy generator qilish. Bu orqali bir lug'at foydalanadi 200 lotin so'zlar, model hukm tuzilmalari bir hovuch bilan birga, o'rtacha ko'rinadi Lore Ipsum ishlab chiqarish uchun. Yaratilgan Lore Ipsum shuning uchun har doim takrorlash, AOK qilingan hazil yoki xarakterli bo'lmagan so'zlardan va hokazolardan xoli.",
                //   style: TextStyle(fontSize: 50),
                // ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (contoller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // add item
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        contoller.setQuentity(false);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          icon: Icons.remove),
                    ),
                    BigText(
                      text: "\$${recommended.price!}" +
                          " X " +
                          "${contoller.inCartItems}",
                      color: AppColors.mainBackColor,
                      size: Dimensions.font16,
                    ),
                    GestureDetector(
                      onTap: () {
                        contoller.setQuentity(true);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          icon: Icons.add),
                    ),
                  ],
                ),
              ),

              // like

              Container(
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          ),
                        ],
                      ),
                    ),

                    //product card shop
                    GestureDetector(
                      onTap: () {
                        contoller.addItem(recommended);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: BigText(
                          text: "\$${recommended.price!} | Add to cart",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
