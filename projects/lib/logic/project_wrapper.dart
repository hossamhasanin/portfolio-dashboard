import 'dart:io';

import 'package:base/base.dart';

class ProjectWrapper {
  final Project project;
  File? pickedImage;

  ProjectWrapper(this.project, this.pickedImage);
}