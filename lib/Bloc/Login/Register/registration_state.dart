abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationError extends RegistrationState {}

class RegistrationValidationError extends RegistrationState {
  String regerror;
  RegistrationValidationError({required this.regerror});
}

class RegistrationSuccess extends RegistrationState {}
