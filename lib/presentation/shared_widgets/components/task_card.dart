import 'package:flutter/material.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
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
  const TaskCard({
    Key? key,
    required this.title,
    required this.startTime,
    required this.categoryColor,
    required this.description,
    required this.hours,
    this.isDone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Radius borderRadius = Radius.circular(AppCircularRadius.cr24);
    return Container(
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
          color: categoryColor,
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
    );
  }
}
