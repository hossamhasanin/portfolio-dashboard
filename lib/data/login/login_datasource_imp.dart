import 'package:base/base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/logic/login_datasource.dart';

class LoginDataSourceImp implements LoginDataSource{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> checkIfInitDataExists() async {
    var query = await _firestore.collection(MAIN_DATA_COLLECTION).doc("1").get();

    return query.exists;
  }

  @override
  Future login(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

}