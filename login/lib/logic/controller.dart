import 'dart:async';

import 'package:get/get.dart';
import 'package:login/logic/business_logic_events.dart';
import 'package:login/logic/login_datasource.dart';
import 'package:login/logic/usecases/login_usecase.dart';
import 'package:login/logic/usecases/validation_usecase.dart';
import 'package:login/logic/validation_errors.dart';

class LoginController extends GetxController{
  late final LoginUseCase _useCase;
  final ValidationUseCase _validationUseCase = ValidationUseCase();
  final StreamController<BusinessLogicEvent> _businessLogicEventsController = StreamController();
  Stream get businessLogicEventsStream => _businessLogicEventsController.stream.asBroadcastStream();

  LoginController(LoginDataSource dataSource){
    _useCase = LoginUseCase(dataSource);
  }

  Future login(String email , password) async {
    _businessLogicEventsController.add(ShowLoadingDialog());
    var validateEmail = _validationUseCase.validateEmail(email);
    if (validateEmail != ValidationErrors.NONE){
      _businessLogicEventsController.add(ShowErrorDialog("invalid-inputs"));
      return;
    }
    _businessLogicEventsController.add(await _useCase.login(email, password));
  }

}