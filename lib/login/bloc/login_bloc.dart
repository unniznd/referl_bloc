import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/login/bloc/login_event.dart';
import 'package:referl/login/bloc/login_state.dart';

class LoginBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  LoginBloc() : super(AuthenticationUnauthenticated()) {
    on<LoggedOut>((event, emit) {
      emit(AuthenticationUnauthenticated());
    });
    on<LoggedIn>(
      (event, emit) async {
        emit(AuthenticationAuthenticated());
      },
    );
  }
}

final loginBloc = LoginBloc();
