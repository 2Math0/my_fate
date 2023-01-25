import 'package:flutter/material.dart';
import 'package:my_fate/data/tasks_categories.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineTileCustom extends StatelessWidget {
  final String? category;
  final bool isFirst;
  final bool isLast;
  const TimeLineTileCustom({
    Key? key,
    this.category,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  Color get itemColor {
    return category == null
        ? AppColors.inactiveGrey
        : taskCategory[category]!.dark;
  }

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      lineXY: 0,
      alignment: TimelineAlign.manual,
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(color: itemColor, thickness: AppSize.s2),
      indicatorStyle: IndicatorStyle(
          indicatorXY: 0,
          width: AppSize.s12,
          // drawGap: true,
          indicator: Container(
            decoration: BoxDecoration(
                color: AppColors.kWhite,
                border: Border.all(color: itemColor, width: AppSize.s4),
                shape: BoxShape.circle),
          )),
      // afterLineStyle: LineStyle(thickness: AppSize.s2, color: itemColor),
    );
  }
}
