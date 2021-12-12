import 'dart:io';

import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:projects/logic/project_wrapper.dart';

class ProjectItem extends StatelessWidget {

  final ProjectWrapper projectWrapper;
  final Future Function(ProjectWrapper) goToEdit;
  final Function(ProjectWrapper) delete;


  const ProjectItem({Key? key ,
    required this.projectWrapper ,
    required this.goToEdit, required this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: projectWrapper.pickedImage != null ? Image.file(
                    projectWrapper.pickedImage! ,
                    height: 200.0,
                    width: 100.0,
                    fit: BoxFit.fill
                ) : Image.network(
                  projectWrapper.project.image! ,
                  height: 200.0,
                  width: 100.0,
                  fit: BoxFit.fill
                ),
              ),
              const SizedBox(width: 20.0,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(projectWrapper.project.title , style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),),
                  Text(projectWrapper.project.description , maxLines: 3,),
                  OutlinedButton(onPressed: (){}, child:const Text("Visit") )
                ],
              )
            ],
          ),
          Column(
            children: [
              IconButton(onPressed: ()async{
                await goToEdit(projectWrapper);
              }, icon: const Icon(Icons.create)),
              const SizedBox(height: 20.0,),
              IconButton(onPressed: (){
                delete(projectWrapper);
              }, icon: const Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
