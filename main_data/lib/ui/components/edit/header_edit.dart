import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HeaderEdit extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  final Function(File) pickImage;
  final File pickedImage;
  final bool showPickedImage;
  final String currentImage;
  final Function() saveChanges;
  final Function(String) enterName;
  final Function(String) enterCareer;
  final TextEditingController userNameController;
  final TextEditingController careerController;


  HeaderEdit({
    Key? key,
    required String username,
    required String career,
    required this.pickImage,
    required this.pickedImage,
    required this.currentImage,
    required this.saveChanges,
    required this.userNameController,
    required this.careerController,
    required this.enterCareer,
    required this.enterName,
    required this.showPickedImage
  }) : super(key: key){
    userNameController.text = username;
    careerController.text = career;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null){
                    pickImage(File(image.path));
                  }
                },
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  padding: const EdgeInsets.only(left: 20.0 , top: 20.0),
                  child: showPickedImage ? CircleAvatar(backgroundImage: FileImage(pickedImage)):
                  currentImage == "" ?
                  const CircleAvatar(backgroundImage: AssetImage("assets/images/person.jpg")):
                  CircleAvatar(backgroundImage: NetworkImage(currentImage),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15.0,),
                      TextField(
                        controller: userNameController,
                        onChanged: (text){
                          enterName(text);
                        },
                        decoration: const InputDecoration(
                          label: Text("User name" , style: TextStyle(
                            fontSize: 18.0
                          ),),
                        ),
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 28.0,),
                      TextField(
                        controller: careerController,
                        onChanged: (text){
                          enterCareer(text);
                        },
                        decoration: const InputDecoration(
                          label: Text("Career" , style: TextStyle(
                              fontSize: 18.0
                          ),),
                        ),
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: IconButton(onPressed: (){
            saveChanges();
          }, icon: const Icon(Icons.done)),
        )
      ],
    );
  }

}