import 'dart:io';

import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/logic/modify_project_controller.dart';
import 'package:projects/logic/modify_projects_viewstate.dart';
import 'package:projects/logic/project_wrapper.dart';
import 'package:projects/ui/components/view_project_image.dart';

class ModifyProject extends StatelessWidget {
  final ProjectWrapper? projectWrapper;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? imagePath;
  final ModifyProjectController _controller = Get.put(ModifyProjectController());


  ModifyProject({Key? key , required this.projectWrapper}) : super(key: key){
    _controller.checkIfPassedProject(projectWrapper);
    if (projectWrapper != null){
      List<String> skills = [];
      skills.addAll(projectWrapper!.project.skills);
      _controller.setSkills(skills);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (projectWrapper != null){
      _titleController.text = projectWrapper!.project.title;
      _descriptionController.text = projectWrapper!.project.description;
      _urlController.text = projectWrapper!.project.url;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Project" , style: TextStyle(
            color: Colors.black
        ),),
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Get.back();
        },
          icon: const Icon(Icons.arrow_back , color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0 , top: 20.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (projectWrapper == null){
                        _pickImage();
                      } else {
                        showDialog(context: context, builder: (_){
                          return Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OutlinedButton(onPressed: () async {
                                  Get.to(ViewProjectImage(
                                    image: projectWrapper!.project.image!,
                                    title: projectWrapper!.project.title,
                                  ));
                                }, child: const Text("View")),
                                OutlinedButton(onPressed: () async {
                                  _pickImage();
                                }, child: const Text("Change")),
                              ],
                            ),
                          );
                        });
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: GetBuilder<ModifyProjectController>(
                          init: _controller,
                          builder: (controller){
                        var viewState = controller.viewState;
                        if (viewState.projectImageCases == ProjectImageCases.ASSETS){
                          return Image.asset("assets/images/placeholder_project.jpg" ,
                            width: 200.0, height: 300.0,fit: BoxFit.fill,);
                        } else if (viewState.projectImageCases == ProjectImageCases.NETWORK){
                          return Image.network(projectWrapper!.project.image! ,
                            width: 200.0, height: 300.0,fit: BoxFit.fill,);
                        } else if (viewState.projectImageCases == ProjectImageCases.PICKED){
                          var path = imagePath ?? projectWrapper!.pickedImage!.path;
                          return Image.file(File(path) ,
                            width: 200.0, height: 300.0,fit: BoxFit.fill,);
                        } else {
                          return Container();
                        }
                      }),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0 , top: 20.0 , right: 5.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            label: Text("Title"),
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(height: 18.0,),
                        TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Description"
                          ),
                          maxLines: 4,
                          textAlignVertical: TextAlignVertical.top,
                        ),
                        const SizedBox(height: 18.0,),
                        TextField(
                          controller: _urlController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Url link"
                          ),
                          maxLines: 3,
                          textAlignVertical: TextAlignVertical.top,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20.0,),
            Container(
              width: double.infinity,
              height: 220.0,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(color: Colors.grey , blurRadius: 5.0 , offset: Offset(0.0, 1.0))
                  ]
              ),
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Skills :"),
                      IconButton(onPressed: (){
                        _controller.addNewSkill();
                      }, icon: const Icon(Icons.add))
                    ],
                  ),
                  Expanded(
                      child: GetBuilder<ModifyProjectController>(
                        init: _controller,
                        builder: (controller) {
                          var skills = controller.viewState.skills;
                          if (skills.isEmpty){
                            return const Center(
                              child: Text("No skills yet"),
                            );
                          }
                          return ListView.builder(
                            itemCount: skills.length,
                            itemBuilder: (_ , index){
                              return Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: TextEditingController(text: skills[index]),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder()
                                      ),
                                      onChanged: (skill){
                                        controller.enterSkill(index, skill);
                                        print("koko "+controller.viewState.skills.toString());
                                        print("koko "+projectWrapper!.project.skills.toString());

                                      },
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    controller.deleteSkill(index);
                                  }, icon: const Icon(Icons.cancel))
                                ],
                              );
                            },
                          );
                        }
                      )
                  )
                ],
              ),
            ),
            ElevatedButton(onPressed: (){

              if (
                    (_titleController.value.text.isNotEmpty &&
                     _descriptionController.value.text.isNotEmpty &&
                     _urlController.value.text.isNotEmpty
                    ) &&
                    (imagePath != null ||
                     projectWrapper != null
                    ) &&
                    (
                      _controller.viewState.skills.isNotEmpty
                    )
              ){
                var p = _controller.viewState.skills == projectWrapper!.project.skills;
                print("koko "+_controller.viewState.skills.toString());
                print("koko "+projectWrapper!.project.skills.toString());
                print("koko "+p.toString());
                if (projectWrapper != null){
                  if (_titleController.value.text != projectWrapper!.project.title ||
                      _descriptionController.value.text != projectWrapper!.project.description ||
                      _urlController.value.text != projectWrapper!.project.url ||
                      imagePath != null ||
                      _controller.viewState.skills != projectWrapper!.project.skills
                  ){
                    add();
                  }
                } else {
                  add();
                }
              }


            }, child: projectWrapper == null ? const Text("Add") : const Text("Update") ,
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200.0, 25.0)
            ),)
          ],
        ),
      ),
    );
  }

  _pickImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null){
      imagePath = image.path;
      _controller.showPickedImage();
    }
  }
  add(){
    ProjectWrapper newProjectWrapper = ProjectWrapper(Project(
        id : projectWrapper != null ? projectWrapper!.project.id! : DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.value.text,
        description: _descriptionController.value.text,
        url: _urlController.value.text,
        image: projectWrapper != null ? projectWrapper!.project.image : "",
        skills: _controller.viewState.skills
    ), imagePath != null ? File(imagePath!) : null);
    Get.back(result: [newProjectWrapper , imagePath != null ? File(imagePath!) : null]);
  }
}
