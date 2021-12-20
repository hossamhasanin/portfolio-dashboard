import 'dart:async';
import 'dart:io';

import 'package:base/base.dart';
import 'package:base/models/portfolio_main_data.dart';
import 'package:get/get.dart';
import 'package:main_data/logic/logic_events.dart';
import 'package:main_data/logic/main_data_datasource.dart';
import 'package:main_data/logic/skill_wrapper.dart';
import 'package:main_data/logic/usecase.dart';
import 'package:main_data/logic/viewstate.dart';

enum SkillsOperationMessage{
  ADD,UPDATE,DELETE
}

class MainDataController extends GetxController{
  late final MainDataUseCase _useCase;
  final Rx<MainDataViewState> viewState = MainDataViewState.init().obs;
  final StreamController<MainDataLogicEvent> _logicEventsController = StreamController();
  Stream get logicEventsStream => _logicEventsController.stream.asBroadcastStream();
  PortfolioMainData entryCache = PortfolioMainData.init();
  // this map intended to cache the skill you have edited
  final Map<String, SkillWrapper> skillsEntryCache = {};
  UploadProcess? _uploadCvProcess;
  StreamSubscription<UploadData>? _uploadCvStream;
  RxDouble uploadCvProgress = 0.0.obs;


  MainDataController(MainDataDataSource dataSource){
    _useCase = MainDataUseCase(dataSource);
  }

  // Future getMainData() async{
  //   _logicEventsController.add(ShowLoadingDialog());
  //   var result = await _useCase.getMainData(viewState.value);
  //   if (result is MainDataViewState){
  //     viewState.value = result;
  //     _logicEventsController.add(CloseDialogs());
  //   } else {
  //     _logicEventsController.add(CloseDialogs());
  //     _logicEventsController.add(result);
  //   }
  // }
  //
  // Future getSkills() async{
  //   var result = await _useCase.getSkills(viewState.value);
  //   if (result is MainDataViewState){
  //     viewState.value = result;
  //     print("koko state "+viewState.value.skills.toString());
  //   } else {
  //     _logicEventsController.add(result);
  //   }
  // }

  setData(
      PortfolioMainData mainData ,
      List<Skill> skills ,
      int projectsNumber ,
      int likesNumber
      ){
    viewState.value = viewState.value.copy(
        mainData: mainData ,
        skills: skills.map((skill) => SkillWrapper.fromSkill(skill)).toList(),
        projectsNumber: projectsNumber,
        likesNumber: likesNumber
    );
  }

  editHeader(){
    viewState.value = viewState.value.copy(headerEditMode: true);
  }

  editMainInfo(){
    viewState.value = viewState.value.copy(mainInfoEditMode: true);
  }

  editSkills(){
    _logicEventsController.add(ShowEditingSkillsDialog());
  }

  doneEditingHeader() async{
    // check first if there is data edited to precede
    if (entryCache.career == "" && entryCache.ownerName == "" && viewState.value.pickedImage.path == ""){
      viewState.value = viewState.value.copy(headerEditMode: false);
      return;
    }

    _doneEditingMainData(() => viewState.value = viewState.value.copy(headerEditMode: false),
            (newViewState) => viewState.value = newViewState.copy(
                headerEditMode: false ,
                pickedImage: File("") ,
                showPickedImage: false));
  }

  doneEditingMainInfo() async{
    if (entryCache.email == "" &&
        entryCache.description == "" &&
        entryCache.phone == "" &&
        entryCache.yearsOfExperience == 0 &&
        entryCache.location == "" &&
        entryCache.facebookAccount == "" &&
        entryCache.twitterAccount == "" &&
        entryCache.githubAccount == "" &&
        entryCache.linkedInAccount == ""
    ){
      viewState.value = viewState.value.copy(mainInfoEditMode: false);
      return;
    }
    _doneEditingMainData(() => viewState.value = viewState.value.copy(mainInfoEditMode: false),
            (newViewState) => viewState.value = newViewState.copy(mainInfoEditMode: false));
  }

  doneEditingSkill(int index , Skill skill) async {
    // check if you have written something to be saved
    // check also if the cache has this skill to be edited
    if (skill.name == "" || !skillsEntryCache.containsKey(index.toString())){
      return;
    }

    // add new or edit if it's a skill already
    // we use the id NEW when it's a new skill hasn't been saved to database yet
    var result = skill.id == "NEW" ?
    await _useCase.addSkill(viewState.value, skill ,index , skillsEntryCache) :
    await _useCase.saveSkillEdit(viewState.value, skill, index , skillsEntryCache);

    // in case there is an error show it and return
    if (result is MainDataLogicEvent){
      _logicEventsController.add(result);
      return;
    }

    // after done remove the skill from the cache because the edit has been saved
    skillsEntryCache.remove(index.toString());

    // if there is no error we want to edit the view state to determine that the edited skill has be saved
    viewState.value = result;
    _logicEventsController.add(
        ShowSkillsDoneMessage(
            skill.id == "NEW" ?
            SkillsOperationMessage.ADD : SkillsOperationMessage.UPDATE
        ));
  }

  // add new skill box
  addSkill(){
    // don't allow to create a new box unless you have saved the contents of the new skill
    var skills = viewState.value.skills;
    if (skills.isNotEmpty){
      if (skills.last.skill.name == "NEW"){
        return;
      }
    }
    skills.add(SkillWrapper.fromSkill(Skill(id: "NEW" , name: "") , editing: true));
    viewState.value = viewState.value.copy(skills: skills);
  }

  // delete skill
  deleteSkill(SkillWrapper skill , int index) async {
    // remove the skill from the cache if it is there
    skillsEntryCache.remove(index.toString());
    // if you ordered the new skill hasn't been saved yet to be deleted
    if (skill.skill.name == "NEW"){
      var skills = viewState.value.skills;
      skills.remove(skill);
      viewState.value = viewState.value.copy(skills: skills);
      return;
    }

    // delete a saved skill from the data base
    var result = await _useCase.deleteSkill(viewState.value, skill , index , skillsEntryCache);
    // if error show it and return
    if (result is MainDataLogicEvent){
      _logicEventsController.add(result);
      return;
    }

    // update the view state with new result after deleting this skill
    viewState.value = result;
    // show that the process is done to the user
    _logicEventsController.add(ShowSkillsDoneMessage(SkillsOperationMessage.DELETE));
  }

  // enter the skill while typing on the keyboard
  enterSkill(SkillWrapper skill , int index){
    var skills = viewState.value.skills;
    print("see "+skill.skill.name);
    //check if the skill is in the cache or not
    // if not then
    if (!skillsEntryCache.containsValue(skill)){
      // save the skill to the cache with editing flag true because anything i the cache is being edited
      skillsEntryCache[index.toString()] = SkillWrapper.fromSkill(skill.skill , editing: true);
      print("cache "+ skillsEntryCache.toString());
      print("editing");
      // if that skill in the view state is not editing then turn its editing flag to true
      // we turn that flag to true because we want to
      // show something in the ui indicates that this skill isn't saved yet
      if (!skills[index].editing){
        skills[index] = SkillWrapper.fromSkill(skills[index].skill , editing: true);
        viewState.value = viewState.value.copy(skills: skills);
      }
      // if the skill is in the cache already
    } else {
      // check then if its value in viewstate equals what has been entered of not
      // if it equals
      if (skills[index].skill.name == skill.skill.name){
        print("not editing");
        // check if we had its editing flag turned true
        if (skills[index].editing){
          // then change it to false because in that case it means we returned back to the value it was
          // so we want the ui shows that no changes on the skill made to be saved
          skills[index] = SkillWrapper.fromSkill(skill.skill , editing: false);
          viewState.value = viewState.value.copy(skills: skills);
          skillsEntryCache.remove(index.toString());
        }
      }
    }
  }

  uploadCv(File cv){

    if (_uploadCvProcess != null){
      _logicEventsController.add(ShowToast("upload-in-process"));
      return;
    }

    viewState.value = viewState.value.copy(uploadingCv: true);
    _uploadCvProcess = _useCase.uploadCv(cv);
    _uploadCvStream = _uploadCvProcess!.uploadStream().listen((uploadData) {
      uploadCvProgress.value = uploadData.transferredBytes/uploadData.totalBytes;
    });
    _uploadCvStream!.onData((data) async {
      var url = await _uploadCvProcess!.getDownloadUrl();
      print("url "+url);
      var data = PortfolioMainData.init();
      data.cvUrl = url;
      await _useCase.updateCvUrl(data);
      viewState.value = viewState.value.copy(uploadingCv: false , mainData: viewState.value.mainData.fromAnother(data));
      uploadCvProgress.value = 0.0;
      _uploadCvProcess = null;
      _uploadCvStream!.cancel();
      _uploadCvStream = null;
    });
    _uploadCvStream!.onError((_){
      viewState.value = viewState.value.copy(uploadingCv: false);
      _logicEventsController.add(ShowErrorDialog("error-in-cv-upload"));
      _uploadCvProcess = null;
      _uploadCvStream!.cancel();
      _uploadCvStream = null;
    });
  }


  _doneEditingMainData(Function() updateViewStateOnError , Function(MainDataViewState) updateViewStateOnComplete) async {
    print("years "+entryCache.yearsOfExperience.toString());
    _logicEventsController.add(ShowLoadingDialog());
    var result = await _useCase.saveDataEdit(viewState.value, entryCache);
    _logicEventsController.add(CloseDialogs());

    if (result is MainDataLogicEvent){
      _logicEventsController.add(result);
      updateViewStateOnError();
      entryCache = PortfolioMainData.init();
      return;
    }
    entryCache = PortfolioMainData.init();
    updateViewStateOnComplete(result);
  }

  setPickedImage(File image){
    viewState.value = viewState.value.copy(pickedImage: image , showPickedImage: true);
  }
}