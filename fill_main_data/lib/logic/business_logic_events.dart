import 'package:equatable/equatable.dart';

abstract class LogicEvents extends Equatable{
  @override
  List<Object?> get props => [];
}
class ShowLoadingDialog extends LogicEvents{}
class ShowErrorDialog extends LogicEvents{
  final String error;

  ShowErrorDialog(this.error);
  @override
  List<Object?> get props => [error];
}
class GoToMainScreen extends LogicEvents{}
