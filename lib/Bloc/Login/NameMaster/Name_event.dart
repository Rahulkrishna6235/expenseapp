import 'package:expenseapp/Modals/namemaster/name_modal.dart';

abstract class NameMasterEvent {}

class NameLoad1 extends NameMasterEvent {
  
}

class NameCusLoad extends NameMasterEvent {
 final List<Namemodal> nameusers;
  NameCusLoad({required this.nameusers});
}

class CreateName extends NameMasterEvent {
  Namemodal createname;
  CreateName({required this.createname});
}

class DeleteName extends NameMasterEvent {
  String idd;
  DeleteName({required this.idd});
}

class UpdateName extends NameMasterEvent {
  int index;
  Namemodal updatename;
  UpdateName({required this.index, required this.updatename});
}
class NameSearch extends NameMasterEvent {}

class SearchCusName extends NameMasterEvent {
  String keyword;
  SearchCusName({required this.keyword});
}
