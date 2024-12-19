import 'dart:developer';

import 'package:expenseapp/Api_repository/Ledgermaster_repo.dart';
import 'package:expenseapp/Bloc/Login/Ledger%20master/ledger_event.dart';
import 'package:expenseapp/Bloc/Login/Ledger%20master/ledger_state.dart';
import 'package:expenseapp/Bloc/Login/NameMaster/Name_event.dart';
import 'package:expenseapp/Bloc/Login/NameMaster/Name_state.dart';
import 'package:expenseapp/Bloc/Login/Report%20master/Report_state.dart';
import 'package:expenseapp/Modals/ledgermaster/ledger_modal.dart';
import 'package:expenseapp/Modals/namemaster/name_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenseapp/globel_variables.dart' as global;
import 'package:fluttertoast/fluttertoast.dart';

class LedgerBloc extends Bloc<LedgerEvent, LedgerState> {
  LedgerBloc() : super(LedgerInitial()) {
    List<Ledgermodal> ledgerrcuslist = [];
    List<Ledgermodal> searchedcus = [];
            List<Namemodal> dropNamelist = [];



    on<LedgerLoad1>((event, emit) async {
      emit(CreateLedgerloading());

      var res = await ApiLedgerRpository()
          .getledgerdata(companyId:1);
      log(res.toString());
      if (res["status"] == "success") {
        ledgerrcuslist = res["data"];
        log(res.toString());
        emit(LedgerLoaded(users: ledgerrcuslist));
      } else {
        emit(LedgerError());
        //message = res["data"];
        //emit(CreateNameerror(errror: message));
      }
    });
     
      on<LedgerLoade>((event, emit) async {
      ledgerrcuslist = global.ledgerlist.value;
      emit(LedgerLoaded(users: ledgerrcuslist));
    });

    on<DBLedgerSearch>((event, emit) {
      emit(LedgerLoading());
      if (event.keyword.isNotEmpty) {
        searchedcus.clear();
          for (var element in ledgerrcuslist) {
          if (element.description
              .toLowerCase()
              .contains(event.keyword.toLowerCase())) {
            ledgerrcuslist.add(element);
          }
        }
        emit(LedgerLoaded(users: searchedcus));
      } else {
        emit(LedgerLoaded(users: searchedcus));
      }
    });

    
   on<LedgerCreate>((event, emit) async {
      
      try{
          emit(CreateLedgerloading());
        var res = await ApiLedgerRpository()
            .createledgerDB(createledger: event.createledger);
        if (res["status"] == "success") {
          log(res['data'].toString());
          emit(CreateLedgerSucess(user: res['data'] as Ledgermodal));
          
        } else if (res["status"] == "type exist") {
          emit(CreateLedgerExist());
        } else {
          emit(CreateLedgerError(error:""));
        }
      }catch(e){
        log(e.toString());
                  emit(CreateLedgerError(error:"client error"));

      }
      
    });

on<LedgerDelete>((event, emit) async {
      emit(LedgerLoading());
      var res = await ApiLedgerRpository().deleteLedger(customerId: event.id);
      log(res.toString());
      if (res["status"] == "success") {
        // addtypelist.removeWhere((element) =>
        //     element.expenseTypeId.toString() == event.id.toString());
        // searchedTypeList.removeWhere((element) =>
        //     element.expenseTypeId.toString() == event.id.toString());
        for (int i = 0; i < ledgerrcuslist.length; i++) {
          if (ledgerrcuslist[i].ledgerId.toString() == event.id.toString()) {
            ledgerrcuslist.removeAt(i);
          }
        }
        for (int i = 0; i < global.ledgerlist.value.length; i++) {
          var current = global.ledgerlist.value[i];
          if (current.ledgerId.toString().toLowerCase() ==
              event.id.toString().toLowerCase()) {
            global.ledgerlist.value.removeAt(i);
          }
        }
        emit(LedgerLoaded(users: ledgerrcuslist));
      } else {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: "failed to delete");
        emit(LedgerLoaded(users: ledgerrcuslist));
      }
    });

    on<LedgerUpadte>((event, emit) async {
     try{
       emit(UpdateLedgerLoading());
      var res =
          await ApiLedgerRpository().updateLedger(createledger: event.updateledger);
          log(res.toString(), name: "res");
      if (res["status"] == "success") {
        emit(UpdateLedgerSuccess(
            user:res["data"] as Ledgermodal, index: event.index));

        //emit(TypeUpadteSuccess(userupdate: res["data"], index: event.id));
      } else if (res["data"] == "exist") {
        emit(UpdateLedgerExist());
      } else {
        log(res.toString(),name: "error");
        emit(UpdateLedgerError(error: res["error"].toString()));
      }
     }catch(e){
      log(e.toString());
      emit(UpdateLedgerError(error: "client error"));
     }
    });

    on<FilterReports1>((event, emit) {
      if (state is Namedrop) {
        final List<Namemodal> filteredLedgerData =
            (state as Namedrop).namesss.where((ledger) {
          final matchesName =
              event.nameId == null || ledger.nameId == event.nameId;
          
          return matchesName;
        }).toList();
        emit(Namedrop(namesss: dropNamelist));
      }
    });
  }
}
