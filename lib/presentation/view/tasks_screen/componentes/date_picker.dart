import 'package:flutter/material.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final weekList = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  final dayList = ["24", '25', "26", "27", "28", "29", "30"];
  int selected = 4;

  TextStyle selectedColor(int i) {
    return const AppTextStyles().bodyTextLargeRegular.copyWith(
          color: selected == i ? AppColors.kBlack : AppColors.inactiveGrey,
          fontWeight: selected == i ? FontWeight.w900 : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s80,
      color: AppColors.kWhite,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int _) =>
            const SizedBox(width: AppSize.s4),
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            onTap: () => setState(() => selected = i),
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p8),
              decoration: BoxDecoration(
                color: selected == i ? AppColors.kBlack.withOpacity(0.1) : null,
                borderRadius: BorderRadius.circular(AppSize.s20),
              ),
              child: Column(
                children: [
                  Text(weekList[i], style: selectedColor(i)),
                  Text(dayList[i], style: selectedColor(i)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
