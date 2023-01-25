import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_fate/data/name.dart';
import 'package:my_fate/presentation/resources/assets_manager.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/decoration_manager.dart';
import 'package:my_fate/presentation/resources/strings_manager.dart';
import 'package:my_fate/presentation/resources/utilities.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = name;
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.person,
                color: AppColors.kBlack, width: AppSize.s60),
            const SizedBox(height: AppSize.s38),
            SizedBox(
              width: const Utilities().width50(context),
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: controller,
                decoration: AppDecoration.formFieldDecoration(
                    hintText: AppStrings.userName),
                onChanged: (str) => name = str,
              ),
            )
          ],
        ),
      ),
    );
  }
}
