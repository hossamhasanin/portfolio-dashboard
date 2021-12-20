import 'package:flutter/material.dart';
import 'package:main_data/ui/components/edit/main_info_item_edit.dart';

class MainInfoEdit extends StatelessWidget {

  final String descriptionValue;
  final String emailValue;
  final String phoneValue;
  final int yearsOfExperience;
  final String location;
  final String facebookAccount;
  final String linkedInAccount;
  final String githubAccount;
  final String twitterAccount;

  final Function(String) emailChanged;
  final Function(String) descriptionChanged;
  final Function(String) phoneChanged;
  final Function(int) yearsOfExperienceChanged;
  final Function(String) locationChanged;
  final Function(String) facebookAccountChanged;
  final Function(String) twitterAccountChanged;
  final Function(String) linkedInAccountChanged;
  final Function(String) githubAccountChanged;
  final Function() doneEditing;

  const MainInfoEdit({
    Key? key,
    required this.descriptionValue,
    required this.emailValue,
    required this.phoneValue,
    required this.descriptionChanged,
    required this.emailChanged,
    required this.phoneChanged,
    required this.yearsOfExperienceChanged,
    required this.locationChanged,
    required this.doneEditing,
    required this.yearsOfExperience,
    required this.location,
    required this.facebookAccount,
    required this.linkedInAccount,
    required this.githubAccount,
    required this.twitterAccount,
    required this.twitterAccountChanged,
    required this.facebookAccountChanged,
    required this.githubAccountChanged,
    required this.linkedInAccountChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      margin: const EdgeInsets.all(20.0),
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
                  doneEditing();
                }, icon: const Icon(Icons.done))
              ],
            ),
            const SizedBox(height: 20.0,),
            MainInfoItemEdit(
              label: "Description :",
              value: descriptionValue,
              valueChanged: (description){
                descriptionChanged(description);
              },
              hintValue: "Entert your description",
              maxLines: 4,
            ),
            const SizedBox(height: 20.0,),
            MainInfoItemEdit(
              label: "Email :",
              value: emailValue,
              valueChanged: (email){
                emailChanged(email);
              },
              hintValue: "Enter you email ...",
              maxLines: 1,
            ),
            const SizedBox(height: 20.0,),
            MainInfoItemEdit(label: "Phone :", value: phoneValue , valueChanged: (phone){
              phoneChanged(phone);
            },hintValue: "Enter the phone ...",maxLines: 1,),
            const SizedBox(height: 20.0,),
            MainInfoItemEdit(label: "Years of experience :", value: yearsOfExperience.toString() , valueChanged: (years){
              yearsOfExperienceChanged(years.isNotEmpty ? int.parse(years) : 0);
            },hintValue: "How long your experience ...",maxLines: 1,),
            const SizedBox(height: 20.0,),
            MainInfoItemEdit(label: "Location :", value: location , valueChanged: (location){
              locationChanged(location);
            },hintValue: "Address or business address ...",maxLines: 1,),

            const SizedBox(height: 20.0,),
            MainInfoItemEdit(label: "Facebook :", value: facebookAccount , valueChanged: (account){
              facebookAccountChanged(account);
            },hintValue: "Your facebook ...",maxLines: 1,),
            const SizedBox(height: 20.0,),
            MainInfoItemEdit(label: "Twitter :", value: twitterAccount , valueChanged: (account){
              twitterAccountChanged(account);
            },hintValue: "Your twitter...",maxLines: 1,),
            const SizedBox(height: 20.0,),
            MainInfoItemEdit(label: "LinkedIn :", value: linkedInAccount , valueChanged: (account){
              linkedInAccountChanged(account);
            },hintValue: "Your linkedIn ...",maxLines: 1,),
            const SizedBox(height: 20.0,),
            MainInfoItemEdit(label: "Github :", value: githubAccount , valueChanged: (account){
              githubAccountChanged(account);
            },hintValue: "Your github ...",maxLines: 1,),

          ],
        ),
      ),
    );
  }
}
