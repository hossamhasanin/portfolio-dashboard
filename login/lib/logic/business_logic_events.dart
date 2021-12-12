import 'package:equatable/equatable.dart';

abstract class BusinessLogicEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowLoadingDialog extends BusinessLogicEvent{}
class ShowErrorDialog extends BusinessLogicEvent{
  final String error;

  ShowErrorDialog(this.error);

  @override
  List<Object?> get props => [error];
}
class GoToFillDataScreen extends BusinessLogicEvent{}
class GoToMainScreenScreen extends BusinessLogicEvent{}