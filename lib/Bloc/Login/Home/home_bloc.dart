import 'package:expenseapp/Bloc/Login/Home/home_event.dart';
import 'package:expenseapp/Bloc/Login/Home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on((event, emit) {});
  }
}
