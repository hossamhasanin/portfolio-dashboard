import 'dart:async';

import 'package:base/destination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash/business_logic/controller.dart';
import 'package:splash/business_logic/logic_events.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final SplashController _controller = Get.put(SplashController(Get.find()));

  BuildContext? _dialogContext;

  StreamSubscription<LogicEvents>? _listener;
  @override
  void initState() {
    super.initState();

    _controller.whereToGo();

    _listener = _controller.logicEventsStream.listen((event) {
      if (event is GoToLogin){
        Get.offNamed(LOGIN_SCREEN);
      }

      if (event is GoToMainScreen){
        Get.offNamed(MAIN_DATA_SCREEN , arguments: [event.mainData , event.skills , event.projectsNumber , event.likesNumber]);
      }

      if (event is GoToFillMainData){
        Get.offNamed(FILL_DATA_SCREEN);
      }

      if (event is ShowErrorDialog){
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
                  Text(_displayDialogErrorMessage(event.error) ,
                      style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 18.0)),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(_dialogContext!);
                        Get.offNamed(LOGIN_SCREEN);
                        _dialogContext = null;
                      }, child: const Text("Ok"))
                ],
              ),
            ),
          );
        } , barrierDismissible: false);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/dashboard_illustration.jpg" , width: 300.0,height: 300.0,),
          const SizedBox(height: 10.0,),
          const SizedBox(width: 25.0,height: 25.0 ,  child: CircularProgressIndicator())
        ],
      ),
    );
  }

  String _displayDialogErrorMessage(String errorCode){
    switch(errorCode){
      case "network-request-failed":{
        return "Sorry but no internet connection";
      }
      default:{
        throw "Not allowed error";
      }
    }
  }

  @override
  void dispose() {
    if (_listener != null){
      print("cancel");
      _listener!.cancel();

    }

    super.dispose();
  }
}
