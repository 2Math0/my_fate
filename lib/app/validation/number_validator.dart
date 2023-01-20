import '../../presentation/resources/strings_manager.dart';
import 'base_validator.dart';

class NumberValidator extends BaseValidator {
  bool _isNumeric = false;
  bool _isNotEmpty = false;

  @override
  String getMessage() {
    String message = '';
    // String concatenation for multiple error messages
    if (!_isNumeric) {
      message = '* ${AppStrings.numberValidationMessage}';
    }
    if (!_isNotEmpty) {
      // this line sees if there's an existing message or not
      // if there is then will be a line break, if not no String added
      message =
          "$message${message.isNotEmpty ? '\n' : ''}* ${AppStrings.requiredFieldMessage}";
    }
    return message;
  }

  @override
  bool validate(String? value) {
    _isNumeric = RegExp(r'\d').hasMatch(value!);
    _isNotEmpty = value.isNotEmpty;
    return _isNumeric && _isNotEmpty;
  }
}
