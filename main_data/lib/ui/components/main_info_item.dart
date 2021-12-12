import 'package:flutter/material.dart';

class MainInfoItem extends StatelessWidget {
  final String label;
  final String value;
  const MainInfoItem({Key? key , required this.label , required this.value}) : super(key: key);

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
            child: Text(value , style: const TextStyle(
                fontSize: 14.0,
            ) ,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
