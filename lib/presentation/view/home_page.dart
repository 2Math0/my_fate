import 'package:flutter/material.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/strings_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('${AppStrings.hi}, ${AppStrings.userName} 👋',
              style: const AppTextStyles()
                  .headingH2
                  .copyWith(color: AppColors.kBlack))),
      body: const Center(child: Text('Place holder')),
    );
  }
}
