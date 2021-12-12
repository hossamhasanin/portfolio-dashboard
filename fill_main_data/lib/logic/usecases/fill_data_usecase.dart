import 'package:base/base.dart';
import 'package:base/models/portfolio_main_data.dart';
import 'package:fill_main_data/logic/business_logic_events.dart';
import 'package:fill_main_data/logic/fill_data_datasource.dart';

class FillDataUseCase {
  final FillDataDataSource _dataSource;

  FillDataUseCase(this._dataSource);

  Future<LogicEvents> fillMainData(PortfolioMainData mainData) async {
    try {
      await _dataSource.addTheData(mainData);
      return GoToMainScreen();
    } on DataException catch (e){
      return ShowErrorDialog(e.code);
    }
  }

}