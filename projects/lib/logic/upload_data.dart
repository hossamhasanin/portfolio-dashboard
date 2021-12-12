import 'package:equatable/equatable.dart';

class UploadData extends Equatable {

  final int transferredBytes;
  final int totalBytes;

  const UploadData({
    required this.transferredBytes,
    required this.totalBytes});


  @override
  List<Object?> get props => [
    transferredBytes,
    totalBytes
  ];

}