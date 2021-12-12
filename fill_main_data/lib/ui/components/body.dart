import 'dart:async';

import 'package:base/destination.dart';
import 'package:fill_main_data/logic/business_logic_events.dart';
import 'package:fill_main_data/logic/controller.dart';
import 'package:fill_main_data/logic/validation_errors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _careerController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FillDataController _controller = Get.put(FillDataController(Get.find()));
  BuildContext? _dialogContext;

  StreamSubscription<LogicEvents>? _logicEventsListener;

  @override
  void initState() {
    super.initState();

    _logicEventsListener = _controller.logicEventsStream.listen((event) {
      if (_dialogContext != null){
        Navigator.pop(_dialogContext!);
        _dialogContext = null;
      }

      if (event is ShowLoadingDialog){
        _dialogContext = Get.overlayContext;
        showDialog(context: _dialogContext!, builder: (_){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              height: 150.0,
              width: 300.0,
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
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
            child: Container(
              height: 200.0,
              width: 300.0,
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(_displayDialogErrorMessage(event.error) ,
                    style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 18.0)),
              ),
            ),
          );
        });
      }

      if (event is GoToMainScreen){
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
                  const Text("Completed successfully" ,
                      style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18.0)),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(_dialogContext!);
                        Get.offNamed(MAIN_DATA_SCREEN);
                        _dialogContext = null;
                      }, child: const Text("Done"))
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
            padding: EdgeInsets.only(left: 30.0),
            child: Text("Complete the main data" , style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
            ),),
          ),
          const SizedBox(height: 30.0,),
          Container(
            margin: const EdgeInsets.all(20.0),
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
                Obx((){
                    return TextField(
                      controller: _fullNameController,
                      onChanged: (text){
                        _controller.enterName(text);
                      },
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                        ),
                        border: const OutlineInputBorder(),
                        label: const Text("Name"),
                        hintText: "Enter your full name ...",
                        errorText: _controller.viewState.value.nameError != ValidationErrors.NONE ? _displayInputsErrorMessage(_controller.viewState.value.nameError): null
                      ),
                    );
                  }
                ),
                const SizedBox(height: 20.0,),
                Obx((){
                    return TextField(
                      controller: _careerController,
                      onChanged: (text){
                        _controller.enterCareer(text);
                      },
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                        ),
                        border: const OutlineInputBorder(),
                        label: const Text("Career"),
                        hintText: "Enter your career title ...",
                        errorText: _controller.viewState.value.careerError != ValidationErrors.NONE ? _displayInputsErrorMessage(_controller.viewState.value.careerError): null
                      ),
                    );
                  }
                ),
                const SizedBox(height: 20.0,),
                Obx(() {
                    return TextField(
                      controller: _descriptionController,
                      onChanged: (text){
                        _controller.enterDescription(text);
                      },
                      maxLines: 4,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                        ),
                        border: const OutlineInputBorder(),
                        label: const Text("Description"),
                        hintText: "Enter a description about you ...",
                        errorText: _controller.viewState.value.descriptionError != ValidationErrors.NONE ? _displayInputsErrorMessage(_controller.viewState.value.descriptionError): null

                      ),
                    );
                  }
                ),
                const SizedBox(height: 20.0,),
                Obx(() {
                    return TextField(
                      controller: _emailController,
                      onChanged: (text){
                        _controller.enterEmail(text);
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                        ),
                        border: const OutlineInputBorder(),
                        label: const Text("Email"),
                        hintText: "Enter your business email ...",
                        errorText: _controller.viewState.value.emailError != ValidationErrors.NONE ? _displayInputsErrorMessage(_controller.viewState.value.emailError): null
                      ),
                    );
                  }
                ),
                const SizedBox(height: 20.0,),
                Obx(() {
                    return TextField(
                      controller: _phoneController,
                      onChanged: (text){
                        _controller.enterPhone(text);
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                        ),
                        border: const OutlineInputBorder(),
                        label: const Text("Phone"),
                        hintText: "Enter your phone number...",
                        errorText: _controller.viewState.value.phoneError != ValidationErrors.NONE ? _displayInputsErrorMessage(_controller.viewState.value.phoneError): null
                      ),
                    );
                  }
                ),
                const SizedBox(height: 20.0,),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: (){
                  _controller.addData();
                },
                child: const Text("Done")
            ),
          )
        ],
      ),
    );
  }

  String _displayInputsErrorMessage(ValidationErrors validationError){
    switch(validationError){
      case ValidationErrors.EMPTY_ENTRY:{
        return "You cann't leave that empty";
      }
      case ValidationErrors.EMAIL_NOT_VALID:{
        return "Write a valid email dude";
      }
      case ValidationErrors.SHORT_ENTRY:{
        return "This is so short dude";
      }
      default:{
        throw "Not allowed error";
      }
    }
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

}
