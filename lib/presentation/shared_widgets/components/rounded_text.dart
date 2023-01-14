import 'package:flutter/material.dart';

import '../../resources/decoration_manager.dart';
import '../../resources/values_manager.dart';

class NumTextRoundedBG extends StatelessWidget {
  const NumTextRoundedBG({
    Key? key,
    required this.bgColor,
    required this.textColor,
    required this.txt,
  }) : super(key: key);

  final Color bgColor;
  final String txt;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.defaultBoxDecoration(bgColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p8, horizontal: AppPadding.p12),
        child: Text(txt,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: textColor)),
      ),
    );
  }
}
