class TaskModel {
  /// the [title] that the task hold like the name of the task
  String? title;

  /// [description] is [nullable] [not required field] which the user fill to
  /// give more details about the task
  String? description;

  /// the [startTime] is the field that's responsible to schedule the task
  /// with start time
  /// * push notification alert is created
  /// * the hour with same value of startTime will hold true value in date key
  /// Note book hour structure is
  /// ```dart
  /// {
  ///   hour:{
  ///     date: boolean(booked(true) or not(false))
  ///      }
  /// }
  /// ```
  String? startTime;

  /// [hours] represent number of hours needed to complete the task
  int? hours;

  /// the [date] which the task is assigned
  /// the date is a required parameter for push notification
  String? date;

  /// [category] is the parameter that assign the task to specific category
  /// it holds with it the unique color
  String? category;

  /// [isDone] is the parameter that defines the state of completeness of the task
  bool? isDone;

  /// ## Definition
  /// TaskModel is the model of tasks in the app it controls
  /// Adding, Categorize, Edit, Delete, isDone Tasks in constant time
  ///
  /// ## Parameters
  /// the `title` that the task hold like the name of the task [@title]
  ///
  /// [description] is [nullable] [not required field] which the user fill to
  /// give more details about the task
  ///
  /// the [startTime] is the field that's responsible to schedule the task
  /// with start time
  /// * push notification alert is created
  /// * the hour with same value of startTime will hold true value in date key
  /// Note book hour structure is
  /// ```dart
  /// {
  ///   hour:{
  ///     date: boolean(booked(true) or not(false))
  ///      }
  /// }
  /// ```
  ///
  /// [hours] represent number of hours needed to complete the task
  ///
  /// the [date] which the task is assigned
  /// the date is a required parameter for push notification
  ///
  /// [category] is the parameter that assign the task to specific category
  /// it holds with it the unique color

  TaskModel(
      {this.title,
      this.description,
      this.startTime,
      this.hours,
      this.date,
      this.category,
      this.isDone = false});

  TaskModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    startTime = json["start time"];
    hours = json["hours"];
    date = json["date"];
    category = json["category"];
    isDone = json["isDone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["description"] = description;
    data["start time"] = startTime;
    data["hours"] = hours;
    data["date"] = date;
    data["category"] = category;
    data["isDone"] = isDone;
    return data;
  }
}
