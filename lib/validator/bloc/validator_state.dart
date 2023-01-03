abstract class ValidatorState {}

class ValidatorInitial extends ValidatorState {}

class ValidatorSuccessful extends ValidatorState {}

class ValidatorError extends ValidatorState {
  final String? error;
  ValidatorError(this.error);
}

class ValidatorTokenExpired extends ValidatorState {}
