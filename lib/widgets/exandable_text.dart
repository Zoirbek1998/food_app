import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/smaill_text.dart';

class ExandableTextWidget extends StatefulWidget {
  final String text;

  const ExandableTextWidget({super.key, required this.text});

  @override
  State<ExandableTextWidget> createState() => _ExandableTextWidgetState();
}

class _ExandableTextWidgetState extends State<ExandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddinText = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmillText(
              color: AppColors.paraColor,
              size: Dimensions.font16,
              text: firstHalf)
          : Column(
              children: [
                SmillText(
                    height: 1.8,
                    color: AppColors.paraColor,
                    size: Dimensions.font16,
                    text: hiddinText
                        ? (firstHalf + "...")
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddinText = !hiddinText;
                    });
                  },
                  child: Row(
                    children: [
                      SmillText(
                        text: "Show more",
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        hiddinText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
