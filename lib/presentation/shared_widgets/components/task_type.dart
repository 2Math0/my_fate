import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_fate/presentation/shared_widgets/components/rounded_text.dart';

import '../../resources/colors_manager.dart';
import '../../resources/decoration_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class TaskTypeItem extends StatelessWidget {
  final String name;
  final ColorShades color;
  final String svgIcon;
  final int leftNum;
  final int doneNum;
  final VoidCallback onTap;
  final double size;

  const TaskTypeItem({
    Key? key,
    required this.name,
    required this.color,
    required this.svgIcon,
    required this.leftNum,
    required this.doneNum,
    required this.onTap,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: color.light,
      splashColor: color.light,
      child: Container(
        height: size,
        width: size,
        decoration: AppDecoration.defaultBoxDecoration(color.light),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(svgIcon, color: color.dark, height: AppSize.s32),
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
                      bgColor: color.normal,
                      textColor: color.dark,
                      txt: '$leftNum ${AppStrings.left.toLowerCase()}'),
                  NumTextRoundedBG(
                      bgColor: AppColors.kWhite,
                      textColor: color.dark,
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
