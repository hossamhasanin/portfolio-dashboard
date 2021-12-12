import 'package:flutter/material.dart';

class ViewProjectImage extends StatelessWidget {
  final String image;
  final String title;
  const ViewProjectImage({Key? key , required this.image , required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(image),
          ],
        ),
      ),
    );
  }
}
