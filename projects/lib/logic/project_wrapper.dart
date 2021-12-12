import 'dart:io';

import 'package:base/base.dart';

class ProjectWrapper {
  final Project project;
  File? pickedImage;
  bool downloading;

  ProjectWrapper(this.project, this.pickedImage , {this.downloading = false});
}