import 'package:login/logic/validation_errors.dart';

class ValidationUseCase {
  RegExp _emailReg = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  ValidationErrors validateEmail(String email){
    if (email == ""){
      return ValidationErrors.EMAIL_EMPTY;
    }

    if (!_emailReg.hasMatch(email)){
      return ValidationErrors.EMAIL_NOT_VALID;
    }
    return ValidationErrors.NONE;
  }
}