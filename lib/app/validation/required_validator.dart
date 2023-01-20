import 'package:my_fate/presentation/resources/strings_manager.dart';

import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  @override
  String getMessage() {
    return '* ${AppStrings.requiredFieldMessage}';
  }

  @override
  bool validate(String? value) {
    return value != null && value.isNotEmpty;
  }
}
