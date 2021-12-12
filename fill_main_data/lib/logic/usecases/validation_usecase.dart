import 'package:fill_main_data/logic/validation_errors.dart';

class ValidationUseCase {
  final RegExp _emailReg = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  ValidationErrors checkEmptiness(String entry){
    return entry.isEmpty ? ValidationErrors.EMPTY_ENTRY : ValidationErrors.NONE;
  }

  ValidationErrors checkEmailValidity(String email){
    return !_emailReg.hasMatch(email) ? ValidationErrors.EMAIL_NOT_VALID : ValidationErrors.NONE;
  }

  ValidationErrors checkForLength(String entry){
    return entry.length < 5 ? ValidationErrors.SHORT_ENTRY : ValidationErrors.NONE;
  }
}