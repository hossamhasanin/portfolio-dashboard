import 'package:base/models/skill.dart';
import 'package:equatable/equatable.dart';

class SkillWrapper extends Equatable{

  final Skill skill;
  final bool editing;

  const SkillWrapper({required this.skill,required this.editing});

  factory SkillWrapper.fromSkill(Skill skill , {bool editing = false}){
    return SkillWrapper(skill: skill, editing: editing);
  }


  @override
  List<Object?> get props => [skill , editing];
}