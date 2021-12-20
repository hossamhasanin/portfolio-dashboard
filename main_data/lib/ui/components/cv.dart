
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:main_data/ui/components/view_pdf.dart';

class Cv extends StatelessWidget {
  final bool uploading;
  final String cvUrl;
  final Function(File) uploadCv;
  final double uploadProgress;


  const Cv({Key? key ,
    required this.uploading ,
    required this.cvUrl,
    required this.uploadCv,
    required this.uploadProgress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.grey , blurRadius: 5.0 , offset: Offset(0.0, 1.0))
          ]
      ),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text("Cv" , style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(width: 10.0,),
                  uploading ? const SizedBox(
                    width: 18.0,
                    height: 18.0,
                    child: CircularProgressIndicator(),
                  ) : Container(),
                  const SizedBox(width: 5.0,),
                  uploading ? Text(uploadProgress.toString()) : Container()
                ],
              ),
              IconButton(onPressed: () {
                _upload();
              }, icon: const Icon(Icons.add))
            ],
          ),
          const SizedBox(height: 20.0,),
          Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.blueAccent)
              ),
              child: const Text("Upload your cv in a pdf format")
          ),
          const SizedBox(height: 20.0,),
          cvUrl.isNotEmpty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: (){
                    print("open "+cvUrl);
                    Get.to(ViewPdf(cvUrl: cvUrl));
                  },
                  child: const Text("View")
              ),
              ElevatedButton(
                  onPressed: (){
                    _upload();
                  },
                  child: const Text("upload another one")
              ),
            ],
          ): Container()
        ],
      ),
    );
  }

  _upload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      uploadCv(file);
    }
  }

}
