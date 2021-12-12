import 'package:login/logic/business_logic_events.dart';
import 'package:login/logic/login_datasource.dart';
import 'package:base/base.dart';
class LoginUseCase {
  final LoginDataSource _dataSource;

  LoginUseCase(this._dataSource);

  Future<BusinessLogicEvent> login(String email , String password) async {
    try{
      await _dataSource.login(email, password);
      var isThereData = await _dataSource.checkIfInitDataExists();
      if (isThereData){
        return GoToMainScreenScreen();
      } else {
        return GoToFillDataScreen();
      }
    } on AuthException catch(e){
      return ShowErrorDialog(e.code);
    }
  }

}