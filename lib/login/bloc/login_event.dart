abstract class AuthenticationEvent {}

class LoginUser extends AuthenticationEvent {
  final String username;
  final String password;
  LoginUser({
    required this.username,
    required this.password,
  });
}

class LogoutUser extends AuthenticationEvent {}

class IsAuthenticated extends AuthenticationEvent {}
