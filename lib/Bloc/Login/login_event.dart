import 'package:expenseapp/Modal/login/login_modal.dart';

abstract class LoginEvent {}

class CheckLogin extends LoginEvent {
  LoginModal login;
  CheckLogin({required this.login});
}
