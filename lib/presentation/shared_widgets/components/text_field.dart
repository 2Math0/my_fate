import 'package:flutter/material.dart';
import 'package:my_fate/app/validation/base_validator.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/decoration_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

class DataField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final BaseValidator? validator;
  final bool isTwo;
  final bool isEnabled;
  final TextInputType keyboardType;
  final FocusNode? onEditingComplete;
  const DataField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isTwo = false,
    this.keyboardType = TextInputType.text,
    this.isEnabled = true,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: isTwo ? (size.width * 0.5) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p16, horizontal: AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hintText,
                style: const AppTextStyles().headingH5,
              ),
              const SizedBox(height: AppMargin.m8),
              TextFormField(
                  focusNode: onEditingComplete,
                  enabled: isEnabled,
                  keyboardType: keyboardType,
                  style: const AppTextStyles()
                      .formTextFill
                      .copyWith(color: AppColors.kBlack),
                  decoration: AppDecoration.formFieldDecoration(
                      hintText: hintText, isEnabled: isEnabled),
                  controller: controller,
                  validator: (val) {
                    if (validator == null) {
                      return null;
                    } else if (!validator!.validate(val)) {
                      return validator!.getMessage();
                    }
                    return null;
                  }),
            ],
          ),
        ));
  }
}
