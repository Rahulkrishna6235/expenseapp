import 'dart:developer';

import 'package:expenseapp/Api_repository/Name_repo/namemaster_repo.dart';
import 'package:expenseapp/Api_repository/typemaster_repo.dart';
import 'package:expenseapp/Bloc/Login/NameMaster/Name_event.dart';
import 'package:expenseapp/Bloc/Login/NameMaster/Name_state.dart';
import 'package:expenseapp/Modals/namemaster/name_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenseapp/globel_variables.dart' as global;
import 'package:fluttertoast/fluttertoast.dart';

class NameBloc extends Bloc<NameMasterEvent, NameMasterState> {
  NameBloc() : super(NameInitial()) {
    List<Namemodal> nameList = [];
        List<Namemodal> searchedNameList = [];
            List<Namemodal> dropNamelist = [];



    on<NameLoad1>((event, emit) async {
      emit(NameLoading());

      var res = await ApiNameRepository().getNameDB(companyId: 1);
      log(res.toString());
      if (res["status"] == "success") {
        nameList = res["data"];
        log(res.toString());
        emit(NameLoaded(names: nameList));
      } else {
        emit(NameError());
        //message = res["data"];
        //emit(CreateNameerror(errror: message));
      }
    });

    on<NameCusLoad>((event, emit) async {
      nameList = global.namelist.value;
      emit(NameLoaded(names: nameList));
    });

    on<CreateName>((event, emit) async {
      
        emit(CreateNameLoading());
        var res = await ApiNameRepository()
            .createNameDB(createname: event.createname);
        if (res["status"] == "success") {
          log(res['data'].toString());
          emit(CreateNameSuccess(username: res['data'] as Namemodal));
          //emit(CreateTypeSuccess(type: res["data"] as Typemodal));
          //emit(CreateNameSuccess(username: Namemodal.fromJson(res["data"])));
        } else if (res["status"] == "type exist") {
          emit(CreateNameExist());
        } else {
          emit(CreateNameerror(errror: res["error"]));
        }
      
    });

    on<SearchCusName>((event, emit) async {
      emit(CreateNameLoading());
      if (event.keyword.isNotEmpty) {
        searchedNameList.clear();
        for (var element in nameList) {
          if (element.name
              .toLowerCase()
              .contains(event.keyword.toLowerCase())) {
            searchedNameList.add(element);
          }
        }
        emit(NameLoaded(names: searchedNameList));
      } else {
        emit(NameLoaded(names: nameList));
      }
    });

    on<DeleteName>((event, emit) async {
      emit(NameLoading());
      var res = await ApiNameRepository().deleteName(userId: event.idd);
      log(res.toString());
      if (res["status"] == "success") {
         for (int i = 0; i < nameList.length; i++) {
          if (nameList[i].nameId.toString() == event.idd.toString()) {
            nameList.removeAt(i);
          }
        }
        for (int i = 0; i < global.namelist.value.length; i++) {
          var current = global.namelist.value[i];
          if (current.nameId.toString().toLowerCase() ==
              event.idd.toString().toLowerCase()) {
            global.namelist.value.removeAt(i);
          }
        }
        emit(CreateNameLoaded(nameuser: nameList));
      } else {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: "failed to delete");
        emit(CreateNameLoaded(nameuser: nameList));
      }
    });

    on<UpdateName>((event, emit) async {
      try{
        emit(NameUpdateLoading());
      var res =
          await ApiNameRepository().updateDBname(createname: event.updatename);
                      log(res.toString(),name: "res");

      if (res["status"] == "success") {
        emit(NameUpdateSucess(
            nameUpdate: res["data"] as Namemodal, index: event.index));

        //emit(TypeUpadteSuccess(userupdate: res["data"], index: event.id));
      } else if (res["data"] == "exist") {
        emit(NameUpdateExist());
      } else {
        log(res.toString(),name: "error");
        emit(NameUpdateError(errorupdate: res["error"].toString()));
      }
      }catch(e){
        log(e.toString());
        emit(NameUpdateError(errorupdate: "client error"));
      }
    });

     
  }
}
