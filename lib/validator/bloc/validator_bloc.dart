import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/validator/bloc/validator_event.dart';
import 'package:referl/validator/bloc/validator_state.dart';
import 'package:referl/validator/repo/validator_repo.dart';

class ValidatorBloc extends Bloc<ValidatorEvent, ValidatorState> {
  ValidatorBloc() : super(ValidatorInitial()) {
    final ValidatorRepo validatorRepo = ValidatorRepo();
    on<AddReferral>(
      (event, emit) async {
        final res = await validatorRepo.addReferral(
          event.platform,
          event.refCode,
          event.phone,
          event.amount,
        );
        if (res == "OK") {
          emit(ValidatorSuccessful());
        } else if (res == "LOGGED_OUT") {
          emit(ValidatorTokenExpired());
        } else {
          emit(ValidatorError(res));
        }
      },
    );
  }
}
