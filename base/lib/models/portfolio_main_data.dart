import 'package:equatable/equatable.dart';

class PortfolioMainData extends Equatable{
  String? ownerName;
  String? ownerImage;
  String? career;
  String? description;
  String? email;
  String? phone;
  int? yearsOfExperience;

  PortfolioMainData({
    required this.ownerName,
    required this.career,
    required this.phone,
    required this.email,
    required this.description,
    required this.yearsOfExperience,
    required this.ownerImage
  });

  factory PortfolioMainData.init(){
    return PortfolioMainData(
        ownerName: "",
        career: "",
        description: "",
        ownerImage: "",
        yearsOfExperience: 0,
        email: "",
        phone: ""
    );
  }

  factory PortfolioMainData.notAssigned(){
    return PortfolioMainData(
        ownerName: "Not assigned",
        career: "Not assigned",
        description: "Not assigned",
        ownerImage: "",
        yearsOfExperience: 0,
        email: "",
        phone: ""
    );
  }

  PortfolioMainData fromAnother(PortfolioMainData portfolioMainData){
    return PortfolioMainData(
        ownerName: portfolioMainData.ownerName != "" ? portfolioMainData.ownerName : ownerName,
        career: portfolioMainData.career != "" ? portfolioMainData.career : career,
        phone: portfolioMainData.phone != "" ? portfolioMainData.phone : phone,
        email: portfolioMainData.email != "" ? portfolioMainData.email : email,
        description: portfolioMainData.description != "" ? portfolioMainData.description : description,
        yearsOfExperience: portfolioMainData.yearsOfExperience != 0 ? portfolioMainData.yearsOfExperience : yearsOfExperience,
        ownerImage: portfolioMainData.ownerImage != "" ? portfolioMainData.ownerImage : ownerImage);
  }

  static PortfolioMainData fromMap(Map<String , dynamic> map){
    return PortfolioMainData(
        ownerName: map["ownerName"],
        ownerImage: map["ownerImage"],
        career: map["career"],
        description: map["description"],
        yearsOfExperience: map["yearsOfExperience"],
        email: map["email"],
        phone: map["phone"]
    );
  }

  Map<String , dynamic> toMap(){
    return {
      "ownerName" : ownerName,
      "ownerImage" : ownerImage,
      "career" : career,
      "description" : description,
      "yearsOfExperience" : yearsOfExperience,
      "email" : email,
      "phone" : phone,
    };
  }

  @override
  List<Object?> get props => [
    ownerName,
    career,
    description,
    yearsOfExperience,
    email,
    phone
  ];
}