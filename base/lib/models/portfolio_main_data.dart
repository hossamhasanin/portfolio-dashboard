import 'package:equatable/equatable.dart';

class PortfolioMainData extends Equatable{
  String? ownerName;
  String? ownerImage;
  String? career;
  String? description;
  String? email;
  String? phone;
  String? cvUrl;
  String? location;
  String? facebookAccount;
  String? twitterAccount;
  String? githubAccount;
  String? linkedInAccount;
  int? yearsOfExperience;

  PortfolioMainData({
    required this.ownerName,
    required this.career,
    required this.phone,
    required this.email,
    required this.description,
    required this.yearsOfExperience,
    required this.ownerImage,
    required this.cvUrl,
    required this.location,
    required this.facebookAccount,
    required this.twitterAccount,
    required this.githubAccount,
    required this.linkedInAccount,
  });

  factory PortfolioMainData.init(){
    return PortfolioMainData(
        ownerName: "",
        career: "",
        description: "",
        ownerImage: "",
        yearsOfExperience: 0,
        email: "",
        phone: "",
        cvUrl: "",
        location: "",
        facebookAccount: "",
        githubAccount: "",
        linkedInAccount: "",
        twitterAccount: "",
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
        phone: "",
        cvUrl: "",
        location: "",
        facebookAccount: "",
        githubAccount: "",
        linkedInAccount: "",
        twitterAccount: "",
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
        ownerImage: portfolioMainData.ownerImage != "" ? portfolioMainData.ownerImage : ownerImage,
        cvUrl: portfolioMainData.cvUrl != "" ? portfolioMainData.cvUrl : cvUrl,
        location: portfolioMainData.location != "" ? portfolioMainData.location : location,
        facebookAccount: portfolioMainData.facebookAccount != "" ? portfolioMainData.facebookAccount : facebookAccount,
        twitterAccount: portfolioMainData.twitterAccount != "" ? portfolioMainData.twitterAccount : twitterAccount,
        githubAccount: portfolioMainData.githubAccount != "" ? portfolioMainData.githubAccount : githubAccount,
        linkedInAccount: portfolioMainData.linkedInAccount != "" ? portfolioMainData.linkedInAccount : linkedInAccount,
    );
  }

  static PortfolioMainData fromMap(Map<String , dynamic> map){
    return PortfolioMainData(
        ownerName: map["ownerName"] ?? "",
        ownerImage: map["ownerImage"] ?? "",
        career: map["career"] ?? "",
        description: map["description"] ?? "",
        yearsOfExperience: map["yearsOfExperience"] ?? 0,
        email: map["email"] ?? "",
        phone: map["phone"] ?? "",
        cvUrl: map["cvUrl"] ?? "",
        location: map["location"] ?? "",
        facebookAccount: map["facebookAccount"] ?? "",
        githubAccount: map["githubAccount"] ?? "",
        linkedInAccount: map["linkedInAccount"] ?? "",
        twitterAccount: map["twitterAccount"] ?? "",
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
      "cvUrl" : cvUrl,
      "location" : location,
      "facebookAccount" : facebookAccount,
      "githubAccount" : githubAccount,
      "linkedInAccount" : linkedInAccount,
      "twitterAccount" : twitterAccount,
    };
  }

  @override
  List<Object?> get props => [
    ownerName,
    career,
    description,
    yearsOfExperience,
    email,
    phone,
    cvUrl,
    location,
    facebookAccount,
    githubAccount,
    linkedInAccount,
    twitterAccount,
  ];
}