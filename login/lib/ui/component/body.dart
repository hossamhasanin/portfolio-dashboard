import 'dart:async';

import 'package:base/destination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/logic/business_logic_events.dart';
import 'package:login/logic/controller.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _controller = Get.find();
  BuildContext? _dialogContext;

  StreamSubscription? _logicEventsListener;

  @override
  void initState() {
    super.initState();

    _logicEventsListener = _controller.businessLogicEventsStream.listen((event) {
      if (_dialogContext != null){
        Navigator.pop(_dialogContext!);
        _dialogContext = null;
      }

      if (event is ShowLoadingDialog){
        _dialogContext = Get.overlayContext;
        showDialog(context: _dialogContext!, builder: (_){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: SizedBox(
              height: 150.0,
              width: 300.0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    children: const [
                      Text("Wait ..."),
                      SizedBox(width: 10.0,),
                      CircularProgressIndicator()
                    ],
                  ),
                ),
              ),
            ),
          );
        } , barrierDismissible: true);
      }

      if (event is ShowErrorDialog){
        _dialogContext = Get.overlayContext;
        showDialog(context: _dialogContext!, builder: (_){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: SizedBox(
              height: 200.0,
              width: 300.0,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Text(_viewLoginErrorMessage(event.error) ,
                      style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 18.0)),
                ),
              ),
            ),
          );
        });
      }

      if (event is GoToMainScreenScreen){
        _dialogContext = Get.overlayContext;
        showDialog(context: _dialogContext!, builder: (_){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              height: 200.0,
              width: 300.0,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login successfully" ,
                      style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18.0)),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(_dialogContext!);
                        Get.offNamed(SPLASH_SCREEN);
                        _dialogContext = null;
                      }, child: const Text("Done"))
                ],
              ),
            ),
          );
        } , barrierDismissible: false);
      }

      if (event is GoToFillDataScreen){
        _dialogContext = Get.overlayContext;
        showDialog(context: _dialogContext!, builder: (_){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              height: 200.0,
              width: 300.0,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login successfully now finish your portfolio main data" ,
                    style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18.0),),
                  const SizedBox(height: 20.0,),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(_dialogContext!);
                        Get.offNamed(FILL_DATA_SCREEN);
                        _dialogContext = null;
                      }, child: const Text("Get there now"))
                ],
              ),
            ),
          );
        } , barrierDismissible: false);
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    if (_logicEventsListener != null){
      _logicEventsListener!.cancel();
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70.0,),
          const Padding(
            padding: EdgeInsets.only(left: 32.3),
            child: Text("Welcome To Your" , style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "rancho",
              fontSize: 36.0
            ),),
          ),
          const SizedBox(height: 20.0,),
          const Padding(
            padding: EdgeInsets.only(left: 155.0),
            child: Text("Dashboard" , style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "rancho",
                fontSize: 36.0
            ),),
          ),
          const SizedBox(height: 50.0,),
          Container(
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.grey , blurRadius: 5.0 , offset: Offset(0.0, 1.0))
              ]
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                    ),
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                    hintText: "Enter the dashboard email ...",
                  ),
                ),
                const SizedBox(height: 20.0,),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                    ),
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                    hintText: "Enter the password ...",
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0,),
          Center(
            child: ElevatedButton(
                onPressed: (){
                  _controller.login(_emailController.text, _passwordController.text);
                },
                child: const Text("Login")
            ),
          )
        ],
      ),
    );
  }

  String _viewLoginErrorMessage(String errorCode){
    switch(errorCode){
      case "invalid-email":{
        return "Your email is not valid";
      }
      case "user-disabled":{
        return "Your account has been disabled";
      }
      case "user-not-found":{
        return "Your account is not found please sign up first";
      }
      case "wrong-password":{
        return "This is a wrong password buddy";
      }
      case "email-not-verified":{
        return "Your email is not verified";
      }
      case "network-request-failed":{
        return "No internet";
      }
      case "invalid-inputs":{
        return "Correct the input errors first";
      }
      default:{
        throw "Error code not defined";
      }
    }
  }

}
