import 'package:flutter/material.dart';
import 'package:main_data/ui/components/body.dart';

class MainDataScreen extends StatelessWidget {
  const MainDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard" , style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.white,
      ),
      body: const Body(),
    );
  }
}
