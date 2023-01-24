import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_fate/app/converter.dart';
import 'package:my_fate/data/hours_manager.dart';
import 'package:my_fate/data/model/task_model.dart';
import 'package:my_fate/data/sorted_tasks.dart';
import 'package:my_fate/presentation/view_model/base.dart';

class TaskManagerViewModel extends BaseViewModel {
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController titleController = TextEditingController();
  late final TextEditingController descriptionController =
      TextEditingController();

  late final Converter converter = const Converter();

  String startTime = '';
  String category = "";
  int maxHours = 1;
  DateTime selectedDate = DateTime.now();
  int selectedNumberOfHours = 1;
  List<String> availableHours = [];
  bool timeInputIsEnabled = false;
  bool noOfHoursInputIsEnabled = false;

  /// start Method is used by Edit Operation
  @override
  void start() {
    pickDate();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void addTask() => _insertTask(TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        startTime: startTime,
        category: category,
        date: converter.dateFormatDDMMYYYY(selectedDate),
        hours: selectedNumberOfHours,
      ));

  void pickDate() {
    if (datesOfSortedTasks
            .containsKey(converter.dateFormatDDMMYYYY(selectedDate)) ==
        false) {
      datesOfSortedTasks[converter.dateFormatDDMMYYYY(selectedDate)] = [];
      for (String k in hoursManager.keys) {
        hoursManager[k]![converter.dateFormatDDMMYYYY(selectedDate)] = false;
      }
    }
    _assignAvailableHours();
    timeInputIsEnabled = true;
  }

  void _assignAvailableHours() => availableHours =
      _availableStartHours(converter.dateFormatDDMMYYYY(selectedDate));

  void validateAddingTask() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      log("adding task");
      addTask();
      _assignAvailableHours();
      formKey.currentState!.reset();
      titleController.clear();
      descriptionController.clear();
    }
  }

  void timePicked() => noOfHoursInputIsEnabled = true;

  /// Create a list of all available hours to book for a task
  List<String> _availableStartHours(String date) {
    List<String> list = [];
    for (String k in hoursManager.keys) {
      if (hoursManager[k]!.containsKey(date)) {
        if (hoursManager[k]![date] == false) {
          list.add(k);
        }
      } else {
        hoursManager[k]![date] = false;
        list.add(k);
      }
    }

    return list;
  }

  void get availableNumberOfHoursUponStartTime {
    int startHour = _parsingHourToInt(startTime);
    maxHours = 0;
    for (int i = startHour; i <= 23; i++) {
      if (hoursManager[_intToTime(i)]![
              converter.dateFormatDDMMYYYY(selectedDate)] ==
          false) {
        maxHours++;
      } else {
        break;
      }
    }
  }

  // Date Formatter

  // Private Functions Section

  /// Insertion Sort for Tasks
  void _insertionSortTask(String date) {
    for (int i = 0; i < datesOfSortedTasks[date]!.length; i++) {
      // the value that needs to be sorted called key
      TaskModel key = datesOfSortedTasks[date]![i];
      int j = i - 1;
      while (_parsingHourToInt(datesOfSortedTasks[date]![j].startTime!) >
              _parsingHourToInt(key.startTime!) &&
          j >= 0) {
        datesOfSortedTasks[date]![j + 1] = datesOfSortedTasks[date]![j];
        // that line make the while loop goes on
        // as it compares key with the rest of list in backwards
        j -= 1;
        datesOfSortedTasks[date]![j + 1] = key;
      }
    }
  }

  void _insertTask(TaskModel task) {
    _bookHours();
    // sanity checkers lvl 1
    if (datesOfSortedTasks.containsKey(task.date)) {
      // sanity checker lvl 2
      if (datesOfSortedTasks[task.date!]!.isEmpty) {
        datesOfSortedTasks[task.date!]!.add(task);
      } else {
        int length = datesOfSortedTasks[task.date!]!.length;
        for (int i = 0; i < length; i++) {
          if (_parsingHourToInt(datesOfSortedTasks[task.date!]![i].startTime!) >
              _parsingHourToInt(task.startTime!)) {
            datesOfSortedTasks[task.date!]!.insert(i, task);
            break;
          }
          // in case it's the bigger hour in the list
          // the above loop condition won't insert the task then
          else if (i == length - 1) {
            datesOfSortedTasks[task.date!]!.add(task);
            break;
          }
        }
      }
    } else {
      datesOfSortedTasks[task.date!] = [task];
    }
  }

  String _intToTime(int i) => "${i >= 10 ? i : "0$i"}:00";
  int _parsingHourToInt(String time) => int.parse(time.split(":")[0]);

  void _bookHours() {
    List<String> bookedHours = [];
    for (int i = _parsingHourToInt(startTime);
        i < _parsingHourToInt(startTime) + selectedNumberOfHours;
        i++) {
      bookedHours.add(_intToTime(i));
    }
    for (var hour in bookedHours) {
      hoursManager[hour]![converter.dateFormatDDMMYYYY(selectedDate)] = true;
    }
  }
}
