import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String userName;
  final String career;
  final String image;
  final Function() startEditing;

  const Header({
    Key? key,
    required this.career,
    required this.userName,
    required this.image,
    required this.startEditing
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              padding: const EdgeInsets.only(left: 20.0 , top: 20.0),
              child: image == "" ?
              const CircleAvatar(backgroundImage: AssetImage("assets/images/person.jpg"),) :
              CircleAvatar(backgroundImage: NetworkImage(image)),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15.0,),
                  Text(userName , style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),),
                  const SizedBox(height: 28.0,),
                  Text(career)
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: IconButton(onPressed: (){
            startEditing();
          }, icon: Icon(Icons.create)),
        )
      ],
    );
  }
}