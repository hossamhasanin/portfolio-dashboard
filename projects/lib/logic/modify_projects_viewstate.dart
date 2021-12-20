class ModifyProjectsViewState{
  final ProjectImageCases projectImageCases;
  final List<String> skills;

  ModifyProjectsViewState({required this.projectImageCases , required this.skills});

  factory ModifyProjectsViewState.init(){
    return ModifyProjectsViewState(
        projectImageCases: ProjectImageCases.ASSETS , skills: []
    );
  }

  ModifyProjectsViewState copy({
    ProjectImageCases? projectImageCases,
    List<String>? skills
  }){
    return ModifyProjectsViewState(
        projectImageCases: projectImageCases ?? this.projectImageCases,
        skills: skills ?? this.skills
    );
  }
}

enum ProjectImageCases{
  PICKED , NETWORK , ASSETS
}