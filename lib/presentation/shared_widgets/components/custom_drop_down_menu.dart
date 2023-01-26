import 'package:flutter/material.dart';
import 'package:my_fate/app/validation/base_validator.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/decoration_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

class CustomDropDown extends StatelessWidget {
  final List<dynamic> items;
  final Function(dynamic) onChanged;
  final Color? fillColor;
  final BaseValidator? validator;
  final Color? dropDownColor;
  final String hintText;
  final VoidCallback? onTap;
  const CustomDropDown(
      {Key? key,
      required this.items,
      required this.onChanged,
      this.fillColor = AppColors.kWhite,
      this.validator,
      required this.hintText,
      this.onTap,
      this.dropDownColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText,
            style: const AppTextStyles()
                .headingH5
                .copyWith(color: AppColors.kBlack)),
        const SizedBox(height: AppMargin.m8),
        ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField(
              dropdownColor: dropDownColor,
              onTap: onTap,
              validator: (val) {
                if (validator == null) {
                  return null;
                } else if (!validator!.validate(val)) {
                  return validator!.getMessage();
                }
                return null;
              },
              decoration: AppDecoration.formFieldDecoration(hintText: "")
                  .copyWith(fillColor: fillColor, filled: true),
              elevation: 0,
              borderRadius: BorderRadius.circular(AppCircularRadius.cr24),
              hint: Text(
                hintText,
                style: const AppTextStyles()
                    .bodyTextNormalRegular
                    .copyWith(color: AppColors.inactiveGrey),
              ),
              isExpanded: true,
              items: items.map((dynamic value) {
                return DropdownMenuItem<dynamic>(
                  value: value,
                  child: Text(
                    "$value",
                    style: const AppTextStyles()
                        .formTextFill
                        .copyWith(color: AppColors.kBlack),
                  ),
                );
              }).toList(),
              onChanged: onChanged),
        ),
      ],
    );
  }
}
