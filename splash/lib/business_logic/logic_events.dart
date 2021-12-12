import 'package:base/models/portfolio_main_data.dart';
import 'package:base/models/skill.dart';
import 'package:equatable/equatable.dart';

abstract class LogicEvents extends Equatable{
  @override
  List<Object?> get props => [];
}

class GoToMainScreen extends LogicEvents{
  final PortfolioMainData mainData;
  final List<Skill> skills;
  final int projectsNumber;
  final int likesNumber;

  GoToMainScreen(this.mainData, this.skills, this.projectsNumber , this.likesNumber);

  @override
  List<Object?> get props => [mainData , skills , projectsNumber];
}
class GoToFillMainData extends LogicEvents{}
class GoToLogin extends LogicEvents{}
class ShowErrorDialog extends LogicEvents{
  final String error;

  ShowErrorDialog(this.error);
  @override
  List<Object?> get props => [error];
}