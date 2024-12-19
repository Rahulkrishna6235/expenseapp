import 'dart:async';

import 'package:expenseapp/Bloc/Login/Authentication/Auth_event.dart';
import 'package:expenseapp/Bloc/Login/Authentication/Auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class otpBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  otpBloc() : super(OtpAuthInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is Sendotp) {
        emit(OtpAuthLoading());
        try {
          var response = await http
              .post(Uri.parse(""), body: {'phone': event.mobilenumber});

          if (response.statusCode == 200) {
            emit(OtpAuthsend());
          } else {
            emit(OtpAuthFaild(otperror: "failed to otp "));
          }
        } catch (e) {
          OtpAuthFaild(otperror: e.toString());
        }
      }
    });
  }
}
