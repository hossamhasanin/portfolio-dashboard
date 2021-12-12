import 'package:equatable/equatable.dart';
import 'package:main_data/logic/controller.dart';

abstract class MainDataLogicEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class ShowLoadingDialog extends MainDataLogicEvent{}
class ShowEditingSkillsDialog extends MainDataLogicEvent{}
class ShowSkillsDoneMessage extends MainDataLogicEvent{
  final SkillsOperationMessage  skillsOperationMessage;

  ShowSkillsDoneMessage(this.skillsOperationMessage);
  @override
  List<Object?> get props => [skillsOperationMessage];
}
class CloseDialogs extends MainDataLogicEvent{}
class ShowErrorDialog extends MainDataLogicEvent{
  final String error;

  ShowErrorDialog(this.error);
  @override
  List<Object?> get props => [error];
}