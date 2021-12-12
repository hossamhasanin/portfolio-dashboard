

import 'package:base/base.dart';
import 'package:base/models/portfolio_main_data.dart';
import 'package:splash/business_logic/logic_events.dart';

import 'splash_datasource.dart';

class SplashUseCase{
  final SplashDataSource _dataSource;

  SplashUseCase(this._dataSource);

  Future<dynamic> getMainData() async {
    try{
      PortfolioMainData? mainData =  await _dataSource.getMainData();
      return mainData;
    } on DataException catch(e){
      print("koko error splash "+ e.toString());
      return ShowErrorDialog(e.code);
    }
  }
  Future<dynamic> getSkills() async {
    try{
      List<Skill> skills =  await _dataSource.getSkills();
      return skills;
    } on DataException catch(e){
      print("koko error splash "+ e.toString());
      return ShowErrorDialog(e.code);
    }
  }

  Future<dynamic> getProjectsNumber() async {
    try{
      int number =  await _dataSource.getProjectsNumber();
      return number;
    } on DataException catch(e){
      print("koko error splash "+ e.toString());
      return ShowErrorDialog(e.code);
    }
  }

  Future<dynamic> getLikesNumber() async {
    try{
      int number =  await _dataSource.getLikesNumber();
      return number;
    } on DataException catch(e){
      print("koko error splash "+ e.toString());
      return ShowErrorDialog(e.code);
    }
  }

  Future<bool> isLoggedIn() async {
    return _dataSource.isLoggedIn();
  }

}