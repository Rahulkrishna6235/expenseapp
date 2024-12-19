import 'dart:developer';

import 'package:expenseapp/Api_repository/typemaster_repo.dart';
import 'package:expenseapp/Bloc/Login/Type%20master/Type_event.dart';
import 'package:expenseapp/Bloc/Login/Type%20master/Type_state.dart';
import 'package:expenseapp/Modals/typemaster/type_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenseapp/globel_variables.dart' as global;
import 'package:fluttertoast/fluttertoast.dart';

class TypeBloc extends Bloc<TypeEvent, TypeState> {
  TypeBloc() : super(TypeInitial()) {
    List<Typemodal> addtypelist = [];
    List<Typemodal> searchedTypeList = [];
    String message;

    on<TypeLoad>((event, emit) async {
      emit(TypeLoading());
      var res = await ApiTypeRpository().gettypeDB(companyId: 1);
      //log(res.toString(), name: "dhhd");
      log(res.toString());
      if (res["status"] == "success") {
        // addtypelist = List<Typemodal>.from(
        //     res["data"].map((item) => Typemodal.fromJson(item)));

        addtypelist = res["data"];
        emit(TypeLoaded(types: addtypelist));
        // global.Typelist.value = res["data"];
        // addtypelist = res['data'];
        // log(res.toString(), name: "dhhd");
        // try {
        //   emit(CreateTypeLoaded(addtype: addtypelist));
        // } catch (e) {
        //   print(e);
        // }
      } else {
        emit(TypeError());
      }
    });

    on<Typeload1>((event, emit) async {
      addtypelist = global.typelist.value;
      emit(TypeLoaded(types: addtypelist));
    });
    ////

    on<TypeDelete>((event, emit) async {
      emit(TypeLoading());
      var res = await ApiTypeRpository().deletetype(id: event.id);
      log(res.toString());
      if (res["status"] == "success") {
        // addtypelist.removeWhere((element) =>
        //     element.expenseTypeId.toString() == event.id.toString());
        // searchedTypeList.removeWhere((element) =>
        //     element.expenseTypeId.toString() == event.id.toString());
        for (int i = 0; i < addtypelist.length; i++) {
          if (addtypelist[i].expenseTypeId.toString() == event.id.toString()) {
            addtypelist.removeAt(i);
          }
        }
        for (int i = 0; i < global.typelist.value.length; i++) {
          var current = global.typelist.value[i];
          if (current.expenseTypeId.toString().toLowerCase() ==
              event.id.toString().toLowerCase()) {
            global.typelist.value.removeAt(i);
          }
        }
        emit(TypeLoaded(types: addtypelist));
      } else {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: "failed to delete");
        emit(TypeLoaded(types: addtypelist));
      }
    });

    on<TypeUpdate>((event, emit) async {
      try {
        emit(TypeUpdateLoading());
        var res =
            await ApiTypeRpository().updatetype(updatetype: event.updateuser);
            log(res.toString(),name: "res");
        if (res["status"] == "success") {
          emit(TypeUpadteSuccess(
              userupdate: res["data"] as Typemodal, index: event.id));

        } else if (res["data"] == "exist") {
          emit(TypeUpdateExist());
        } else {
          log(res.toString(),name: "error");
          emit(TypeUpdateError(error: res["error"].toString()));
        }
      } catch (e) {
        log(e.toString());
        emit(TypeUpdateError(error: "client error"));
      }
    });

   

    on<TypeCreate>((event, emit) async {
      emit(CreateTypeLoading());
      var res = await ApiTypeRpository().createtype(createtype: event.data);
      if (res['status'] == 'success') {
        log(res['data'].toString());
        emit(CreateTypeSuccess(type: res['data'] as Typemodal));
      } else if (res['status'] == "customer exist") {
        emit(CreateTypeExist());
      } else {
        emit(CreateTypeError(message: res['error']));
      }
    });


    on<SearchType>((event, emit) async {
      emit(CreateTypeLoading());
      if (event.key.isNotEmpty) {
        searchedTypeList.clear();
        for (var element in addtypelist) {
          if (element.expenseType
              .toLowerCase()
              .contains(event.key.toLowerCase())) {
            searchedTypeList.add(element);
          }
        }
        emit(TypeLoaded(types: searchedTypeList));
      } else {
        emit(TypeLoaded(types: addtypelist));
      }
    });

    // on<TypeCreate>((event, emit) async {
    //   try {
    //     emit(TypeLoading());
    //     var res = await ApiTypeRpository().createtype(
    //       createtype: event.data,
    //     );
    //     //log(res.toString(), name: "res");
    //     if (res["status"] == "success") {
    //       log(res['data'].toString());
    //       //emit(CreateTypeSuccess(type: res["data"] as Typemodal));

    //       emit(CreateTypeSuccess(type: Typemodal.fromJson(res["data"])));
    //     } else if (res["status"] == "type exist") {
    //       emit(CreateTypeExist());
    //     } else {
    //       emit(CreateTypeError(message: ""));
    //     }
    //   } catch (e) {
    //     log(e.toString());
    //     emit(CreateTypeError(message: "Client error"));
    //   }
    // });
  }
}
