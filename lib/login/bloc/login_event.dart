abstract class AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String token;
  LoggedIn({required this.token});
}

class LoggedOut extends AuthenticationEvent {}
