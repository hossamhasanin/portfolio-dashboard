import 'package:flutter/material.dart';
import 'package:main_data/ui/components/main_info_item.dart';

class MainInfo extends StatelessWidget {

  final String descriptionValue;
  final String emailValue;
  final String phoneValue;
  final int yearsOfExperience;
  final String location;
  final String facebookAccount;
  final String linkedInAccount;
  final String githubAccount;
  final String twitterAccount;

  final Function() editMode;

  const MainInfo({
    Key? key,
    required this.descriptionValue,
    required this.emailValue,
    required this.phoneValue,
    required this.editMode,
    required this.yearsOfExperience,
    required this.location,
    required this.facebookAccount,
    required this.linkedInAccount,
    required this.githubAccount,
    required this.twitterAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.grey , blurRadius: 5.0 , offset: Offset(0.0, 1.0))
          ]
      ),
      padding: const EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Main Data" , style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),),
                IconButton(onPressed: (){
                  editMode();
                }, icon: const Icon(Icons.create))
              ],
            ),
            const SizedBox(height: 20.0,),
            MainInfoItem(label: "Description :", value: descriptionValue),
            const SizedBox(height: 20.0,),
            MainInfoItem(label: "Email :", value: emailValue),
            const SizedBox(height: 20.0,),
            MainInfoItem(label: "Phone :", value: phoneValue),
            const SizedBox(height: 20.0,),
            MainInfoItem(label: "Years of experience :", value: yearsOfExperience.toString()),
            const SizedBox(height: 20.0,),
            MainInfoItem(label: "Location :", value: location),
            const SizedBox(height: 20.0,),
            MainInfoItem(label: "Facebook :", value: facebookAccount),
            const SizedBox(height: 20.0,),
            MainInfoItem(label: "Twitter :", value: twitterAccount),
            const SizedBox(height: 20.0,),
            MainInfoItem(label: "Github :", value: githubAccount),
            const SizedBox(height: 20.0,),
            MainInfoItem(label: "LinkedIn :", value: linkedInAccount),
          ],
        ),
      ),
    );
  }
}
