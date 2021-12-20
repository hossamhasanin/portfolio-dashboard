import 'dart:io';

import 'package:base/base.dart';
import 'package:base/models/portfolio_main_data.dart';
import 'package:main_data/logic/logic_events.dart';
import 'package:main_data/logic/main_data_datasource.dart';
import 'package:main_data/logic/skill_wrapper.dart';
import 'package:main_data/logic/viewstate.dart';

class MainDataUseCase{
  final MainDataDataSource _dataSource;

  MainDataUseCase(this._dataSource);

  Future<dynamic> saveDataEdit(MainDataViewState viewState , PortfolioMainData entries) async{
    try{
      if (viewState.pickedImage.path != ""){
        var imageUrl = await _dataSource.uploadImage(viewState.pickedImage);
        entries.ownerImage = imageUrl;
      }
      await _dataSource.updateMainData(entries);
      return viewState.copy(mainData: viewState.mainData.fromAnother(entries));
    } on DataException catch(e) {
      return ShowErrorDialog(e.code);
    }
  }

  Future<dynamic> saveSkillEdit(MainDataViewState viewState , Skill skill , int skillIndex , Map<String , SkillWrapper> skillCache) async{
    try{
      await _dataSource.updateSkill(skill);
      var skills = viewState.skills;
      skills[skillIndex] = SkillWrapper.fromSkill(skill);


      skills = _saveSkillsToList(skillCache, skills, skillIndex);
      print("skills now "+skills.toString());

      return viewState.copy(skills: skills);
      // return null;
    } on DataException catch(e) {
      return ShowErrorDialog(e.code);
    }
  }

  Future<dynamic> addSkill(MainDataViewState viewState , Skill skill ,int index ,Map<String , SkillWrapper> skillCache) async{
    try{
      var s = await _dataSource.addSkill(skill);
      var skills = viewState.skills;
      skills[index] = SkillWrapper.fromSkill(s);


      skills = _saveSkillsToList(skillCache, skills, index);

      return viewState.copy(skills: skills);
      // return null;
    } on DataException catch(e) {
      return ShowErrorDialog(e.code);
    }
  }

  Future<dynamic> deleteSkill(MainDataViewState viewState , SkillWrapper skill , int index ,Map<String , SkillWrapper> skillCache) async{
    try{
      await _dataSource.deleteSkill(skill.skill);
      var skills = viewState.skills;
      skills.remove(skill);

      skills = _saveSkillsToList(skillCache, skills, index);

      return viewState.copy(skills: skills);
      // return null;
    } on DataException catch(e) {
      return ShowErrorDialog(e.code);
    }
  }

  List<SkillWrapper> _saveSkillsToList(Map<String , SkillWrapper> skillCache , List<SkillWrapper> skills , int index){
    skillCache.remove(index.toString());
    skillCache.forEach((key, value) {
      skills[int.parse(key)] = value;
    });

    return skills;
  }

  UploadProcess uploadCv(File cv){
    return _dataSource.uploadCv(cv);
  }

  Future<dynamic> updateCvUrl(PortfolioMainData portfolioMainData) async {
    try {
      await _dataSource.updateMainData(portfolioMainData);
    } on DataException catch(e){
      return ShowErrorDialog(e.code);
    }
  }

}