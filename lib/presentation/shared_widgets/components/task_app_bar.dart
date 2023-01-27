import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_fate/presentation/resources/assets_manager.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

class TaskAppBar extends StatelessWidget {
  final String title;
  final String description;
  final Size size;
  final Color bgColor;
  final Color textColor;
  final bool isNested;

  const TaskAppBar({
    Key? key,
    required this.title,
    required this.description,
    required this.size,
    this.bgColor = AppColors.kBlack,
    this.textColor = AppColors.kWhite,
    this.isNested = true,
  }) : super(key: key);

  Size get preferredSize => Size.fromHeight(size.height * 0.14);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        elevation: 0,
        snap: true,
        pinned: true,
        floating: true,
        toolbarHeight: AppSize.s60,
        expandedHeight: preferredSize.height,
        // Material 3 Changes to make
        surfaceTintColor: bgColor == AppColors.kWhite ? AppColors.kWhite : null,
        scrolledUnderElevation: 0,
        leading: isNested
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(
                  AppIcons.leftArrow,
                  color: textColor,
                  height: AppSize.s12,
                ))
            : null,
        backgroundColor: bgColor,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: bgColor == AppColors.kBlack
                ? Brightness.light
                : Brightness.dark,
            statusBarIconBrightness: bgColor == AppColors.kBlack
                ? Brightness.light
                : Brightness.dark),
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(
            left: size.width * 0.15,
            bottom: preferredSize.height * 0.2,
          ),
          title: Text(title,
              style:
                  const AppTextStyles().headingH2.copyWith(color: textColor)),
          background: Padding(
            padding: EdgeInsets.only(
                top: preferredSize.height * 0.9, left: size.width * 0.2),
            child: Text(
              description,
              style: const AppTextStyles()
                  .bodyTextLargeRegular
                  .copyWith(color: textColor.withOpacity(0.3)),
            ),
          ),
        ));
  }
}
