import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_fate/data/hours_manager.dart';
import 'package:my_fate/data/sorted_tasks.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/view_model/add_task_view_model.dart';

import '../../resources/decoration_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles_manager.dart';
import '../../resources/values_manager.dart';
import '../tasks_screen/tasks_screen.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final AddTaskViewModel _viewModel = AddTaskViewModel();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        TaskAppBar(
          title: AppStrings.addTask,
          description: 'something',
          size: size,
          bgColor: AppColors.kWhite,
          textColor: AppColors.kBlack,
          isNested: false,
        ),
        SliverToBoxAdapter(
          child: Container(
              color: AppColors.kWhite,
              child: Form(
                  key: _viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataField(
                          controller: _viewModel.titleController,
                          hintText: "Title",
                          validate: _viewModel.validateRequired),
                      DataField(
                          controller: _viewModel.descriptionController,
                          hintText: "Description",
                          validate: _viewModel.validateRequired),
                      DataField(
                          controller: _viewModel.categoryController,
                          hintText: "Category",
                          validate: _viewModel.validateRequired),
                      DataField(
                          controller: _viewModel.dateController,
                          hintText: "Day",
                          validate: _viewModel.validateRequired),
                      DataField(
                          controller: _viewModel.startTime,
                          hintText: "Time",
                          validate: _viewModel.validateRequired),
                      DataField(
                          controller: _viewModel.hoursController,
                          hintText: "Number of Hours",
                          validate: _viewModel.validateRequired),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_viewModel.formKey.currentState!.validate()) {
                              _viewModel.addTask();
                              log(datesOfSortedTasks.toString());
                              log(hoursManager.toString());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.primaryBlue),
                          child: Text(AppStrings.addTask,
                              style: const AppTextStyles()
                                  .headingH3
                                  .copyWith(color: AppColors.kWhite)),
                        ),
                      ),
                      // added to prevent bottom nav bar from blocking the fields
                      const SizedBox(height: AppSize.s100),
                    ],
                  ))),
        ),
      ],
    );
  }
}

class DataField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String?) validate;
  final bool isTwo;
  const DataField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validate,
    this.isTwo = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: isTwo
            ? (size.width * 0.5) - (AppPadding.p6 + (AppPadding.p8 * 2))
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p16, horizontal: AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hintText,
                style: const AppTextStyles().headingH5,
              ),
              const SizedBox(height: AppMargin.m8),
              TextFormField(
                  style: const AppTextStyles()
                      .formTextFill
                      .copyWith(color: AppColors.kBlack),
                  decoration: AppDecoration.formFieldDecoration(hintText),
                  controller: controller,
                  validator: (val) {
                    validate(val);
                  }),
            ],
          ),
        ));
  }
}
