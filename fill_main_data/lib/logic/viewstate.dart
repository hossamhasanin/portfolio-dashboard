import 'package:fill_main_data/logic/validation_errors.dart';

class FillMainDataViewState{
  final ValidationErrors nameError;
  final ValidationErrors careerError;
  final ValidationErrors descriptionError;
  final ValidationErrors phoneError;
  final ValidationErrors emailError;

  FillMainDataViewState(
      {required this.nameError,
      required this.careerError,
      required this.descriptionError,
      required this.phoneError,
      required this.emailError});

  factory FillMainDataViewState.init(){
    return FillMainDataViewState(
        nameError: ValidationErrors.NONE,
        careerError: ValidationErrors.NONE,
        descriptionError: ValidationErrors.NONE,
        phoneError: ValidationErrors.NONE,
        emailError: ValidationErrors.NONE
    );
  }

  FillMainDataViewState copy({
    ValidationErrors? nameError,
    ValidationErrors? careerError,
    ValidationErrors? descriptionError,
    ValidationErrors? phoneError,
    ValidationErrors? emailError
  }){
    return FillMainDataViewState(
        nameError: nameError ?? this.nameError,
        careerError: careerError ?? this.careerError,
        descriptionError: descriptionError ?? this.descriptionError,
        phoneError: phoneError ?? this.phoneError,
        emailError: emailError ?? this.emailError
    );
  }

}