import 'package:equatable/equatable.dart';

class Skill extends Equatable{
   String id;
   String name;

  Skill({required this.id,required this.name});

  factory Skill.init(){
    return Skill(id: "", name: "");
  }

  @override
  List<Object?> get props => [ name];

  static Skill fromMap(Map<String , dynamic> map){
    return  Skill(id: map["id"], name: map["name"]);
  }

  Map<String , dynamic> toMap(){
    return {
      "id" : id,
      "name" : name
    };
  }
}