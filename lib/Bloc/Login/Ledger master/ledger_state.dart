import 'package:expenseapp/Modals/ledgermaster/ledger_modal.dart';
import 'package:expenseapp/Modals/namemaster/name_modal.dart';

abstract class LedgerState {}

class LedgerInitial extends LedgerState {}

class LedgerLoading extends LedgerState {}
class LedgerError extends LedgerState {}


class LedgerLoaded extends LedgerState {
   List<Ledgermodal> users;
  LedgerLoaded({required this.users});
}

class CreateLedgerloading extends LedgerState {}

class CreateLedgerExist extends LedgerState {}
class CreateSuccess extends LedgerState {}


class CreateLedgerSucess extends LedgerState {
  Ledgermodal user;
  CreateLedgerSucess({required this.user});
}

class CreateLedgerloaded extends LedgerState {
  Ledgermodal userr;
  CreateLedgerloaded({required this.userr});
}

class CreateLedgerError extends LedgerState {
  String error;
  CreateLedgerError({required this.error});
}

class UpdateLedgerLoading extends LedgerState {}

class UpdateLedgerExist extends LedgerState {}

class UpdateLedgerSuccess extends LedgerState {
  int index;
  Ledgermodal user;
  UpdateLedgerSuccess({required this.user, required this.index});
}


class UpdateLedgerError extends LedgerState {
  String error;
  UpdateLedgerError({required this.error});
}
class Namedrop extends LedgerState {
  List<Namemodal> namesss;
  Namedrop({required this.namesss});
}
