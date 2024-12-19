
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginChecking extends LoginState {}

class LoginFailed extends LoginState{}

class LoginError extends LoginState {
  String error;
  LoginError({required this.error});
}
