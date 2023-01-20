import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_fate/data/hours_manager.dart';
import 'package:my_fate/data/model/task_model.dart';
import 'package:my_fate/data/sorted_tasks.dart';
import 'package:my_fate/presentation/view_model/base.dart';

class TaskManagerViewModel extends BaseViewModel {
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController titleController = TextEditingController();
  late final TextEditingController descriptionController =
      TextEditingController();
  // final TextEditingController startTime = TextEditingController(); // drop down
  // late final TextEditingController dateController =
  //     TextEditingController(); // Calender Picker

  String startTime = '';
  String category = "";
  int maxHours = 1;
  DateTime selectedDate = DateTime.now();
  int selectedNumberOfHours = 1;
  List<String> availableHours = [];
  bool timeInputIsEnabled = false;
  bool noOfHoursInputIsEnabled = false;
  FocusNode dateFocusNode = FocusNode();

  /// start Method is used by Edit Operation
  @override
  void start() {
    // dateFocusNode.addListener(() {
    //   if (!dateFocusNode.hasFocus) {
    //     log("Focus vanished");
    //     pickDate();
    //   }
    // });
    _focusNodeController();
  }

  @override
  void dispose() {
    titleController.dispose();
    // categoryController.dispose();
    // startTime.dispose();
    // hoursController.dispose();
    // dateController.dispose();
    dateFocusNode.removeListener(() {});
    super.dispose();
  }

  void addTask() {
    _insertTask(TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      startTime: startTime,
      category: category,
      date: dateFormatDDMMYYYY(selectedDate),
      hours: selectedNumberOfHours,
    ));
  }

  void pickDate() {
    if (datesOfSortedTasks.containsKey(dateFormatDDMMYYYY(selectedDate)) ==
        false) {
      datesOfSortedTasks[dateFormatDDMMYYYY(selectedDate)] = [];
      for (var k in hoursManager.keys) {
        hoursManager[k]![dateFormatDDMMYYYY(selectedDate)] = false;
      }
    }
    availableHours = _availableStartHours(dateFormatDDMMYYYY(selectedDate));
    log(availableHours.toString());
    timeInputIsEnabled = true;
  }

  void timePicked() {
    noOfHoursInputIsEnabled = true;
  }

  void _focusNodeController() {
    dateFocusNode.addListener(() {
      if (dateFocusNode.hasFocus) {
        log("has focus");
        if (!dateFocusNode.hasFocus) {}
      } else {
        log("didn't get focus");
        pickDate();
        log(availableHours.toString());
        log("something wrong");
      }
    });
  }

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
    log(startTime);
    int startHour = int.parse(startTime.split(":")[0]);
    for (int i = startHour + 1; i < 23; i++) {
      if (hoursManager[_intToTime(i)]![dateFormatDDMMYYYY(selectedDate)] !=
          false) {
        maxHours++;
      } else {
        log("max hours $maxHours");
        break;
      }
    }
    log(hoursManager.toString());
  }

  // Date Formatter
  String dateFormatDDMMYYYY(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date).toString();
  }

  DateTime convertToDate(String input) {
    return DateFormat("DD/MM/yyyy").parseStrict(input);
  }

  DateTime convertHourToDate(String hour) {
    return DateFormat("hh:mm").parseStrict(hour);
  }

  String convertToPM(DateTime time) {
    return DateFormat("h:mma").format(time);
  }

  // Private Functions Section

  /// Insertion Sort for Tasks
  void _insertionSortTask(String date) {
    for (int i = 0; i < datesOfSortedTasks[date]!.length; i++) {
      // the value that needs to be sorted called key
      TaskModel key = datesOfSortedTasks[date]![i];
      int j = i - 1;
      while (int.parse(datesOfSortedTasks[date]![j].startTime!.split(":")[0]) >
              int.parse(key.startTime!.split(":")[0]) &&
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
    log(task.toJson().toString());
    _bookHours();
    // sanity checkers lvl 1
    if (datesOfSortedTasks.containsKey(task.date)) {
      // sanity checker lvl 2
      if (datesOfSortedTasks[task.date!]!.isEmpty) {
        datesOfSortedTasks[task.date!]!.add(task);
      } else {
        int i = datesOfSortedTasks[task.date!]!.length - 1;
        List<TaskModel> list = datesOfSortedTasks[task.date!]!;
        while (i >= 0) {
          if (int.parse(list[i].startTime!.split(":")[0]) >
              int.parse(task.startTime!.split(":")[0])) {
            i--;
          } else {
            list.insert(i, task);
            break;
          }
        }
      }
    } else {
      datesOfSortedTasks[task.date!] = [task];
    }
  }

  String _intToTime(int i) => "${i >= 10 ? i : "0$i"}:00";

  void _bookHours() {
    List<String> bookedHours = [];
    for (int i = int.parse(startTime.split(":")[0]);
        i <= selectedNumberOfHours;
        i++) {
      bookedHours.add(_intToTime(i));
    }
    log("booked hours $bookedHours");
    for (var hour in bookedHours) {
      log(" hour to book $hour");
      hoursManager[hour]![dateFormatDDMMYYYY(selectedDate)] = true;
      log(' hour state ${hoursManager[hour]![dateFormatDDMMYYYY(selectedDate)]}');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }
}
