import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:base/base.dart';
import 'package:get/get.dart';
import 'package:projects/logic/logic_events.dart';
import 'package:projects/logic/projects_datasource.dart';
import 'package:base/upload_data.dart';
import 'package:base/upload_process.dart';
import 'package:projects/logic/usecase.dart';
import 'package:projects/logic/viewstate.dart';

import 'project_wrapper.dart';

class ProjectsController extends GetxController{
   late final ProjectsUseCase _useCase;
   ProjectsViewState viewState = ProjectsViewState.init();
   final StreamController<LogicEvents> _logicStreamController = StreamController();
   Stream<LogicEvents> get logicEventsStream => _logicStreamController.stream;
   Map<int , RxDouble> uploadProgress = {};
   Queue<UploadProcess> _uploadProcess = Queue<UploadProcess>();
   Queue<StreamSubscription<UploadData>> _uploadStreams = Queue<StreamSubscription<UploadData>>();
   UploadProcess? _currentRunningUploadProcess;
   StreamSubscription<UploadData>? _currentRunningStreamUpload;

   ProjectsController(ProjectsDataSource dataSource){
     _useCase = ProjectsUseCase(dataSource);
   }

   Future getProjects() async{
     viewState = viewState.copy(loadingProjects: true);
     update();
     viewState = await _useCase.getProjects(viewState);
     update();
   }

   uploadImage(File image , int index){
     UploadProcess upload = _useCase.uploadImage(image , index);
     _uploadProcess.add(upload);
     uploadProgress[index] = 0.0.obs;
     if (_uploadProcess.length == 1){
       _currentRunningUploadProcess = _uploadProcess.removeFirst();
        _activateUploadProcess(_currentRunningUploadProcess!);
     }
   }
   _activateUploadProcess(UploadProcess process){
     var index = process.index;
     var stream = process.uploadStream().listen((event) {
       uploadProgress[index]!.value = (event.transferredBytes/event.totalBytes);
     });
     _currentRunningStreamUpload = stream;
     _uploadStreams.add(stream);
     stream.onDone(() async{
       var imgUrl = await process.getDownloadUrl();
       var projects = viewState.projects;
       if (projects.isNotEmpty){
         if (projects[index].project.image != ""){
           await _editProject(index, imgUrl , (project) => _useCase.updateProject(project));
         } else {
           await _editProject(index, imgUrl , (project) => _useCase.addProject(project));
         }
         _currentRunningUploadProcess = null;
         uploadProgress.remove(index);
         stream.cancel();
         _uploadStreams.remove(stream);
         _currentRunningStreamUpload = null;
         if (_uploadProcess.isNotEmpty){
           _currentRunningUploadProcess = _uploadProcess.removeFirst();
           _activateUploadProcess(_currentRunningUploadProcess!);
         }
       }
     });

     stream.onError((error) async {
       await _remove(index);
       _currentRunningUploadProcess = null;
       uploadProgress.remove(index);
       stream.cancel();
       _uploadStreams.remove(stream);
       _currentRunningStreamUpload = null;
       if (_uploadProcess.isNotEmpty){
         _currentRunningUploadProcess = _uploadProcess.removeFirst();
         _activateUploadProcess(_currentRunningUploadProcess!);
       }
     });
   }

   Future _editProject(int index , String imgUrl , Future<dynamic> Function(Project) useCaseAction) async {
     var projects = viewState.projects;
     var projectWrapper = viewState.projects[index];
     projectWrapper.pickedImage = null;
     projectWrapper.project.image = imgUrl;
     projectWrapper.downloading = false;
     var result = await useCaseAction(projectWrapper.project);
     if (result is ShowErrorDialog){
       print("error "+result.error);
       _logicStreamController.add(result);
       projects.removeAt(index);
       viewState = viewState.copy(projects: projects);
       _logicStreamController.add(DeleteProjectFromList(projectWrapper , 0));
       return;
     }
     projects.removeAt(index);
     projects.insert(index, projectWrapper);
     viewState = viewState.copy(projects: projects);
     update();
   }

   Future _remove(int index) async{
     var projects = viewState.projects;
     projects.removeAt(index);
     viewState = viewState.copy(projects: projects);
     update();
   }

   // Future addProject(ProjectWrapper projectWrapper , File image) async {
   //   var projects = viewState.projects;
   //   projectWrapper.pickedImage = image;
   //   projects.insert(0, projectWrapper);
   //   viewState = viewState.copy(projects: projects);
   //   _logicStreamController.add(InsertProjectToList(0));
   //   // var result = await _useCase.addProject(image, projectWrapper.project);
   //   // if (result is ShowErrorDialog){
   //   //   print("error "+result.error);
   //   //    _logicStreamController.add(result);
   //   //    projects.removeAt(0);
   //   //    viewState = viewState.copy(projects: projects);
   //   //    _logicStreamController.add(DeleteProjectFromList(projectWrapper , 0));
   //   // }
   // }

   Future addProject(ProjectWrapper projectWrapper , File image) async {
     var projects = viewState.projects;
     projectWrapper.pickedImage = image;
     projectWrapper.downloading = true;
     projects.insert(0, projectWrapper);
     viewState = viewState.copy(projects: projects);
     _logicStreamController.add(InsertProjectToList(0));
     uploadImage(image, _uploadProcess.length);
   }

   Future editProject(ProjectWrapper projectWrapper , int index , File? image) async {
     var projects = viewState.projects;
     var oldProject = projects[index];
     projectWrapper.pickedImage = image;
     if (image != null){
       projectWrapper.downloading = true;
     }
     projects.removeAt(index);
     projects.insert(index, projectWrapper);
     viewState = viewState.copy(projects: projects);
     update();
     if (image != null){
       uploadImage(image, _uploadProcess.length);
     } else {
       var result = await _useCase.updateProject(projectWrapper.project);
       if (result is ShowErrorDialog){
         _logicStreamController.add(result);
         projects.removeAt(index);
         projects.insert(index, oldProject);
         viewState = viewState.copy(projects: projects);
         update();
         return;
       } 
     }
   }

   Future deleteProject(int index) async {
     if (_currentRunningUploadProcess != null){
       _currentRunningUploadProcess!.cancel();
       _currentRunningStreamUpload!.cancel();
       uploadProgress.remove(index);
       _uploadProcess.remove(_currentRunningUploadProcess);
       _uploadStreams.remove(_currentRunningStreamUpload);
     }


     var projects = viewState.projects;
     var oldProject = projects[index];
     projects.removeAt(index);
     viewState = viewState.copy(projects: projects);

     if (viewState.projects.isEmpty){
       update();
     }

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