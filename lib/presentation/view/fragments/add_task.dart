import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fate/app/validation/base_validator.dart';
import 'package:my_fate/app/validation/required_validator.dart';
import 'package:my_fate/data/tasks_categories.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/view_model/task_manager_view_model.dart';

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
  final TaskManagerViewModel _viewModel = TaskManagerViewModel();

  @override
  void initState() {
    super.initState();
    setState(() {
      _viewModel.start();
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

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
                          validator: RequiredValidator()),
                      DataField(
                          controller: _viewModel.descriptionController,
                          hintText: "Description",
                          validator: RequiredValidator()),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: CustomDropDown(
                          hintText: AppStrings.pickACategory,
                          items: taskCategory.keys.toList(),
                          fillColor: taskCategory[_viewModel.category] == null
                              ? Colors.transparent
                              : taskCategory[_viewModel.category]!.light,
                          onChanged: (val) =>
                              setState(() => _viewModel.category = val!),
                          validator: RequiredValidator(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p16),
                        child: Text(
                          'Pick a Day',
                          style: const AppTextStyles()
                              .headingH5
                              .copyWith(color: AppColors.kBlack),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: SizedBox(
                          height: AppSize.s100,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: _viewModel.selectedDate,
                            onDateTimeChanged: (DateTime newDateTime) {
                              setState(() {
                                _viewModel.pickDate();
                              });
                              _viewModel.selectedDate = newDateTime;
                              log(newDateTime.toString());
                              // Do something
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: CustomDropDown(
                            hintText: AppStrings.pickAnHour,
                            validator: RequiredValidator(),
                            items: _viewModel.availableHours,
                            onChanged: (val) {
                              _viewModel.startTime = val!;
                              setState(() => _viewModel
                                  .availableNumberOfHoursUponStartTime);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: CustomDropDown(
                            hintText: AppStrings.numberOfHours,
                            items: List<int>.generate(
                                _viewModel.maxHours, (i) => i + 1),
                            onChanged: (val) {
                              return _viewModel.selectedNumberOfHours = val!;
                            }),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => _viewModel.validateAddingTask(),
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
  final BaseValidator? validator;
  final bool isTwo;
  final bool isEnabled;
  final TextInputType keyboardType;
  final FocusNode? onEditingComplete;
  const DataField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isTwo = false,
    this.keyboardType = TextInputType.text,
    this.isEnabled = true,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: isTwo ? (size.width * 0.5) : null,
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
                  focusNode: onEditingComplete,
                  enabled: isEnabled,
                  keyboardType: keyboardType,
                  style: const AppTextStyles()
                      .formTextFill
                      .copyWith(color: AppColors.kBlack),
                  decoration: AppDecoration.formFieldDecoration(
                      hintText: hintText, isEnabled: isEnabled),
                  controller: controller,
                  validator: (val) {
                    if (validator == null) {
                      return null;
                    } else if (!validator!.validate(val)) {
                      return validator!.getMessage();
                    }
                    return null;
                  }),
            ],
          ),
        ));
  }
}

class CustomDropDown extends StatelessWidget {
  final List<dynamic> items;
  final Function(dynamic) onChanged;
  final Color? fillColor;
  final BaseValidator? validator;
  final String hintText;
  final VoidCallback? onTap;
  const CustomDropDown(
      {Key? key,
      required this.items,
      required this.onChanged,
      this.fillColor = AppColors.kWhite,
      this.validator,
      required this.hintText,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText,
            style: const AppTextStyles()
                .headingH5
                .copyWith(color: AppColors.kBlack)),
        const SizedBox(height: AppMargin.m8),
        ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField(
              onTap: onTap,
              validator: (val) {
                if (validator == null) {
                  return null;
                } else if (!validator!.validate(val)) {
                  return validator!.getMessage();
                }
                return null;
              },
              decoration: AppDecoration.formFieldDecoration(hintText: "")
                  .copyWith(fillColor: fillColor, filled: true),
              elevation: 0,
              borderRadius: BorderRadius.circular(AppCircularRadius.cr24),
              hint: Text(
                hintText,
                style: const AppTextStyles()
                    .bodyTextNormalRegular
                    .copyWith(color: AppColors.inactiveGrey),
              ),
              isExpanded: true,
              items: items.map((dynamic value) {
                return DropdownMenuItem<dynamic>(
                  value: value,
                  child: Text(
                    "$value",
                    style: const AppTextStyles()
                        .formTextFill
                        .copyWith(color: AppColors.kBlack),
                  ),
                );
              }).toList(),
              onChanged: onChanged),
        ),
      ],
    );
  }
}
