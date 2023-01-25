import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_fate/data/tasks_categories.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/strings_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';
import 'package:my_fate/presentation/view_model/task_screen_model.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../resources/assets_manager.dart';
import 'components/date_picker.dart';

class TaskScreen extends StatefulWidget {
  // ToDo : change the list by picking days
  // ToDo : add calender picker to pick a specific day with its week

  final String category;
  const TaskScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TasksScreenModel _viewModel = TasksScreenModel();

  @override
  void initState() {
    super.initState();
    _viewModel.todayWeek;
    _viewModel.importDayTasks(widget.category, _viewModel.today);
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: CustomScrollView(slivers: [
        // App Bar
        TaskAppBar(
          title: "${widget.category} ${AppStrings.tasks}",
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
            child: DatePicker(
              days: _viewModel.weekDays,
              selectedDay: _viewModel.today.weekday,
            ),
          ),
        ),
        if (_viewModel.tasks.isEmpty)
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
                (context, index) => _viewModel.representTasks(index),
                childCount: _viewModel.widgetList.length)),
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

// class TaskTimeLine extends StatelessWidget {
//   final TaskModel task;
//   const TaskTimeLine({Key? key, required this.task}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColors.kWhite,
//       padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: AppSize.s20,
//             child: TimeLineTileCustom(category: task.category!),
//           ),
//           Text(task.startTime!,
//               style: const AppTextStyles().bodyTextNormalRegular),
//           const SizedBox(width: AppMargin.m16),
//           Expanded(
//             // isDone
//             // hours number
//             //
//             child: TaskCard(
//               title: task.title!,
//               startTime: task.startTime!,
//               hours: task.hours!,
//               categoryColor: taskCategory[task.category]!.light,
//               description: task.description ?? '',
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class TaskCard extends StatelessWidget {
  final String title;
  final String startTime;
  final int hours;
  final Color categoryColor;
  final String description;
  const TaskCard({
    Key? key,
    required this.title,
    required this.startTime,
    required this.categoryColor,
    required this.description,
    required this.hours,
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
          // Text("$startTime - ${endTime}",
          //     style: const AppTextStyles()
          //         .captionNormalRegular
          //         .copyWith(color: AppColors.inactiveGrey)),
        ],
      ),
    );
  }
}

class TimeLineTileCustom extends StatelessWidget {
  final String? category;
  final bool isFirst;
  const TimeLineTileCustom({
    Key? key,
    this.category,
    required this.isFirst,
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
