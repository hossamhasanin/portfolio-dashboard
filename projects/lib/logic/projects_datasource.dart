import 'dart:io';

import 'package:base/models/project.dart';
import 'package:projects/logic/upload_process.dart';
abstract class ProjectsDataSource{
  Future<List<Project>> getProjects();
  Future addProject(Project project);
  Future updateProject(Project project);
  Future deleteProject(Project project);
  // Future<String> uploadImage(File image);
  UploadProcess uploadImage(File image);
}