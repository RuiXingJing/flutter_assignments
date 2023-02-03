import 'package:formz/formz.dart';

import '../../../utils.dart';

enum MobileInputError { empty, invalid }

class MobileInput extends FormzInput<String, MobileInputError> {
  const MobileInput.pure() : super.pure('');

  const MobileInput.dirty([super.value = '']) : super.dirty();

  @override
  MobileInputError? validator(String value) {
    if (value.isEmpty) {
      return MobileInputError.empty;
    } else if (!FormatUtils.isNumber(value)) {
      return MobileInputError.invalid;
    }
    return null;
  }
}
