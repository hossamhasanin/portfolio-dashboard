import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:main_data/logic/skill_wrapper.dart';

class PopUpSkills extends StatelessWidget {
  final List<SkillWrapper> skills;
  final Function() addMore;
  final Function(SkillWrapper , int) delete;
  final Function(int , Skill) update;
  final Function(int , SkillWrapper) enterSkill;
  final List<TextEditingController> textControllers;


  const PopUpSkills({Key? key ,
    required this.skills ,
    required this.addMore,
    required this.delete,
    required this.update,
    required this.enterSkill,
    required this.textControllers
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: skills.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        skills.isEmpty ? const Text("No skills yet") : Expanded(
          child: ListView.builder(
              itemCount: skills.length,
              itemBuilder: (_ , index){
                  // return ListTile(
                  //   title: Text(skills[index].name),
                  //   trailing: IconButton(onPressed: (){} , icon: const Icon(Icons.create),),
                  // );

                if (textControllers.length == index){
                  textControllers.add(TextEditingController(text: skills[index].skill.name));
                }

                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textControllers[index],
                        onChanged: (text){
                          if (text == skills[index].skill.name && !skills[index].editing){
                            return;
                          }
                          print("koko clicked "+text);
                          enterSkill(index , SkillWrapper.fromSkill(Skill(id: skills[index].skill.id ,name: textControllers[index].value.text) , editing: skills[index].editing));
                        },
                        decoration: InputDecoration(
                          enabledBorder: skills[index].editing ? const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)
                          ) : const OutlineInputBorder(),
                          focusedBorder: skills[index].editing ? const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)
                          ) : const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)
                          ),
                          border: skills[index].editing ? const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)
                          ) : const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)
                          ),
                          disabledBorder: skills[index].editing ? const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)
                          ) : const OutlineInputBorder()
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0,),
                    GestureDetector(
                        onTap: (){
                          update(index , Skill(id: skills[index].skill.id, name: textControllers[index].value.text));
                        },
                        child: const Icon(Icons.done)
                    ),
                    const SizedBox(width: 10.0,),
                    GestureDetector(
                        onTap: (){
                          delete(skills[index] , index);
                        },
                        child: const Icon(Icons.delete)
                    )
                  ],
                );
              }),
        ),
        ElevatedButton(onPressed: (){
          addMore();
        }, child: const Text("Add more"))
      ],
    );
  }
}
