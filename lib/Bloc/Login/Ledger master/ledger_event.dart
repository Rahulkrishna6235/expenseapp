import 'package:expenseapp/Modals/ledgermaster/ledger_modal.dart';

abstract class LedgerEvent {}

class LedgerLoad1 extends LedgerEvent {}

class LedgerLoade extends LedgerEvent {
  List<Ledgermodal> users;
  LedgerLoade({required this.users});
}

class LedgerCreate extends LedgerEvent {
  Ledgermodal createledger;
  LedgerCreate({required this.createledger});
}

class LedgerUpadte extends LedgerEvent {
  int index;
  Ledgermodal updateledger;
  LedgerUpadte({required this.updateledger, required this.index});
}

class LedgerDelete extends LedgerEvent {
  String id;
  LedgerDelete({required this.id});
}

class DBLedgerSearch extends LedgerEvent {
  String keyword;
  DBLedgerSearch({required this.keyword});
}
class FilterReports1 extends LedgerEvent {
  final String? nameId;
  
  FilterReports1({this.nameId,});
}
class FilterReports2 extends LedgerEvent {
 
  final String? typeId;

  FilterReports2({ this.typeId});
}

