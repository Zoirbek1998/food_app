import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/smaill_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          color: Colors.black,
          size: Dimensions.font26,
        ),
        // SizedBox(
        //   height: Dimensions.height10,
        // ),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  IconlyBold.star,
                  color: AppColors.mainColor,
                  size: 15,
                );
              }),
            ),
            const SizedBox(
              width: 10,
            ),
            SmillText(
              text: '4.5',
              color: Colors.black54,
            ),
            const SizedBox(
              width: 10,
            ),
            SmillText(
              text: "1287",
              color: Colors.black54,
            ),
            const SizedBox(
              width: 7,
            ),
            SmillText(
              text: "comments",
              color: Colors.black54,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: 'Normal',
                color: Colors.black54,
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(
                icon: IconlyBold.location,
                text: '1.7km',
                color: Colors.black54,
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                icon: IconlyLight.timeCircle,
                text: '32min',
                color: Colors.black54,
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
