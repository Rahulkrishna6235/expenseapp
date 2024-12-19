import 'package:expenseapp/Modals/namemaster/name_modal.dart';

abstract class NameMasterState {}

class NameInitial extends NameMasterState {}

class NameLoading extends NameMasterState {}

class NameError extends NameMasterState {}

class NameLoaded extends NameMasterState {
  List<Namemodal> names;
  NameLoaded({required this.names});
}

class CreateNameLoading extends NameMasterState {}

class CreateNameLoaded extends NameMasterState {
  final List<Namemodal> nameuser;
  CreateNameLoaded({required this.nameuser});
}

class CreateNameExist extends NameMasterState {}

class CreatSuccess extends NameMasterState {}

class CreateNameSuccess extends NameMasterState {
  Namemodal username;
  CreateNameSuccess({required this.username});
}

class CreateNameerror extends NameMasterState {
  String errror;
  CreateNameerror({required this.errror});
}

class NameUpdateLoading extends NameMasterState {}

class NameUpdateExist extends NameMasterState {}

class NameUpdateSucess extends NameMasterState {
  int index;
  Namemodal nameUpdate;
  NameUpdateSucess({required this.nameUpdate,required this.index, });
}

class NameUpdateError extends NameMasterState {
  String errorupdate;
  NameUpdateError({required this.errorupdate});
}
