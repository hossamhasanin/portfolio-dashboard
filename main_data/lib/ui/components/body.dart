import 'dart:async';

import 'package:base/base.dart';
import 'package:base/models/portfolio_main_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_data/logic/controller.dart';
import 'package:main_data/logic/logic_events.dart';
import 'package:main_data/ui/components/cv.dart';
import 'package:main_data/ui/components/edit/main_info_edit.dart';
import 'package:main_data/ui/components/main_info.dart';
import 'package:main_data/ui/components/projects.dart';
import 'package:main_data/ui/components/skills.dart';
import 'edit/header_edit.dart';

import 'header.dart';
import 'pop_up_skills.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final MainDataController _controller = Get.find();
  final TextEditingController _userNameEditingController = TextEditingController();
  final TextEditingController _careerEditingController = TextEditingController();

  final List<TextEditingController> skillTextControllers = [];

  StreamSubscription? _logicEventsListener;

  BuildContext? _dialogContext;

  @override
  void initState() {
    super.initState();

    PortfolioMainData mainData = Get.arguments[0];
    List<Skill> skills = Get.arguments[1];
    int projectsNumber = Get.arguments[2];
    int likesNumber = Get.arguments[3];

    _controller.setData(mainData, skills, projectsNumber , likesNumber);

    _logicEventsListener = _controller.logicEventsStream.listen((event) {
      if (event is ShowLoadingDialog){
        _dialogContext = Get.overlayContext;
        showDialog(context: _dialogContext!, builder: (_){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: SizedBox(
              height: 150.0,
              width: 300.0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: const [
                      Text("Wait ..."),
                      SizedBox(width: 10.0,),
                      CircularProgressIndicator()
                    ],
                  ),
                ),
              ),
            ),
          );
        } , barrierDismissible: true);
      }

      if (event is ShowErrorDialog){
        showDialog(context: context, builder: (_){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: SizedBox(
              height: 200.0,
              width: 300.0,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Text(_viewErrorMessage(event.error) ,
                      style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 18.0)),
                ),
              ),
            ),
          );
        });
      }

      if (event is ShowEditingSkillsDialog){
        showDialog(context: context, builder: (_){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              width: double.infinity,
              height: 300.0,
              padding: const EdgeInsets.all(8.0),
              child: Obx((){
                var viewState = _controller.viewState.value;
                return PopUpSkills(
                  skills: viewState.skills,
                  textControllers: skillTextControllers,
                  addMore: (){
                    _controller.addSkill();
                  },
                  update: (index , skill){
                    _controller.doneEditingSkill(index , skill);
                  },
                  enterSkill: (index , skill){
                    _controller.enterSkill(skill, index);
                  },
                  delete: (skill , index){
                    _controller.deleteSkill(skill , index);
                    skillTextControllers.removeAt(index);
                  },
                );
              }),
            ),
          );
        });
      }

      if (event is ShowSkillsDoneMessage){
        Get.snackbar("Skills", _viewSkillsOperationMessage(event.skillsOperationMessage));
      }

      if (event is ShowToast){
        Get.snackbar("Upload process", _viewErrorMessage(event.message));
      }

      if (event is CloseDialogs){
        if (_dialogContext != null){
          Navigator.pop(_dialogContext!);
          _dialogContext = null;
        }
      }
    });

  }

  @override
  void dispose() {
    if (_logicEventsListener != null){
      _logicEventsListener!.cancel();
    }
    for(var controller in skillTextControllers){
      controller.dispose();
    }
    _userNameEditingController.dispose();
    _careerEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx((){
            var viewState = _controller.viewState.value;
            if (viewState.headerEditMode){
              return HeaderEdit(
                username: viewState.mainData.ownerName!,
                career: viewState.mainData.career!,
                userNameController: _userNameEditingController,
                careerController: _careerEditingController,
                pickedImage: viewState.pickedImage,
                currentImage: viewState.mainData.ownerImage!,
                showPickedImage: viewState.showPickedImage,
                pickImage: (pickedImage){
                  _controller.setPickedImage(pickedImage);
                },
                saveChanges: (){
                  _controller.doneEditingHeader();
                },
                enterName: (name){
                  _controller.entryCache.ownerName = name;
                },
                enterCareer: (career){
                  _controller.entryCache.career = career;
                },
              );
            } else {
              return Header(
                  career: viewState.mainData.career!,
                  userName: viewState.mainData.ownerName!,
                  image: viewState.mainData.ownerImage!,
                  startEditing: (){
                    _controller.editHeader();
                  },
              );
            }
          }),
          Obx((){
            var viewState = _controller.viewState.value;
            if (viewState.mainInfoEditMode){
              return MainInfoEdit(
                  descriptionValue: viewState.mainData.description!,
                  emailValue: viewState.mainData.email!,
                  phoneValue: viewState.mainData.phone!,
                  yearsOfExperience: viewState.mainData.yearsOfExperience!,
                  location: viewState.mainData.location!,
                  facebookAccount: viewState.mainData.facebookAccount!,
                  twitterAccount: viewState.mainData.twitterAccount!,
                  linkedInAccount: viewState.mainData.linkedInAccount!,
                  githubAccount: viewState.mainData.githubAccount!,
                  descriptionChanged: (description){
                    _controller.entryCache.description = description;
                  },
                  emailChanged: (email){
                    _controller.entryCache.email = email;
                  },
                  phoneChanged: (phone){
                    _controller.entryCache.phone = phone;
                  },
                  yearsOfExperienceChanged: (years){
                    _controller.entryCache.yearsOfExperience = years;
                  },
                  locationChanged: (location){
                    _controller.entryCache.location = location;
                  },
                  facebookAccountChanged: (account){
                    _controller.entryCache.facebookAccount = account;
                  },
                  twitterAccountChanged: (account){
                    _controller.entryCache.twitterAccount = account;
                  },
                  linkedInAccountChanged: (account){
                    _controller.entryCache.linkedInAccount = account;
                  },
                  githubAccountChanged: (account){
                    _controller.entryCache.githubAccount = account;
                  },
                doneEditing: (){
                    _controller.doneEditingMainInfo();
                  },
                  );
            } else {
              return MainInfo(
                descriptionValue: viewState.mainData.description!,
                emailValue: viewState.mainData.email!,
                phoneValue: viewState.mainData.phone!,
                yearsOfExperience: viewState.mainData.yearsOfExperience!,
                location: viewState.mainData.location!,
                facebookAccount: viewState.mainData.facebookAccount!,
                twitterAccount: viewState.mainData.twitterAccount!,
                linkedInAccount: viewState.mainData.linkedInAccount!,
                githubAccount: viewState.mainData.githubAccount!,
                editMode: (){
                  _controller.editMainInfo();
                },
              );
            }
          }),
          Obx((){
            var skills = _controller.viewState.value.skills;
            print("controller skills "+skills.toString());
            return Sills(
              skills: skills.map((e) => e.skill).toList(),
              openSkillsDialog: (){
                _controller.editSkills();
              },
            );
          }),
          Obx((){
            var viewState = _controller.viewState.value;
            return Projects(
              projectsNumber: viewState.projectsNumber,
              likesNumber: viewState.likesNumber,
            );
          }),
          Obx((){
            var viewState = _controller.viewState.value;
            return Cv(
                uploading: viewState.uploadingCv,
                cvUrl: viewState.mainData.cvUrl!,
                uploadCv: (cvFile){
                  _controller.uploadCv(cvFile);
                },
                uploadProgress: _controller.uploadCvProgress.value
            );
          })
        ],
      ),
    );
  }

  String _viewErrorMessage(String errorCode){
    switch(errorCode){
      case "network-request-failed":{
        return "No internet";
      }
      case "error-in-cv-upload":{
        return "Error while cv uploading please try again later";
      }
      case "upload-in-process":{
        return "Hey buddy there is upload already in process";
      }
      default:{
        throw "Error code not defined";
      }
    }
  }
  String _viewSkillsOperationMessage(SkillsOperationMessage skillsOperationMessage){
    switch(skillsOperationMessage){
      case SkillsOperationMessage.ADD:{
        return "Your skill added successfully";
      }
      case SkillsOperationMessage.DELETE:{
        return "Your skill deleted successfully";
      }
      case SkillsOperationMessage.UPDATE:{
        return "Your skill updated successfully";
      }
      default:{
        throw "Error code not defined";
      }
    }
  }
}