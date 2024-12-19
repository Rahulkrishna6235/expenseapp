import 'package:expenseapp/Modals/typemaster/type_modal.dart';

abstract class TypeState {}

class TypeInitial extends TypeState {}

class TypeLoading extends TypeState {}
class TypeError extends TypeState {}


class TypeLoaded extends TypeState {
 final List<Typemodal> types;
  TypeLoaded({required this.types});
}

class CreateTypeExist extends TypeState {}

class CreateSucess extends TypeState {}
class CreateTypeLoading extends TypeState {}


class CreateTypeLoaded extends TypeState {
  final List<Typemodal> addtype;
  CreateTypeLoaded({required this.addtype});
}

class CreateTypeSuccess extends TypeState {
  Typemodal type;
  CreateTypeSuccess({required this.type});
}

class CreateTypeError extends TypeState {
  String message;
  CreateTypeError({required this.message});
}

class TypeUpdateLoading extends TypeState {}


class TypeUpadteSuccess extends TypeState {
  Typemodal userupdate;
  int index;
  TypeUpadteSuccess({required this.userupdate, required this.index});
}

class TypeUpdateError extends TypeState {
  final String error;
  TypeUpdateError({required this.error});
}

class TypeUpdateExist extends TypeState {}
