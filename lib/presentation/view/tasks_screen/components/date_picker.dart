import 'package:flutter/material.dart';
import 'package:my_fate/app/converter.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/utilities.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

class DatePicker extends StatefulWidget {
  final List<DateTime> days;
  final int selectedDay;
  final void Function(int i) onTap;
  const DatePicker(
      {Key? key,
      required this.days,
      required this.selectedDay,
      required this.onTap})
      : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final weekList = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  int selected = 0;

  TextStyle selectedColor(int i) {
    return const AppTextStyles().bodyTextLargeRegular.copyWith(
          color: selected == i ? AppColors.kBlack : AppColors.inactiveGrey,
          fontWeight: selected == i ? FontWeight.w900 : null,
        );
  }

  void getSelection() {
    selected = widget.selectedDay;
  }

  @override
  void initState() {
    super.initState();
    getSelection();
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
            onTap: () => setState(() {
              widget.onTap(i);
              selected = i;
            }),
            child: Container(
              width: (Utilities.getWidth(context) / weekList.length) -
                  AppPadding.p4,
              padding: const EdgeInsets.all(AppPadding.p8),
              decoration: BoxDecoration(
                color: selected == i ? AppColors.kBlack.withOpacity(0.1) : null,
                borderRadius: BorderRadius.circular(AppSize.s20),
              ),
              child: Column(
                children: [
                  Text(weekList[i], style: selectedColor(i)),
                  Text(const Converter().dayFormatter(widget.days[i]),
                      style: selectedColor(i)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
