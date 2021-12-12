abstract class LoginDataSource{
  Future login(String email , String password);
  Future<bool> checkIfInitDataExists();
}