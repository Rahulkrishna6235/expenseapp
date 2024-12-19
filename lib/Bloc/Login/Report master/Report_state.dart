import 'package:expenseapp/Modals/ledgermaster/ledger_modal.dart';

abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final List<Ledgermodal> reportData;

  ReportLoaded({required this.reportData});
}

class ReportError extends ReportState {
  
}
class ReportNoDataFound extends ReportState {
  
}
//class ReportInitail extends ReportState{}

class ReportSuccess extends ReportState{}

//class ReportLoading extends ReportState{}

class ReportFailed extends ReportState{}