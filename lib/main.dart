import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_fate/data/model/task_model.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';

import 'app/app.dart';

late Box<Map<String, bool>> hoursBox;
late Box<List<TaskModel>> tasksBoxByDate;
late Box<ColorShades> categoriesBox;
late Box profileBox;
Future<void> main() async {
  // Hive db
  await Hive.initFlutter();

  tasksBoxByDate = await Hive.openBox('tasksBox');
  hoursBox = await Hive.openBox('hoursBox');
  categoriesBox = await Hive.openBox('categoriesBox');
  profileBox = await Hive.openBox("profile");

  if (hoursBox.containsKey('00:00') == false) {
    // first time run
    hoursBox.put("00:00", {});
    hoursBox.put("01:00", {});
    hoursBox.put("02:00", {});
    hoursBox.put("03:00", {});
    hoursBox.put("04:00", {});
    hoursBox.put("05:00", {});
    hoursBox.put("06:00", {});
    hoursBox.put("07:00", {});
    hoursBox.put("08:00", {});
    hoursBox.put("09:00", {});
    hoursBox.put("10:00", {});
    hoursBox.put("11:00", {});
    hoursBox.put("12:00", {});
    hoursBox.put("13:00", {});
    hoursBox.put("14:00", {});
    hoursBox.put("15:00", {});
    hoursBox.put("16:00", {});
    hoursBox.put("17:00", {});
    hoursBox.put("18:00", {});
    hoursBox.put("19:00", {});
    hoursBox.put("20:00", {});
    hoursBox.put("21:00", {});
    hoursBox.put("22:00", {});
    hoursBox.put("23:00", {});
  }
  // run app
  runApp(const MyApp());
}
