import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fate/app/validation/required_validator.dart';
import 'package:my_fate/data/tasks_categories.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/shared_widgets/components/custom_drop_down_menu.dart';
import 'package:my_fate/presentation/view_model/task_manager_view_model.dart';

import '../../resources/strings_manager.dart';
import '../../resources/text_styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../shared_widgets/components/task_app_bar.dart';
import '../../shared_widgets/components/text_field.dart';

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
                          hintText: "Description"),
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
                            dateOrder: DatePickerDateOrder.ydm,
                            onDateTimeChanged: (DateTime newDateTime) {
                              _viewModel.selectedDate = newDateTime;
                              setState(() {
                                _viewModel.pickDate();
                              });

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
                          onPressed: () =>
                              _viewModel.validateAddingTask(context),
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
