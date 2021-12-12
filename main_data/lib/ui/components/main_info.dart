import 'package:flutter/material.dart';
import 'package:main_data/ui/components/main_info_item.dart';

class MainInfo extends StatelessWidget {

  final String descriptionValue;
  final String emailValue;
  final String phoneValue;

  final Function() editMode;

  const MainInfo({
    Key? key,
    required this.descriptionValue,
    required this.emailValue,
    required this.phoneValue,
    required this.editMode
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
            MainInfoItem(label: "Phone :", value: phoneValue)
          ],
        ),
      ),
    );
  }
}
