import 'package:flutter/material.dart';
import 'package:my_fate/data/hours_manager.dart';
import 'package:my_fate/data/model/task_model.dart';
import 'package:my_fate/data/sorted_tasks.dart';
import 'package:my_fate/presentation/view_model/base.dart';

class AddTaskViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startTime = TextEditingController(); // drop down
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController dateController =
      TextEditingController(); // Calender Picker
  final TextEditingController categoryController =
      TextEditingController(); // dropdown

  List<String> availableHours = [];

  /// start Method is used by Edit Operation
  @override
  void start() {}

  @override
  void dispose() {
    titleController.dispose();
    categoryController.dispose();
    startTime.dispose();
    hoursController.dispose();
    dateController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  void addTask() {
    _insertTask(TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      startTime: startTime.text,
      category: categoryController.text,
      date: dateController.text,
      hours: hoursController.text,
    ));
  }

  String? validateRequired(String? text) {
    if (text != null) {
      if (text.isEmpty) {
        return "This a Required Field";
      }
      return null;
    }
    return null;
  }

  void pickDate() {
    availableHours = _availableStartHours(dateController.text);
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

  void _bookHours() {
    List<String> bookedHours = [];
    for (int i = int.parse(startTime.text.split(":")[0]);
        i < int.parse(hoursController.text);
        i++) {
      bookedHours.add("${i > 10 ? i : "0$i"}:00");
    }
    for (var hour in bookedHours) {
      hoursManager[hour]![dateController.text] = true;
    }
  }
}
