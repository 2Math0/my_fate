import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_fate/presentation/resources/assets_manager.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/strings_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';
import 'package:my_fate/presentation/view/tasks_screen/componentes/date_picker.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      appBar: TaskAppBar(
        title: AppStrings.personalTasks,
        description: AppStrings.taskDescription,
        size: size,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(AppPadding.p20),
          decoration: const BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppCircularRadius.cr24))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              DatePicker(),
              Text(AppStrings.taskDescription),
              Text(AppStrings.taskDescription),
              Text(AppStrings.taskDescription)
            ],
          ),
        ),
      ),
    );
  }
}

class TaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String description;
  final Size size;

  const TaskAppBar({
    Key? key,
    required this.title,
    required this.description,
    required this.size,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(size.height * 0.14);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: AppSize.s4),
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset(
                AppIcons.leftArrow,
                color: AppColors.kWhite,
                height: AppSize.s12,
              ))
        ],
      ),
      toolbarHeight: preferredSize.height,
      backgroundColor: AppColors.kBlack,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
            left: AppMargin.m48,
            top: preferredSize.height * 0.1,
            bottom: preferredSize.height * 0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(AppStrings.personalTasks,
                style: const AppTextStyles()
                    .headingH2
                    .copyWith(color: AppColors.kWhite)),
            Text(AppStrings.taskDescription,
                style: const AppTextStyles()
                    .bodyTextLargeRegular
                    .copyWith(color: AppColors.kWhite.withOpacity(0.3))),
          ],
        ),
      ),
    );
  }
}
