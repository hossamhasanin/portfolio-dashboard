import 'package:equatable/equatable.dart';
import 'package:projects/logic/project_wrapper.dart';

abstract class LogicEvents extends Equatable{

  @override
  List<Object?> get props => [];
}

class ShowErrorDialog extends LogicEvents{
  final String error;

  ShowErrorDialog(this.error);

  @override
  List<Object?> get props => [error];
}

class DeleteProjectFromList extends LogicEvents{
  final ProjectWrapper projectWrapper;
  final int index;

  DeleteProjectFromList(this.projectWrapper , this.index);

  @override
  List<Object?> get props => [projectWrapper , index];
}
class InsertProjectToList extends LogicEvents{
  final int index;

  InsertProjectToList(this.index);

  @override
  List<Object?> get props => [index];
}

