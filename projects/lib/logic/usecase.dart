import 'dart:io';

import 'package:base/base.dart';
import 'package:projects/logic/logic_events.dart';
import 'package:projects/logic/project_wrapper.dart';
import 'package:projects/logic/projects_datasource.dart';
import 'package:projects/logic/viewstate.dart';

class ProjectsUseCase {
  final ProjectsDataSource _dataSource;

  ProjectsUseCase(this._dataSource);

  Future<ProjectsViewState> getProjects(ProjectsViewState viewState) async {
    try{
      var projects = await _dataSource.getProjects();
      return viewState.copy(projects: projects.map((project) => ProjectWrapper(project, null)).toList() , loadingProjects: false , errorProjects: "");
    } on DataException catch(e){
      return viewState.copy(errorProjects: e.code , loadingProjects: false , projects: []);
    }
  }

  Future<dynamic> addProject(File image , Project project) async{
    try {
      var imageUrl = await _dataSource.uploadImage(image);
      project.image = imageUrl;
      print("add project "+project.toString());
      await _dataSource.addProject(project);
      return null;
    } on DataException catch(e){
      return ShowErrorDialog(e.code);
    }
  }

  Future<dynamic> updateProject(File? image , Project project) async{
    try {
      if (image != null){
        var imageUrl = await _dataSource.uploadImage(image);
        project.image = imageUrl;
      }
      await _dataSource.updateProject(project);
      return null;
    } on DataException catch(e){
      return ShowErrorDialog(e.code);
    }
  }

  Future<dynamic> deleteProject(Project project) async{
    try {
      await _dataSource.deleteProject(project);
      return null;
    } on DataException catch(e){
      return ShowErrorDialog(e.code);
    }
  }

}