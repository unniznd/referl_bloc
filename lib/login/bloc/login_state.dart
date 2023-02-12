import 'package:referl/login/model/login_model.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final LoginModel loginModel;
  AuthenticationAuthenticated(this.loginModel);
}

class AuthenticationFailed extends AuthenticationState {
  String? error;
  AuthenticationFailed(this.error);
}

class AuthenticationUnauthenticate extends AuthenticationState {}

class AuthenticationAuthenticating extends AuthenticationState {}
