import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_fate/presentation/resources/assets_manager.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/strings_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../shared_widgets/components/task_type.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.kBlack,
                  radius: AppSize.s16,
                  child: SvgPicture.asset(
                    AppIcons.person,
                    color: AppColors.kWhite,
                    width: AppSize.s16,
                  ),
                ),
                const SizedBox(width: AppPadding.p16),
                Text('${AppStrings.hi}, ${AppStrings.userName}! 👋',
                    style: Theme.of(context).textTheme.headline2),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p16, horizontal: AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TypeWriterText(
                      maintainSize: true,
                      text: Text(
                        "Welcome ${'🤝'.characters} to Home page ${'🏠'.characters}!,"
                        "\nThis is where your tasks ${(('📝').characters)} are Categorized "
                        "${'🗂'.characters}️.\nArrange your tasks,\nFinish ${'✔️'.characters} them "
                        "\nand See ${'👀️'.characters} the results :::::::",
                        softWrap: true,
                        style:
                            const AppTextStyles().captionLargeRegular.copyWith(
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
                  Wrap(
                    spacing: AppPadding.p16,
                    runSpacing: AppPadding.p16,
                    runAlignment: WrapAlignment.spaceBetween,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      TaskTypeItem(
                          name: AppStrings.personal,
                          onTap: () {},
                          color: AppColors.kYellow,
                          darkColor: AppColors.kYellowDark,
                          lightColor: AppColors.kYellowLight,
                          svgIcon: AppIcons.person,
                          leftNum: 12,
                          doneNum: 1),
                      TaskTypeItem(
                          name: AppStrings.work,
                          onTap: () {},
                          color: AppColors.kRed,
                          darkColor: AppColors.kRedDark,
                          lightColor: AppColors.kRedLight,
                          svgIcon: AppIcons.bag,
                          leftNum: 12,
                          doneNum: 1),
                      TaskTypeItem(
                          name: AppStrings.health,
                          onTap: () {},
                          color: AppColors.kBlue,
                          darkColor: AppColors.kBlueDark,
                          lightColor: AppColors.kBlueLight,
                          svgIcon: AppIcons.heart,
                          leftNum: 12,
                          doneNum: 0),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
