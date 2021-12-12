class ModifyProjectsViewState{
  final ProjectImageCases projectImageCases;

  ModifyProjectsViewState({required this.projectImageCases});

  factory ModifyProjectsViewState.init(){
    return ModifyProjectsViewState(projectImageCases: ProjectImageCases.ASSETS);
  }

  ModifyProjectsViewState copy({
    ProjectImageCases? projectImageCases
  }){
    return ModifyProjectsViewState(
        projectImageCases: projectImageCases ?? this.projectImageCases
    );
  }
}

enum ProjectImageCases{
  PICKED , NETWORK , ASSETS
}