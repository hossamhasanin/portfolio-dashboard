import 'dart:io';

import 'package:base/models/project.dart';
abstract class ProjectsDataSource{
  Future<List<Project>> getProjects();
  Future addProject(Project project);
  Future updateProject(Project project);
  Future deleteProject(Project project);
  Future<String> uploadImage(File image);
}