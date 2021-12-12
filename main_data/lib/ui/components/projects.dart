
import 'package:base/destination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Projects extends StatelessWidget {
  final int projectsNumber;
  final int likesNumber;
  const Projects({Key? key , required this.projectsNumber, required this.likesNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text("Projects" , style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: GestureDetector(
                  onTap: (){
                    Get.toNamed(PROJECTS_SCREEN);
                  },
                  child: const Text("Browse" , style: TextStyle(
                      fontSize: 16.0,
                      decoration: TextDecoration.underline,
                  ),),
                ),
              )
            ],
          ),
          const SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue , width: 5),
                        borderRadius: BorderRadius.circular(25.0)
                      ),
                      child: Center(child: Text(projectsNumber.toString() , style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),)),
                    ),
                    const SizedBox(height: 10.0,),
                    const Text("Projects Done" , style: TextStyle(
                        fontWeight: FontWeight.bold
                    ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue , width: 5),
                        borderRadius: BorderRadius.circular(25.0)
                      ),
                      child: Center(child: Text(likesNumber.toString() , style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),)),
                    ),
                    const SizedBox(height: 10.0,),
                    const Text("Likes" , style: TextStyle(
                        fontWeight: FontWeight.bold
                    ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
