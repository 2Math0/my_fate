import 'package:flutter/material.dart';

class TaskTypeModel {
  IconData? iconData;
  String? title;
  String? lightColor;
  String? darkColor;
  int? leftNum;
  int? doneNum;

  TaskTypeModel(
      {this.iconData,
      this.title,
      this.lightColor,
      this.darkColor,
      this.leftNum,
      this.doneNum});

  TaskTypeModel.fromJson(Map<String, dynamic> json) {
    iconData = json["iconData"];
    title = json["title"];
    lightColor = json["lightColor"];
    darkColor = json["darkColor"];
    leftNum = json["leftNum"];
    doneNum = json["doneNum"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["iconData"] = iconData;
    data["title"] = title;
    data["lightColor"] = lightColor;
    data["darkColor"] = darkColor;
    data["leftNum"] = leftNum;
    data["doneNum"] = doneNum;
    return data;
  }
}
