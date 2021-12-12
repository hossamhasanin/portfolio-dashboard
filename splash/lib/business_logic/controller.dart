import 'dart:async';

import 'package:get/get.dart';
import 'package:splash/business_logic/logic_events.dart';
import 'package:splash/business_logic/splash_datasource.dart';
import 'package:splash/business_logic/usecase.dart';

class SplashController extends GetxController{

  late final SplashUseCase _useCase;

  final StreamController<LogicEvents> _logicEventsController = StreamController.broadcast();
  Stream<LogicEvents> get logicEventsStream => _logicEventsController.stream.asBroadcastStream();

  SplashController(SplashDataSource dataSource){
    _useCase = SplashUseCase(dataSource);
  }

  Future whereToGo() async {

    if (!await _useCase.isLoggedIn()){
      _logicEventsController.add(GoToLogin());
    }

    var mainDataResults = await _useCase.getMainData();
    if (mainDataResults is ShowErrorDialog){
      _logicEventsController.add(mainDataResults);
      return;
    }
    var skillsResults = await _useCase.getSkills();
    if (skillsResults is ShowErrorDialog){
      _logicEventsController.add(skillsResults);
      return;
    }
    var projectsNumberResults = await _useCase.getProjectsNumber();
    if (projectsNumberResults is ShowErrorDialog){
      _logicEventsController.add(projectsNumberResults);
      return;
    }
    var likesNumberResults = await _useCase.getLikesNumber();
    if (likesNumberResults is ShowErrorDialog){
      _logicEventsController.add(likesNumberResults);
      return;
    }
    if (mainDataResults == null){
      _logicEventsController.add(GoToFillMainData());
    } else {
      _logicEventsController.add(GoToMainScreen(
          mainDataResults, skillsResults, projectsNumberResults , likesNumberResults));
    }
  }

  @override
  void onClose() {
    _logicEventsController.close();
    super.onClose();
  }

}