import 'package:base/base.dart';
import 'package:get/get.dart';
import 'package:projects/logic/modify_projects_viewstate.dart';

import 'project_wrapper.dart';

class ModifyProjectController extends GetxController{
  ModifyProjectsViewState viewState = ModifyProjectsViewState.init();

  checkIfPassedProject(ProjectWrapper? projectWrapper){
    if (projectWrapper != null){
      if (projectWrapper.pickedImage != null){
        viewState = viewState.copy(projectImageCases: ProjectImageCases.PICKED);
      } else {
        viewState = viewState.copy(projectImageCases: ProjectImageCases.NETWORK);
      }
    } else {
      viewState = viewState.copy(projectImageCases: ProjectImageCases.ASSETS);
    }
    update();
  }

  setSkills(List<String> skills){
    viewState = viewState.copy(skills: skills);
    update();
  }

  enterSkill(int index , String skill){
    var skills = viewState.skills;
    skills[index] = skill;
    viewState = viewState.copy(skills: skills);
  }

  addNewSkill(){
    var skills = viewState.skills;
    if (skills.isNotEmpty){
      if (skills.last == ""){
        return;
      }
    }
    skills.add("");
    viewState = viewState.copy(skills: skills);
    update();
  }

  deleteSkill(int index){
    var skills = viewState.skills;
    skills.removeAt(index);
    viewState = viewState.copy(skills: skills);
    update();
  }

  showPickedImage(){
    viewState = viewState.copy(projectImageCases: ProjectImageCases.PICKED);
    update();
  }
}