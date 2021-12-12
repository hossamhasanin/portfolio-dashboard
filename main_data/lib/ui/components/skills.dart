
import 'package:base/base.dart';
import 'package:flutter/material.dart';

class Sills extends StatelessWidget {

  final List<Skill> skills;
  final Function() openSkillsDialog;

  const Sills({Key? key , required this.skills , required this.openSkillsDialog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("skills "+skills.toString());
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
                child: Text("Skills" , style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),),
              ),
              IconButton(onPressed: (){
                openSkillsDialog();
              }, icon: const Icon(Icons.create)),
            ],
          ),
          Wrap(
            spacing: 5.0,
            children: skills.map((skill) =>
                Chip(label: Text(skill.name))).toList(),
          )
        ],
      ),
    );
  }
}
