import 'package:flutter/material.dart';

class MainInfoItemEdit extends StatelessWidget {
  final String label;
  final String value;
  final String hintValue;
  final int maxLines;

  final Function(String) valueChanged;
  final TextEditingController _textController = TextEditingController();

  MainInfoItemEdit({Key? key ,
    required this.value ,
    required this.label ,
    required this.hintValue ,
    required this.valueChanged ,
    required this.maxLines
  }) : super(key: key){
    _textController.text = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label , style: const TextStyle(
              fontSize: 14.0
          ),),
          const SizedBox(width: 20.0,),
          Expanded(
            child: TextField(
            onChanged: (text){
              valueChanged(text);
            }, style: const TextStyle(
              fontSize: 14.0,
            ),
              controller: _textController,
              decoration: InputDecoration(
                hintText: hintValue,
                border: const OutlineInputBorder()
              ),
              maxLines: maxLines,
            ),
          )
        ],
      ),
    );
  }
}
