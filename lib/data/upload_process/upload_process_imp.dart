import 'package:firebase_storage/firebase_storage.dart';
import 'package:base/upload_process.dart';
import 'package:base/upload_data.dart';

class UploadProcessImp implements UploadProcess{

  final UploadTask _uploadTask;
  final Reference _reference;
  int _index = -1;

  UploadProcessImp(this._uploadTask , this._reference);

  @override
  Future<bool> cancel() {
    return _uploadTask.cancel();
  }

  @override
  Stream<UploadData> uploadStream() {
    return _uploadTask.asStream().map((task) => UploadData(transferredBytes: task.bytesTransferred , totalBytes: task.totalBytes));
  }

  @override
  Future<String> getDownloadUrl() {
    return _reference.getDownloadURL();
  }

  @override
  set index(int index){
    _index = index;
  }

  @override
  int get index => _index;


}