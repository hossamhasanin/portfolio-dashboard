import 'dart:async';

import 'package:base/models/portfolio_main_data.dart';
import 'package:fill_main_data/logic/business_logic_events.dart';
import 'package:fill_main_data/logic/fill_data_datasource.dart';
import 'package:fill_main_data/logic/usecases/fill_data_usecase.dart';
import 'package:fill_main_data/logic/usecases/validation_usecase.dart';
import 'package:fill_main_data/logic/validation_errors.dart';
import 'package:fill_main_data/logic/viewstate.dart';
import 'package:get/get.dart';

class FillDataController extends GetxController{
  late final FillDataUseCase _useCase;
  final ValidationUseCase _validationUseCase = ValidationUseCase();
  final Rx<FillMainDataViewState> viewState = FillMainDataViewState.init().obs;
  final StreamController<LogicEvents> _logicEventsController = StreamController();
  Stream<LogicEvents> get logicEventsStream => _logicEventsController.stream.asBroadcastStream();
  PortfolioMainData entryCache = PortfolioMainData.init();
  FillDataController(FillDataDataSource dataSource){
    _useCase = FillDataUseCase(dataSource);
  }

  enterName(String name){
    entryCache.ownerName = name;
    var checkForEmptiness = _validationUseCase.checkEmptiness(name);
    _updateViewState(viewState.value.copy(nameError: checkForEmptiness));

    var checkForLength = _validationUseCase.checkForLength(name);
    _updateViewState(viewState.value.copy(nameError: checkForLength));
  }

  enterEmail(String email){
    entryCache.email = email;
    var checkForEmptiness = _validationUseCase.checkEmptiness(email);
    _updateViewState(viewState.value.copy(emailError: checkForEmptiness));

    var checkForLength = _validationUseCase.checkEmailValidity(email);
    _updateViewState(viewState.value.copy(emailError: checkForLength));
  }

  enterCareer(String career){
    entryCache.career = career;
    var checkForEmptiness = _validationUseCase.checkEmptiness(career);
    _updateViewState(viewState.value.copy(careerError: checkForEmptiness));

    var checkForLength = _validationUseCase.checkForLength(career);
    _updateViewState(viewState.value.copy(careerError: checkForLength));
  }

  enterDescription(String description){
    entryCache.description = description;
    var checkForEmptiness = _validationUseCase.checkEmptiness(description);
    _updateViewState(viewState.value.copy(descriptionError: checkForEmptiness));

    var checkForLength = _validationUseCase.checkForLength(description);
    _updateViewState(viewState.value.copy(descriptionError: checkForLength));
  }

  enterPhone(String phone){
    entryCache.phone = phone;
    var checkForEmptiness = _validationUseCase.checkEmptiness(phone);
    _updateViewState(viewState.value.copy(phoneError: checkForEmptiness));

    var checkForLength = _validationUseCase.checkForLength(phone);
    _updateViewState(viewState.value.copy(phoneError: checkForLength));
  }

  addData() async {
    _logicEventsController.add(ShowLoadingDialog());
    _logicEventsController.add(await _useCase.fillMainData(entryCache));
  }

  _updateViewState(FillMainDataViewState newViewState){
    viewState.value = newViewState;
  }


}