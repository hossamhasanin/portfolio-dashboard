class DataException implements Exception{
  final String code;
  final String? message;

  DataException(this.code, this.message);
}