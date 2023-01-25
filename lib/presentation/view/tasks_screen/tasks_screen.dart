import 'package:flutter/material.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/strings_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';
import 'package:my_fate/presentation/view_model/task_screen_model.dart';

import '../../shared_widgets/components/task_app_bar.dart';
import 'components/date_picker.dart';

class TaskScreen extends StatefulWidget {
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
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kWhite,
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
            color: AppColors.kBlack,
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p20),
              decoration: const BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppCircularRadius.cr24))),
              child: DatePicker(
                days: _viewModel.weekDays,
                selectedDay: _viewModel.today.weekday,
                onTap: (int i) {
                  setState(() {
                    _viewModel.selectNewDate(_viewModel.weekDays[i]);
                  });
                },
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Container(
                color: AppColors.kWhite,
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Text(AppStrings.tasks,
                    style: const AppTextStyles().headingH3))),
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
