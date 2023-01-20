import '../../presentation/resources/strings_manager.dart';
import 'base_validator.dart';

class NumberValidator extends BaseValidator {
  @override
  String getMessage() {
    return '* ${AppStrings.numberValidationMessage}';
  }

  @override
  bool validate(String? value) {
    return RegExp(r'\d').hasMatch(value!);
  }
}
