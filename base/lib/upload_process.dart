import 'package:base/upload_data.dart';

abstract class UploadProcess{
  int index;
  UploadProcess(this.index);

  Stream<UploadData> uploadStream();
  Future<bool> cancel();
  Future<String> getDownloadUrl();
}