import 'package:fill_main_data/logic/fill_data_datasource.dart';
import 'package:get/get.dart';
import 'package:login/logic/login_datasource.dart';
import 'package:main_data/logic/controller.dart';
import 'package:main_data/logic/main_data_datasource.dart';
import 'package:portfolio_dashboard/data/login/login_datasource_imp.dart';
import 'package:portfolio_dashboard/data/main_data/main_data_datasource_imp.dart';
import 'package:portfolio_dashboard/data/projects/projects_datasource_imp.dart';
import 'package:portfolio_dashboard/data/splash/splash_datasource_imp.dart';
import 'package:projects/logic/projects_datasource.dart';
import 'package:splash/business_logic/splash_datasource.dart';
import 'data/fill_main_data/fill_data_datasource_imp.dart';

initDependencies(){
  Get.put<SplashDataSource>(SplashDataSourceImp());
  Get.put<LoginDataSource>(LoginDataSourceImp());
  Get.put<FillDataDataSource>(FillDataDataSourceImp());
  Get.put<MainDataDataSource>(MainDataDataSourceImp());
  Get.put<ProjectsDataSource>(ProjectsDataSourceImp());

  Get.put(MainDataController(Get.find()));
}