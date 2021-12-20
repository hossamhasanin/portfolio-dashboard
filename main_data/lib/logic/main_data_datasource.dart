import 'dart:io';

import 'package:base/base.dart';
import 'package:base/models/portfolio_main_data.dart';

abstract class MainDataDataSource{
  Future updateMainData(PortfolioMainData mainData);
  Future<String> uploadImage(File image);
  Future updateSkill(Skill skill);
  Future<Skill> addSkill(Skill skill);
  Future deleteSkill(Skill skill);
  UploadProcess uploadCv(File cv);
}