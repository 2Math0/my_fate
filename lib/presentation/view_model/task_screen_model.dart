import 'dart:developer';

import 'package:my_fate/app/converter.dart';
import 'package:my_fate/data/sorted_tasks.dart';
import 'package:my_fate/presentation/view_model/base.dart';

import '../../data/model/task_model.dart';

class TasksScreenModel extends BaseViewModel {
  List<TaskModel> tasks = [];
  String date = '';
  List<String> weekDays = [];
  DateTime today = DateTime.now();

  late final Converter converter = const Converter();

  @override
  void start() {}

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
        log(category);
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
}
