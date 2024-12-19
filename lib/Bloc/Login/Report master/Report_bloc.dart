// import 'package:bloc/bloc.dart';
// import 'package:expenseapp/Bloc/Login/Report%20master/Report_event.dart';
// import 'package:expenseapp/Bloc/Login/Report%20master/Report_state.dart';
// import 'package:expenseapp/Modals/ledgermaster/ledger_modal.dart';
// import 'package:meta/meta.dart';


// class ReportBloc extends Bloc<ReportEvent, ReportState> {

//   ReportBloc() : super(LedgerInitial()) {
//       final List<Ledgermodal> allLedgers;

//     on<FilterLedgersEvent>((event, emit) {
//       final filteredLedgers = allLedgers.where((ledger) {
//         final matchesName = event.nameId == null || ledger.nameId == event.nameId;
//         final matchesType = event.typeId == null || ledger.typeId == event.typeId;
//         final matchesDate = ledger.date.isAfter(event.fromDate) && ledger.date.isBefore(event.toDate);

//         return matchesName && matchesType && matchesDate;
//       }).toList();

//       emit(LedgerFiltered(filteredLedgers));
//     });
//   }
// }
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:expenseapp/Api_repository/Ledgermaster_repo.dart';
import 'package:expenseapp/Bloc/Login/Report%20master/Report_event.dart';
import 'package:expenseapp/Bloc/Login/Report%20master/Report_state.dart';
import 'package:expenseapp/Modals/ledgermaster/ledger_modal.dart';
import 'package:http/http.dart' as http;
import 'package:expenseapp/globel_variables.dart' as global;

import 'dart:convert';
import 'dart:developer';



class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial()){
     List<Ledgermodal> ledgerrcuslist = [];
          List<Ledgermodal> filteredlist = [];

    List<Ledgermodal> searchedcus = [];


    on<ReportLoad1>((event, emit) async {
      emit(ReportLoading());

      var res = await ApiLedgerRpository()
          .getledgerdata(companyId:1);
      log(res.toString());
      if (res["status"] == "success") {
        ledgerrcuslist = res["data"];
        log(res.toString());
        emit(ReportLoaded(reportData: ledgerrcuslist));
      } else {
        emit(ReportError());
        //message = res["data"];
        //emit(CreateNameerror(errror: message));
      }
    });
     
      on<ReportLoade>((event, emit) async {
      ledgerrcuslist = global.ledgerlist.value;
        emit(ReportLoaded(reportData: ledgerrcuslist));
    });

       on<FilterReports>((event, emit) {
      if (state is ReportLoaded) {
        final List<Ledgermodal> filteredLedgerData =
            (state as ReportLoaded).reportData.where((ledger) {
          final matchesName =
              event.nameId == null || ledger.nameId == event.nameId;
          final matchesType =
              event.typeId == null || ledger.typeId == event.typeId;
          return matchesName && matchesType;
        }).toList();
        emit(ReportLoaded(reportData: filteredlist));
      }
    });

    // on<FilterReports>((event, emit) {
    //   filteredlist = ledgerrcuslist.where((item) {
    //     final matchesName = event.nameId == null || item.nameId == event.nameId;
    //     final matchesType = event.typeId == null || item.typeId == event.typeId;
    //     return matchesName && matchesType;
    //   }).toList();
    //   emit(ReportLoaded(reportData: filteredlist));
    // });
  }

  
}
