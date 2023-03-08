import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/login/api/login_api.dart';
import 'package:referl/login/bloc/login_event.dart';
import 'package:referl/login/bloc/login_state.dart';
import 'package:referl/login/model/login_model.dart';
import 'package:referl/main.dart';

class LoginBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  LoginBloc() : super(AuthenticationInitial()) {
    final LoginApiProvider apiProvider = LoginApiProvider();
    on<LoginUser>((event, emit) async {
      emit(AuthenticationAuthenticating());

      try {
        final res =
            await apiProvider.authenticate(event.username, event.password);
        if (res.errorMsg != null) {
          emit(AuthenticationFailed(res.errorMsg));
        } else {
          await storage.write(key: "token", value: res.authToken);
          emit(AuthenticationAuthenticated(res));
        }
      } catch (e) {
        emit(AuthenticationFailed("Failed to fetch data"));
      }
    });
    on<LogoutUser>(
      (event, emit) async {
        emit(AuthenticationUnauthenticate());
      },
    );
    on<IsAuthenticated>((event, emit) async {
      emit(AuthenticationInitial());
      final token = await storage.read(key: "token");

      if (token == null) {
        emit(AuthenticationUnauthenticate());
      } else {
        emit(AuthenticationAuthenticated(
          LoginModel.fromJson({"token": token}),
        ));
      }
    });
  }
}

final loginBloc = LoginBloc();
