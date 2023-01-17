import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:my_fate/presentation/view/fragments/add_task.dart';
import 'package:my_fate/presentation/view/fragments/home_page.dart';
import 'package:my_fate/presentation/view/fragments/profile_page.dart';

import '../resources/colors_manager.dart';
import 'base.dart';

class NavBarViewModel extends BaseViewModel
    with ParentViewInput, ParentViewOutput {
  // This View Model
  // it's view should run a function
  // that change the current index value
  // and return a state class
  // stream controllers

  // TODO : remove braodcast() method it's only there for developing process
  final StreamController _streamController =
      StreamController<Widget>.broadcast();

  late final List _list;

  int _currentIndex = 0;

  // inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getPages();
    _postDataToView();
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  int get getCurrentIndex {
    return _currentIndex;
  }

  Color navColors(
      {required int i, Color secondaryColor = AppColors.inactiveGrey}) {
    return getCurrentIndex == i ? AppColors.primaryBlue : secondaryColor;
  }

  @override
  Sink get inputNavViewObject => _streamController.sink;

  // outputs
  @override
  Stream<Widget> get outputNavViewObject =>
      _streamController.stream.map((screen) => screen);

  // private functions
  List _getPages() =>
      [const HomePage(), const ADdTaskPage(), const ProfilePage()];

  void _postDataToView() {
    inputNavViewObject.add(_list[_currentIndex]);
  }
}

// inputs mean the orders that our view model will receive from our view
abstract class ParentViewInput {
  void onPageChanged(int index);

  Sink
      get inputNavViewObject; // this is the way to add data to the stream .. stream input
}

// outputs mean data or results that will be sent from our view model to our view
abstract class ParentViewOutput {
  Stream get outputNavViewObject;
}

class ParentIndexParams {
  final int intIndex;
  const ParentIndexParams({required this.intIndex});
}
