import 'dart:io';

import 'package:base/models/portfolio_main_data.dart';
import 'package:main_data/logic/skill_wrapper.dart';

class MainDataViewState{
  final PortfolioMainData mainData;
  final List<SkillWrapper> skills;
  final int projectsNumber;
  final int likesNumber;
  final File pickedImage;
  final bool showPickedImage;
  final bool headerEditMode;
  final bool mainInfoEditMode;
  final bool uploadingCv;

  MainDataViewState({
    required this.mainData,
    required this.skills,
    required this.projectsNumber,
    required this.likesNumber,
    required this.headerEditMode,
    required this.pickedImage,
    required this.showPickedImage,
    required this.mainInfoEditMode,
    required this.uploadingCv,
  });

  factory MainDataViewState.init(){
    return MainDataViewState(
        mainData: PortfolioMainData.init(),
        headerEditMode: false,
        pickedImage: File(""),
      showPickedImage: false,
      mainInfoEditMode: false,
      skills: [],
      projectsNumber: 0,
      likesNumber: 0,
      uploadingCv: false,
    );
  }

  MainDataViewState copy({
    PortfolioMainData? mainData,
    bool? headerEditMode,
    File? pickedImage,
    bool? showPickedImage,
    bool? mainInfoEditMode,
    List<SkillWrapper>? skills,
    int? projectsNumber,
    int? likesNumber,
    bool? uploadingCv,
  }){
    return MainDataViewState(
        mainData: mainData ?? this.mainData,
        headerEditMode: headerEditMode ?? this.headerEditMode,
        pickedImage: pickedImage ?? this.pickedImage,
        showPickedImage: showPickedImage ?? this.showPickedImage,
        mainInfoEditMode: mainInfoEditMode ?? this.mainInfoEditMode,
        skills: skills ?? this.skills,
        likesNumber: likesNumber ?? this.likesNumber,
        projectsNumber: projectsNumber ?? this.projectsNumber,
        uploadingCv: uploadingCv ?? this.uploadingCv,
    );
  }
}