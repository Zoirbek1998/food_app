import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/page/home/food_page_body.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/smaill_text.dart';

import 'package:get/get.dart';

class HomeFoodPage extends StatefulWidget {
  const HomeFoodPage({super.key});

  @override
  State<HomeFoodPage> createState() => _HomeFoodPageState();
}

class _HomeFoodPageState extends State<HomeFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularroductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          child: Column(children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: "Andijon",
                          color: AppColors.mainColor,
                        ),
                        Row(
                          children: [
                            SmillText(
                              text: "Baliqchi",
                              color: Colors.black54,
                            ),
                            const Icon(Icons.arrow_drop_down_rounded)
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: Dimensions.width45,
                      height: Dimensions.height45,
                      child: Icon(
                        IconlyLight.search,
                        color: Colors.white,
                        size: Dimensions.iconSize24,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: const FoodPageBody(),
            )),
          ]),
          onRefresh: _loadResource),
    );
  }
}
