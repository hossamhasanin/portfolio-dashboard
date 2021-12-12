import 'package:base/base.dart';
import 'package:equatable/equatable.dart';
import 'package:projects/logic/project_wrapper.dart';

class ProjectsViewState {
  final List<ProjectWrapper> projects;
  final bool loadingProjects;
  final String errorProjects;

  const ProjectsViewState({
    required this.projects,
    required this.loadingProjects,
    required this.errorProjects
  });

  factory ProjectsViewState.init(){
    return const ProjectsViewState(
        projects: [],
        loadingProjects: false,
        errorProjects: ""
    );
  }

  ProjectsViewState copy({
    List<ProjectWrapper>? projects,
    bool? loadingProjects,
    String? errorProjects
  }){
    return ProjectsViewState(
        projects: projects ?? this.projects,
        loadingProjects: loadingProjects ?? this.loadingProjects,
        errorProjects: errorProjects ?? this.errorProjects
    );
  }
}