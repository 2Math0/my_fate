import 'package:flutter/material.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/strings_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

import '../shared_widgets/components/task_type.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('${AppStrings.hi}, ${AppStrings.userName}! 👋',
                style: Theme.of(context).textTheme.headline2)),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.tasks,
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: AppMargin.m16),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: AppSize.s16,
                mainAxisSpacing: AppSize.s16,
                shrinkWrap: true,
                children: const [
                  TaskTypeItem(
                      color: AppColors.kYellow,
                      darkColor: AppColors.kYellowDark,
                      lightColor: AppColors.kYellowLight,
                      icon: Icons.person,
                      leftNum: 12,
                      doneNum: 1),
                  TaskTypeItem(
                      color: AppColors.kRed,
                      darkColor: AppColors.kRedDark,
                      lightColor: AppColors.kRedLight,
                      icon: Icons.work,
                      leftNum: 12,
                      doneNum: 1),
                  TaskTypeItem(
                      color: AppColors.kBlue,
                      darkColor: AppColors.kBlueDark,
                      lightColor: AppColors.kBlueLight,
                      icon: Icons.favorite_rounded,
                      leftNum: 12,
                      doneNum: 0),
                ],
              ),
            ],
          ),
        ));
  }
}
