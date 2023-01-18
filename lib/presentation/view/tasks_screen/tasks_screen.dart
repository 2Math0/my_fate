import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/strings_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

import '../../resources/assets_manager.dart';
import 'components/date_picker.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: CustomScrollView(slivers: [
        TaskAppBar(
          title: AppStrings.personalTasks,
          description: AppStrings.taskDescription,
          size: size,
        ),
        SliverToBoxAdapter(
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
      ]),
    );
  }
}

class TaskAppBar extends StatelessWidget {
  final String title;
  final String description;
  final Size size;

  const TaskAppBar({
    Key? key,
    required this.title,
    required this.description,
    required this.size,
  }) : super(key: key);

  Size get preferredSize => Size.fromHeight(size.height * 0.14);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        snap: true,
        pinned: true,
        floating: true,
        expandedHeight: preferredSize.height,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              AppIcons.leftArrow,
              color: AppColors.kWhite,
              height: AppSize.s12,
            )),
        backgroundColor: AppColors.kBlack,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(
            left: size.width * 0.15,
            bottom: preferredSize.height * 0.2,
          ),
          title: Text(AppStrings.personalTasks,
              style: const AppTextStyles()
                  .headingH2
                  .copyWith(color: AppColors.kWhite)),
          background: Padding(
            padding: EdgeInsets.only(
                top: preferredSize.height * 0.9, left: size.width * 0.2),
            child: Text(
              AppStrings.taskDescription,
              style: const AppTextStyles()
                  .bodyTextLargeRegular
                  .copyWith(color: AppColors.kWhite.withOpacity(0.3)),
            ),
          ),
        ));
  }
}
