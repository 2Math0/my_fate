import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/strings_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../resources/assets_manager.dart';
import 'components/date_picker.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = [
      for (int i = 0; i <= 10; i++)
        {
          "title": "This a task",
          "description": "this is a description",
          "start time": "10:00 am",
          "end time": "11:00 am",
          "category": "personal"
        }
    ];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: CustomScrollView(slivers: [
        // App Bar
        TaskAppBar(
          title: AppStrings.personalTasks,
          description: AppStrings.taskDescription,
          size: size,
        ),
        // Date Picker + Top Rounded Border
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p20),
            decoration: const BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppCircularRadius.cr24))),
            child: const DatePicker(),
          ),
        ),
        if (data[0].isEmpty)
          SliverFillRemaining(
            child: Container(
                color: AppColors.kWhite,
                child: Center(
                    child: Text(
                  "No Task Today",
                  style: const AppTextStyles().headingH2,
                ))),
          ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => TaskTimeLine(task: data[index]),
                childCount: data.length)),
      ]),
    );
  }
}

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
        expandedHeight: preferredSize.height,
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

class TaskTimeLine extends StatelessWidget {
  final Map<String, dynamic> task;
  const TaskTimeLine({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kWhite,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: AppSize.s20,
            child: TimeLineTileCustom(category: AppStrings.personal),
          ),
          Text(task["start time"],
              style: const AppTextStyles().bodyTextNormalRegular),
          const SizedBox(width: AppMargin.m16),
          Expanded(
            child: TaskCard(
                title: task["title"],
                startTime: task["start time"],
                endTime: task["end time"],
                categoryColor: AppColors.kRedLight,
                description: task["description"] ?? ''),
          )
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String startTime;
  final String endTime;
  final Color categoryColor;
  final String description;
  const TaskCard({
    Key? key,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.categoryColor,
    required this.description,
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
          Text(title, style: const AppTextStyles().headingH5),
          Text(description,
              style: const AppTextStyles()
                  .bodyTextNormalRegular
                  .copyWith(color: AppColors.kBlack.withOpacity(0.8))),
          Text("$startTime - $endTime",
              style: const AppTextStyles()
                  .captionNormalRegular
                  .copyWith(color: AppColors.inactiveGrey)),
        ],
      ),
    );
  }
}

class TimeLineTileCustom extends StatelessWidget {
  final String category;
  const TimeLineTileCustom({
    Key? key,
    required this.category,
  }) : super(key: key);

  Color get itemColor {
    return category.isEmpty ? AppColors.inactiveGrey : AppColors.kRedDark;
  }

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      lineXY: 0,
      alignment: TimelineAlign.manual,
      isFirst: true,
      indicatorStyle: IndicatorStyle(
          indicatorXY: 0,
          width: AppSize.s12,
          indicator: Container(
            decoration: BoxDecoration(
                color: AppColors.kWhite,
                border: Border.all(color: itemColor, width: AppSize.s4),
                shape: BoxShape.circle),
          )),
      afterLineStyle: LineStyle(thickness: AppSize.s2, color: itemColor),
    );
  }
}
