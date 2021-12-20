import 'package:equatable/equatable.dart';

class Project extends Equatable{

  String? id;
  final String title;
  final String description;
  final String url;
  String? image;
  final List<String> skills;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.image,
    required this.skills
  });

  factory Project.empty(){
    return Project(
        id: "",
        title: "",
        description: "",
        url: "",
        image: "",
        skills: const []
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    url,
    description,
    image,
    skills
  ];

  Map<String , dynamic> toMap(){
    return {
      "id" : id,
      "title" : title,
      "description" : description,
      "url" : url,
      "image" : image,
      "skills": skills
    };
  }

  static Project fromMap(Map<String , dynamic> map){
    return Project(
        id: map["id"],
        title: map["title"],
        description: map["description"],
        url: map["url"],
        image: map["image"],
        skills: (map["skills"] as List<dynamic>).cast<String>(),
    );
  }

}