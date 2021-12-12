import 'package:flutter/material.dart';
import 'package:main_data/ui/components/edit/main_info_item_edit.dart';

class MainInfoEdit extends StatelessWidget {

  final String descriptionValue;
  final String emailValue;
  final String phoneValue;

  final Function(String) emailChanged;
  final Function(String) descriptionChanged;
  final Function(String) phoneChanged;
  final Function() doneEditing;

  const MainInfoEdit({
    Key? key,
    required this.descriptionValue,
    required this.emailValue,
    required this.phoneValue,
    required this.descriptionChanged,
    required this.emailChanged,
    required this.phoneChanged,
    required this.doneEditing
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
            },hintValue: "Enter the phone ...",maxLines: 1,)
          ],
        ),
      ),
    );
  }
}
