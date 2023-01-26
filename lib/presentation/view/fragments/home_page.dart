import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_fate/data/name.dart';
import 'package:my_fate/presentation/resources/assets_manager.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/strings_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/utilities.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';
import 'package:my_fate/presentation/view/tasks_screen/tasks_screen.dart';
import 'package:my_fate/presentation/view_model/task_screen_model.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../shared_widgets/components/task_type.dart';

class HomePage extends StatelessWidget {
  // ToDo : count what is left and isDone in tasks by Today's Date
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double wrapItemsSize() {
      /// Every Item get half of the screen
      /// app padding horizontally on parent by 16
      /// app padding in space between items by 16
      /// divided by two as width is divided also
      return (size.width / 2) - AppPadding.p16 - AppPadding.p8;
    }

    Map leftAndDone = TasksScreenModel().tasksState();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p16, horizontal: AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  CircleAvatar(
                      backgroundColor: AppColors.kBlack,
                      radius: AppSize.s16,
                      child: SvgPicture.asset(
                        AppIcons.person,
                        color: AppColors.kWhite,
                        width: AppSize.s16,
                      )),
                  const SizedBox(width: AppPadding.p16),
                  Text('${AppStrings.hi}, $name! 👋',
                      style: Theme.of(context).textTheme.displayMedium),
                ]),
                const SizedBox(height: AppMargin.m16),
                TypeWriterText(
                    maintainSize: true,
                    text: Text(
                      "Welcome to Home page!"
                      "\nThis is where your tasks are Categorized"
                      "\nArrange your tasks,\nFinish them "
                      "\nand See the results",
                      softWrap: true,
                      style: const AppTextStyles().captionLargeRegular.copyWith(
                            fontFamily: GoogleFonts.dmMono().fontFamily,
                            color: AppColors.kBlack,
                          ),
                    ),
                    duration: const Duration(milliseconds: 60)),
                const SizedBox(height: AppMargin.m16),
                Text(
                  AppStrings.tasks,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: AppMargin.m16),
                IntrinsicWidth(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: AppPadding.p16,
                    runSpacing: AppPadding.p16,
                    runAlignment: WrapAlignment.spaceBetween,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      TaskTypeItem(
                          size: wrapItemsSize(),
                          name: AppStrings.personal,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const TaskScreen(
                                      category: AppStrings.personal))),
                          color: AppColors.yellow,
                          svgIcon: AppIcons.person,
                          leftNum:
                              leftAndDone[AppStrings.personal.toLowerCase()]
                                      ["not done"] ??
                                  0,
                          doneNum:
                              leftAndDone[AppStrings.personal.toLowerCase()]
                                      ["done"] ??
                                  0),
                      TaskTypeItem(
                        size: wrapItemsSize(),
                        name: AppStrings.work,
                        color: ColorRed(),
                        svgIcon: AppIcons.bag,
                        leftNum: leftAndDone[AppStrings.work.toLowerCase()]
                                ["not done"] ??
                            0,
                        doneNum: leftAndDone[AppStrings.work.toLowerCase()]
                                ["done"] ??
                            0,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const TaskScreen(
                                    category: AppStrings.work))),
                      ),
                      TaskTypeItem(
                          size: wrapItemsSize(),
                          name: AppStrings.health,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const TaskScreen(
                                      category: AppStrings.health))),
                          color: ColorBlue(),
                          svgIcon: AppIcons.heart,
                          leftNum: leftAndDone[AppStrings.health.toLowerCase()]
                                  ["not done"] ??
                              0,
                          doneNum: leftAndDone[AppStrings.health.toLowerCase()]
                                  ["done"] ??
                              0),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: AppColors.inactiveGrey,
                        radius: AppCircularRadius.cr66,
                        onTap: () => Utilities.customSnackBar(
                            message:
                                "Adding Categories will be added in next update",
                            context: context),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          color: AppColors.inactiveGrey,
                          radius: const Radius.circular(AppCircularRadius.cr24),
                          dashPattern: const [8, 12, 8, 12],
                          strokeWidth: 2,
                          strokeCap: StrokeCap.round,
                          // strokeCap: StrokeCap.round,
                          child: SizedBox(
                            /// minus four as strokeWidth take space from left and right, up and bottom
                            height: wrapItemsSize() - 4,
                            width: wrapItemsSize() - 4,
                            child: Center(
                              child: Text(
                                "+ ${AppStrings.add}",
                                style: const AppTextStyles().headingH3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
