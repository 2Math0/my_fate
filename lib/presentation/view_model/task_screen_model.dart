import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_fate/app/converter.dart';
import 'package:my_fate/data/hours_manager.dart';
import 'package:my_fate/data/sorted_tasks.dart';
import 'package:my_fate/data/tasks_categories.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/strings_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';
import 'package:my_fate/presentation/view/tasks_screen/components/time_line.dart';
import 'package:my_fate/presentation/view_model/base.dart';

import '../../data/model/task_model.dart';
import '../resources/text_styles_manager.dart';
import '../shared_widgets/components/task_card.dart';

class TasksScreenModel extends BaseViewModel {
  List<TaskModel> tasks = [];
  List<DateTime> weekDays = [];
  List widgetList = [];
  DateTime today = DateTime.now();

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
    importDayTasks(today);
    widgetList = listBuilder();
  }

  @override
  void dispose() {}

  void importDayTasks(DateTime day) {
    String date = converter.dateFormatDDMMYYYY(day);
    log(date);
    if (datesOfSortedTasks.containsKey(date)) {
      List temp = datesOfSortedTasks[date]!;
      for (TaskModel t in temp) {
        log(t.category.toString());
        log(t.title.toString());
        // if (t.category == category.toLowerCase()) {
        tasks.add(t);
        // }
      }
    }
    log(tasks.toString());
  }

  void get todayWeek {
    int dayNumber = today.weekday;
    log(dayNumber.toString());
    for (int i = dayNumber; i > 0; i--) {
      weekDays.add(today.subtract(Duration(days: i)));
    }
    weekDays.add(today);
    for (int i = 1; i < 7 - dayNumber; i++) {
      weekDays.add(today.add(Duration(days: i)));
    }
  }

  Map tasksState() {
    importDayTasks(DateTime.now());
    Map dic = {
      AppStrings.personal.toLowerCase(): {'done': 0, 'not done': 0},
      AppStrings.work.toLowerCase(): {'done': 0, 'not done': 0},
      AppStrings.health.toLowerCase(): {'done': 0, 'not done': 0},
    };
    for (TaskModel task in tasks) {
      task.isDone!
          ? dic[task.category]["done"] = dic[task.category]["done"] + 1
          : dic[task.category]["not done"] = dic[task.category]["not done"] + 1;
    }
    return dic;
  }

  void selectNewDate(DateTime date) {
    today = date;
    tasks = [];
    tasksIndex = 0;
    jumpIndex = 0;
    start();
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
                isLast: widgetList.length - 1 == index,
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
                isDone: widgetList[index][1].isDone!,
                categoryColor:
                    taskCategory[widgetList[index][1].category]!.light,
                description: widgetList[index][1].description ?? '',
                onDelete: () {
                  leashHours(
                      startTime: widgetList[index][1].startTime!,
                      hours: widgetList[index][1].hours!,
                      date: today);
                  datesOfSortedTasks[converter.dateFormatDDMMYYYY(today)]!
                      .removeAt(widgetList[index][2]);
                  widgetList[index].removeAt(1);
                },
                onEdit: () {},
                onDone: () {
                  if (widgetList[index][1].isDone == false) {
                    datesOfSortedTasks[converter.dateFormatDDMMYYYY(today)]![
                            widgetList[index][2]]
                        .isDone = true;
                    widgetList[index][1].isDone = true;
                  } else {
                    datesOfSortedTasks[converter.dateFormatDDMMYYYY(today)]![
                            widgetList[index][2]]
                        .isDone = false;
                    widgetList[index][1].isDone = false;
                  }
                },
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
              child: TimeLineTileCustom(
                isFirst: index == 0,
                isLast: widgetList.length - 1 == index,
              ),
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

  void leashHours(
      {required String startTime, required int hours, required DateTime date}) {
    List<String> bookedHours = [];
    for (int i = converter.parsingHourToInt(startTime);
        i < converter.parsingHourToInt(startTime) + hours;
        i++) {
      bookedHours.add(converter.intToTime(i));
    }
    for (var hour in bookedHours) {
      hoursManager[hour]![converter.dateFormatDDMMYYYY(date)] = false;
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
          list.add([hour, tasks[tasksIndex], tasksIndex]);
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
