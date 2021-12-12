import 'package:flutter/material.dart';
import 'package:projects/ui/components/body.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects" , style: TextStyle(
            color: Colors.black
        ),),
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: const Icon(Icons.arrow_back , color: Colors.black,),
        ),
      ),
      body: const Body(),
    );
  }
}
