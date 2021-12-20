import 'dart:io';

import 'package:base/base.dart';
import 'package:base/models/project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:portfolio_dashboard/data/upload_process/upload_process_imp.dart';
import 'package:projects/logic/projects_datasource.dart';
import 'package:base/upload_process.dart';

class ProjectsDataSourceImp implements ProjectsDataSource{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future addProject(Project project) {
    var query = _firestore.collection(PROJECTS_COLLECTION);
    return query.doc(project.id!).set(project.toMap());
  }

  @override
  Future deleteProject(Project project) {
    var query = _firestore.collection(PROJECTS_COLLECTION).doc(project.id);
    return query.delete();
  }

  @override
  Future<List<Project>> getProjects() async {
    var query = await _firestore.collection(PROJECTS_COLLECTION).orderBy("id" , descending: true).get();
    return query.size > 0 ? query.docs.map((doc) => Project.fromMap(doc.data())).toList() : [];
  }

  @override
  Future updateProject(Project project) {
    var query = _firestore.collection(PROJECTS_COLLECTION);
    return query.doc(project.id!).update(project.toMap());
  }

  @override
  UploadProcess uploadImage(File image) {
      var storageReference = _firebaseStorage
          .ref()
          .child('projects_images')
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      try {
        return UploadProcessImp(storageReference.putFile(image), storageReference);
      } on FirebaseException catch (e) {
        throw DataException(e.code, e.message);
      }
  }

  // @override
  // Future<String> uploadImage(File image) async {
  //   var storageReference = _firebaseStorage
  //       .ref()
  //       .child('projects_images')
  //       .child(DateTime.now().millisecondsSinceEpoch.toString());
  //
  //   try {
  //     await storageReference.putFile(image);
  //
  //     var fileURL = await storageReference.getDownloadURL();
  //     return fileURL;
  //   } on FirebaseException catch (e) {
  //     throw DataException(e.code, e.message);
  //   }
  // }

}