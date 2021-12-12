
import 'package:base/models/portfolio_main_data.dart';
import 'package:base/models/skill.dart';

abstract class SplashDataSource{
  Future<bool> isLoggedIn();
  Future<PortfolioMainData?> getMainData();
  Future<List<Skill>> getSkills();
  Future<int> getProjectsNumber();
  Future<int>getLikesNumber();
}