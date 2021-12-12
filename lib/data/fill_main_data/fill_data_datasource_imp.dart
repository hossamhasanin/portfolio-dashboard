import 'package:base/base.dart';
import 'package:base/models/portfolio_main_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fill_main_data/logic/fill_data_datasource.dart';

class FillDataDataSourceImp implements FillDataDataSource {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future addTheData(PortfolioMainData portfolioMainData) {
    try {
      var query = _firestore.collection(MAIN_DATA_COLLECTION).doc("1");

      return query.set(portfolioMainData.toMap());
    } on FirebaseException catch(e){
      throw DataException(e.code, e.message);
    }
  }
}