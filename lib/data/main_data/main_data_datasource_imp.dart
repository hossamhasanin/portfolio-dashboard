import 'dart:io';

import 'package:base/base.dart';
import 'package:base/models/portfolio_main_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:main_data/logic/main_data_datasource.dart';
import 'package:portfolio_dashboard/data/upload_process/upload_process_imp.dart';

class MainDataDataSourceImp implements MainDataDataSource{

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future updateMainData(PortfolioMainData mainData) {
    var query = _fireStore.collection(MAIN_DATA_COLLECTION).doc("1");

    Map<String , dynamic> map = {};
    mainData.toMap().forEach((key, value) {
      if (value != ""){
        map[key] = value;
      }
    });
    return query.update(map);
  }

  @override
  Future<String> uploadImage(File image) async {
    var storageReference = _firebaseStorage
        .ref()
        .child('users_images')
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    try {
      await storageReference.putFile(image);

      var fileURL = await storageReference.getDownloadURL();
      return fileURL;
    } on FirebaseException catch (e) {
      throw DataException(e.code, e.message);
    }
  }

  @override
  Future<Skill> addSkill(Skill skill) async {
    skill.id = DateTime.now().millisecondsSinceEpoch.toString();
    var query = _fireStore.collection(SKILLS_COLLECTION).doc(skill.id);
    await query.set(skill.toMap());
    return skill;
  }

  @override
  Future updateSkill(Skill skill) {
    var query = _fireStore.collection(SKILLS_COLLECTION).doc(skill.id);

    return query.update(skill.toMap());
  }

  @override
  Future deleteSkill(Skill skill) {
    var query = _fireStore.collection(SKILLS_COLLECTION).doc(skill.id);

    return query.delete();
  }

  @override
  UploadProcess uploadCv(File cv) {
    var storageReference = _firebaseStorage
        .ref()
        .child('cvs')
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    try {
      return UploadProcessImp(storageReference.putFile(cv), storageReference);
    } on FirebaseException catch (e) {
      throw DataException(e.code, e.message);
    }
  }

}