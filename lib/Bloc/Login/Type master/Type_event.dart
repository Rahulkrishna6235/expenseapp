import 'package:expenseapp/Modals/typemaster/type_modal.dart';

abstract class TypeEvent {}

class Typeload1 extends TypeEvent {
  List<Typemodal> users;
  Typeload1({required this.users});
}

class TypeCreate extends TypeEvent {
  Typemodal data;
  TypeCreate({required this.data});
}

class TypeUpdate extends TypeEvent {
  int id;
  Typemodal updateuser;
  TypeUpdate({required this.id, required this.updateuser});
}

class TypeDelete extends TypeEvent {
  String id;
  TypeDelete({required this.id});
}

class TypeSearch extends TypeEvent {}

class TypeLoad extends TypeEvent {}

class SearchType extends TypeEvent {
  final String key;
  SearchType({required this.key});
}
