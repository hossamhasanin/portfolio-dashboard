import 'dart:async';
import 'dart:io';

import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/logic/logic_events.dart';
import 'package:projects/logic/project_wrapper.dart';
import 'package:projects/logic/projects_controller.dart';
import 'package:projects/logic/usecase.dart';
import 'package:projects/logic/viewstate.dart';
import 'package:projects/ui/components/uploading_project_item.dart';
import 'package:projects/ui/components/modify_project.dart';
import 'package:projects/ui/components/project_item.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  final ProjectsController _controller = Get.put(ProjectsController(Get.find()));

  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  StreamSubscription<LogicEvents>? eventsListener;


  @override
  void initState() {
    super.initState();

    _controller.getProjects();
    
    eventsListener = _controller.logicEventsStream.listen((event) {
      if (event is DeleteProjectFromList){
        listKey.currentState!.removeItem(event.index, (context, animation) =>
            SizeTransition(sizeFactor: animation , child: ProjectItem(
              projectWrapper: event.projectWrapper,
              goToEdit: (_)async{},
              delete: (){},
            ),),
        );
      }

      if (event is InsertProjectToList){
        if (listKey.currentState != null){
          listKey.currentState!.insertItem(event.index);
        } else {
          _controller.update();
        }
      }
    });
  }

  @override
  void dispose() {
    if (eventsListener != null){
      eventsListener!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            var results = await Get.to(ModifyProject(
              projectWrapper: null,
            ));
            if (results != null){
              ProjectWrapper projectWrapper = results[0];
              print("project "+projectWrapper.toString());
              File? pickedImage = results[1];
              _controller.addProject(projectWrapper, pickedImage!);
            }
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.grey , blurRadius: 5.0 , offset: Offset(0.0, 1.0))
                ]
            ),
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 20.0,),
                Center(
                    child: Text("Add new" , style:  TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),)
                )
              ],
            ),
          ),
        ),
        GetBuilder<ProjectsController>(init : _controller, builder: (_){
          print("projects "+_controller.viewState.projects.toString());
          return _controller.viewState.loadingProjects ?
          const Center(
            child: CircularProgressIndicator(),
          )
              : _controller.viewState.errorProjects.isEmpty ?
          _controller.viewState.projects.isEmpty ?
             const Expanded(child: Center(child: Text("No projects yet "),)) :
          Expanded(child: AnimatedList(
            key: listKey,
            initialItemCount: _controller.viewState.projects.length,
            itemBuilder: (_ , index , animation){
              if (_controller.viewState.projects[index].downloading){
                return UploadingProjectItem(
                  projectWrapper: _controller.viewState.projects[index],
                  goToEdit: (projectWrapper) async {
                    var results = await Get.to(ModifyProject(
                      projectWrapper: projectWrapper,
                    ));
                    if (results != null){
                      ProjectWrapper newProject = results[0];
                      File? pickedImage = results[1];
                      _controller.editProject(newProject, index , pickedImage);
                    }
                  },
                  delete: (){
                    deleteProject(index);
                  },
                  progress: _controller.uploadProgress[index]!,
                );
              }
              return ProjectItem(
                projectWrapper: _controller.viewState.projects[index],
                goToEdit: (projectWrapper) async {
                  var results = await Get.to(ModifyProject(
                    projectWrapper: projectWrapper,
                  ));
                  if (results != null){
                    ProjectWrapper newProject = results[0];
                    File? pickedImage = results[1];
                    _controller.editProject(newProject, index , pickedImage);
                  }
                },
                delete: (){
                  deleteProject(index);
                },
              );
            },
          )) : Center(
            child: Text(_controller.viewState.errorProjects),
          );
        })
      ],
    );
  }
  
  deleteProject(int index){
    showDialog(context: context, builder: (_){
      return AlertDialog(
        title: const Text("Delete"),
        content: const Text("Are you sure you want to delete ?"),
        actions: [
          ElevatedButton(
              onPressed: (){
                _controller.deleteProject(index);
              },
              child: const Text("Yes")
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("No")
          )
        ],
      );
    });
  }
}
