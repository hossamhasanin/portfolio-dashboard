import 'package:base/base.dart';
import 'package:base/models/portfolio_main_data.dart';
import 'package:base/models/skill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splash/business_logic/splash_datasource.dart';

class SplashDataSourceImp implements SplashDataSource{

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<PortfolioMainData?> getMainData() async {
    var query = await _fireStore.collection(MAIN_DATA_COLLECTION).doc("1").get();

    return query.exists ? PortfolioMainData.fromMap(query.data()!) : null;
  }

  @override
  Future<int> getProjectsNumber() async {
    var query = await _fireStore.collection(PROJECTS_COLLECTION).get();

    return query.size;
  }

  @override
  Future<List<Skill>> getSkills() async {
    var query = await _fireStore.collection(SKILLS_COLLECTION).get();

    print("koko "+query.size.toString());
    return query.size > 0 ? query.docs.map((doc) => Skill.fromMap(doc.data())).toList() : [];
  }

  @override
  Future<bool> isLoggedIn() async {
    return _auth.currentUser != null;
  }

  @override
  Future<int> getLikesNumber() async {
    var query = await _fireStore.collection(LIKES_COLLECTION).get();

    return query.size;
  }
}