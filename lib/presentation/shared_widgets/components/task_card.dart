import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/decoration_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

import '../../../app/converter.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String startTime;
  final int hours;
  final Color categoryColor;
  final String description;
  final bool isDone;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onDone;
  const TaskCard({
    Key? key,
    required this.title,
    required this.startTime,
    required this.categoryColor,
    required this.description,
    required this.hours,
    this.isDone = false,
    required this.onDelete,
    required this.onEdit,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Radius borderRadius = Radius.circular(AppCircularRadius.cr24);
    return FocusedMenuHolder(
      menuItems: [
        FocusedMenuItem(
          title: Text(isDone ? "UnDo" : 'DONE',
              style: const AppTextStyles().bodyTextNormalBold),
          backgroundColor: categoryColor,
          trailingIcon: Icon(
            isDone ? Icons.unpublished_rounded : Icons.check_circle_rounded,
            color: AppColors.darkGrey,
          ),
          onPressed: onDone,
        ),
        FocusedMenuItem(
          title: Text('EDIT', style: const AppTextStyles().bodyTextNormalBold),
          trailingIcon: const Icon(
            Icons.mode_edit_rounded,
            color: AppColors.kBlack,
          ),
          onPressed: onEdit,
        ),
        FocusedMenuItem(
          backgroundColor: AppColors.red.dark,
          title: Text('DELETE',
              style: const AppTextStyles()
                  .bodyTextNormalBold
                  .copyWith(color: AppColors.kWhite)),
          trailingIcon: const Icon(
            Icons.delete,
            color: AppColors.kWhite,
          ),
          onPressed: onDelete,
        ),
      ],
      blurSize: 4,
      blurBackgroundColor: AppColors.darkGrey,
      duration: const Duration(milliseconds: 300),
      animateMenuItems: true,
      menuBoxDecoration: AppDecoration.defaultBoxDecoration(categoryColor),
      menuOffset: AppMargin.m12,
      menuWidth: AppSize.s100,
      openWithTap: true,
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p12),
        decoration: BoxDecoration(
            color: isDone ? AppColors.kWhite : categoryColor,
            borderRadius: const BorderRadius.only(
                topRight: borderRadius,
                bottomRight: borderRadius,
                bottomLeft: borderRadius)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const AppTextStyles().headingH5.copyWith(
                    decoration: isDone ? TextDecoration.lineThrough : null)),
            if (description.isNotEmpty)
              Text(description,
                  style: const AppTextStyles().bodyTextNormalRegular.copyWith(
                      color: AppColors.kBlack.withOpacity(0.8),
                      decoration: isDone ? TextDecoration.lineThrough : null)),
            Text(
                "  $startTime - ${const Converter().intToTime(const Converter().parsingHourToInt(startTime) + hours)}",
                style: const AppTextStyles()
                    .captionNormalBold
                    .copyWith(color: AppColors.darkGrey)),
          ],
        ),
      ),
    );
  }
}
