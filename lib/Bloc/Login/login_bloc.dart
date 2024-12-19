import 'dart:math';

import 'package:expenseapp/Api_repository/api_repo.dart';
import 'package:expenseapp/Bloc/Login/login_event.dart';
import 'package:expenseapp/Bloc/Login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    ApiRepository _logapi = ApiRepository();
    on<CheckLogin>((event, emit) async {
      emit((LoginChecking()));
      Map res = await _logapi.checkLogin(event.login);

      if(res ["status"] == "success"){
        

        
      }
    });
  }
}
