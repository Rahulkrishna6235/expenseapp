import 'package:expenseapp/Modals/ledgermaster/ledger_modal.dart';

abstract class ReportEvent {}


class ReportLoad1 extends ReportEvent {}

class ReportLoade extends ReportEvent {
  List<Ledgermodal> users;
  ReportLoade({required this.users});
}

class FilterReports extends ReportEvent {
  final String? nameId;
  final String? typeId;

  FilterReports({this.nameId, this.typeId});
}