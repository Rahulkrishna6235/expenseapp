abstract class AuthenticationEvent {}

class Sendotp extends AuthenticationEvent {
  String mobilenumber;
  Sendotp({required this.mobilenumber});
}

class SumitOtpVerify extends AuthenticationEvent {
  String mobilenumber;
  String otp;
  SumitOtpVerify({required this.mobilenumber, required this.otp});
}

class ResendOtp extends AuthenticationEvent {}
