import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_fate/app/converter.dart';
import 'package:my_fate/data/sorted_tasks.dart';
import 'package:my_fate/data/tasks_categories.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';
import 'package:my_fate/presentation/view_model/base.dart';

import '../../data/model/task_model.dart';
import '../resources/text_styles_manager.dart';
import '../view/tasks_screen/tasks_screen.dart';

class TasksScreenModel extends BaseViewModel {
  List<TaskModel> tasks = [];
  String date = '';
  List<String> weekDays = [];
  List widgetList = [];
  final DateTime today = DateTime.now();

  final List<String> dayHours = [
    "00:00",
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00"
  ];

  late final Converter converter = const Converter();

  @override
  void start() {
    widgetList = listBuilder();
  }

  @override
  void dispose() {}

  void importDayTasks(String category, DateTime day) {
    String date = converter.dateFormatDDMMYYYY(day);
    log(date);
    if (datesOfSortedTasks.containsKey(date)) {
      List temp = datesOfSortedTasks[date]!;
      for (TaskModel t in temp) {
        log(t.category.toString());
        log(t.title.toString());
        if (t.category == category.toLowerCase()) {
          tasks.add(t);
        }
      }
    }
    log(tasks.toString());
  }

  void get todayWeek {
    int dayNumber = today.weekday;
    log(dayNumber.toString());
    for (int i = dayNumber; i > 0; i--) {
      weekDays.add(converter.dayFormatter(today.subtract(Duration(days: i))));
    }
    weekDays.add(converter.dayFormatter(today));
    for (int i = 1; i < 7 - dayNumber; i++) {
      weekDays.add(converter.dayFormatter(today.add(Duration(days: i))));
    }
  }

  int tasksIndex = 0;
  int jumpIndex = 0;
  representTasks(int index) {
    if (widgetList[index].length > 1) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        color: AppColors.kWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: AppSize.s20,
              child: TimeLineTileCustom(
                category: widgetList[index][1].category,
                isFirst: index == 0,
              ),
            ),
            Text(widgetList[index][0],
                style: const AppTextStyles().bodyTextNormalRegular),
            const SizedBox(width: AppMargin.m16),
            Expanded(
              // isDone
              // hours number
              //
              child: TaskCard(
                title: widgetList[index][1].title!,
                startTime: widgetList[index][1].startTime!,
                hours: widgetList[index][1].hours!,
                categoryColor:
                    taskCategory[widgetList[index][1].category]!.light,
                description: widgetList[index][1].description ?? '',
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        color: AppColors.kWhite,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: AppSize.s20,
              child: TimeLineTileCustom(isFirst: index == 0),
            ),
            Text(widgetList[index][0],
                style: const AppTextStyles()
                    .bodyTextNormalRegular
                    .copyWith(color: AppColors.inactiveGrey)),
            const SizedBox(width: AppMargin.m16),
          ],
        ),
      );
    }
  }

  List listBuilder() {
    List list = [];
    for (String hour in dayHours) {
      if (jumpIndex > 0) {
        jumpIndex--;
        continue;
      }
      if (tasksIndex < tasks.length) {
        if (hour == tasks[tasksIndex].startTime) {
          list.add([hour, tasks[tasksIndex]]);
          jumpIndex = tasks[tasksIndex].hours! - 1;
          tasksIndex++;
        } else {
          list.add([hour]);
        }
      } else {
        list.add([hour]);
      }
    }
    return list;
  }
}
