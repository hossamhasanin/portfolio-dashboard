import 'package:base/base.dart';
import 'package:get/get.dart';
import 'package:projects/logic/modify_projects_viewstate.dart';

import 'project_wrapper.dart';

class ModifyProjectController extends GetxController{
  final Rx<ModifyProjectsViewState> viewState = ModifyProjectsViewState.init().obs;

  checkIfPassedProject(ProjectWrapper? projectWrapper){
    if (projectWrapper != null){
      if (projectWrapper.pickedImage != null){
        viewState.value = viewState.value.copy(projectImageCases: ProjectImageCases.PICKED);
      } else {
        viewState.value = viewState.value.copy(projectImageCases: ProjectImageCases.NETWORK);
      }
    } else {
      viewState.value = viewState.value.copy(projectImageCases: ProjectImageCases.ASSETS);
    }
  }

  showPickedImage(){
    viewState.value = viewState.value.copy(projectImageCases: ProjectImageCases.PICKED);
  }
}