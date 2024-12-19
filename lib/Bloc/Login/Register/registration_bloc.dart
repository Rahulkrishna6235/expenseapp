import 'package:expenseapp/Bloc/Login/Register/registration_evet.dart';
import 'package:expenseapp/Bloc/Login/Register/registration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegisterBloc() : super(RegistrationInitial()) {
    on<SubmitRegister>((event, emit) async {
      emit(RegistrationLoading());
    });
  }
}
