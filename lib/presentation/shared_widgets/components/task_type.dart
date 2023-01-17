import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_fate/presentation/shared_widgets/components/rounded_text.dart';

import '../../resources/colors_manager.dart';
import '../../resources/decoration_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class TaskTypeItem extends StatelessWidget {
  final String name;
  final Color color;
  final Color darkColor;
  final Color lightColor;
  final String svgIcon;
  final int leftNum;
  final int doneNum;
  final VoidCallback onTap;

  const TaskTypeItem({
    Key? key,
    required this.name,
    required this.color,
    required this.darkColor,
    required this.lightColor,
    required this.svgIcon,
    required this.leftNum,
    required this.doneNum,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: lightColor,
      splashColor: lightColor,
      child: Container(
        decoration: AppDecoration.defaultBoxDecoration(lightColor),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(svgIcon, color: darkColor, height: AppSize.s32),
              const SizedBox(height: AppMargin.m16),
              Text(
                name,
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: AppMargin.m8),
              Wrap(
                spacing: AppPadding.p8,
                children: [
                  NumTextRoundedBG(
                      bgColor: color,
                      textColor: darkColor,
                      txt: '$leftNum ${AppStrings.left.toLowerCase()}'),
                  NumTextRoundedBG(
                      bgColor: AppColors.kWhite,
                      textColor: darkColor,
                      txt: '$doneNum ${AppStrings.done.toLowerCase()}'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
