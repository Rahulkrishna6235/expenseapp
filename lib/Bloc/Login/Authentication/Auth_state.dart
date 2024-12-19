abstract class AuthenticationState {}

class OtpAuthInitial extends AuthenticationState {}

class OtpAuthVerify extends AuthenticationState {}

class OtpAuthsend extends AuthenticationState {}


class OtpAuthLoading extends AuthenticationState {}

class OtpAuthFaild extends AuthenticationState {
  String otperror;
  OtpAuthFaild({required this.otperror});
}


