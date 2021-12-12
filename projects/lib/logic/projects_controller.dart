import 'dart:async';
import 'dart:io';

import 'package:base/base.dart';
import 'package:get/get.dart';
import 'package:projects/logic/logic_events.dart';
import 'package:projects/logic/projects_datasource.dart';
import 'package:projects/logic/usecase.dart';
import 'package:projects/logic/viewstate.dart';

import 'project_wrapper.dart';

class ProjectsController extends GetxController{
   late final ProjectsUseCase _useCase;
   ProjectsViewState viewState = ProjectsViewState.init();
   final StreamController<LogicEvents> _logicStreamController = StreamController();
   Stream<LogicEvents> get logicEventsStream => _logicStreamController.stream;

   ProjectsController(ProjectsDataSource dataSource){
     _useCase = ProjectsUseCase(dataSource);
   }

   Future getProjects() async{
     viewState = viewState.copy(loadingProjects: true);
     update();
     viewState = await _useCase.getProjects(viewState);
     update();
   }

   Future addProject(ProjectWrapper projectWrapper , File image) async {
     var projects = viewState.projects;
     projectWrapper.pickedImage = image;
     projects.insert(0, projectWrapper);
     viewState = viewState.copy(projects: projects);
     _logicStreamController.add(InsertProjectToList(0));
     var result = await _useCase.addProject(image, projectWrapper.project);
     if (result is ShowErrorDialog){
       print("error "+result.error);
        _logicStreamController.add(result);
        projects.removeAt(0);
        viewState = viewState.copy(projects: projects);
        _logicStreamController.add(DeleteProjectFromList(projectWrapper , 0));
     }
   }

   Future editProject(ProjectWrapper projectWrapper , int index , File? image) async {
     var projects = viewState.projects;

     var oldProject = projects[index];
     projects.removeAt(index);
     projects.insert(index, projectWrapper);
     viewState = viewState.copy(projects: projects);
     update();
     var result = await _useCase.updateProject(image ,projectWrapper.project);
     if (result is ShowErrorDialog){
        _logicStreamController.add(result);
        projects.removeAt(index);
        projects.insert(index, oldProject);
        viewState = viewState.copy(projects: projects);
        update();
        return;
     }
   }

   Future deleteProject(int index) async {
     var projects = viewState.projects;
     var oldProject = projects[index];
     projects.removeAt(index);
     viewState = viewState.copy(projects: projects);
     _logicStreamController.add(DeleteProjectFromList(oldProject , index));
     print("viewstate "+viewState.projects.length.toString());
     var result = await _useCase.deleteProject(oldProject.project);
     if (result is ShowErrorDialog){
        _logicStreamController.add(result);
        projects.insert(index, oldProject);
        viewState = viewState.copy(projects: projects);
        _logicStreamController.add(InsertProjectToList(index));
        return;
     }
   }

}